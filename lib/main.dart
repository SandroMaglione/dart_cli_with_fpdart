import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dart_cli_with_fpdart/cli_error.dart';
import 'package:dart_cli_with_fpdart/cli_options.dart';
import 'package:dart_cli_with_fpdart/import_match.dart';
import 'package:dart_cli_with_fpdart/layer.dart';
import 'package:fpdart/fpdart.dart';
import 'package:yaml/yaml.dart';

extension on Uri {
  String get fileExtension => toString().split('.').last;
}

// TODO: Verify possible import formats (e.g. "import 'package" or "import './")
final importRegex = RegExp(r"""^import ['"](?<path>.+)['"];$""");

void program =
    (List<String> arguments) => ReaderTaskEither<MainLayer, CliError, void>.Do(
          (_) async {
            final cliOptions = await _(
              ReaderTaskEither(
                (layer) =>
                    layer.argumentsParser.parse(arguments).toTaskEither().run(),
              ),
            );

            final packageName = await _(
              ReaderTaskEither(
                (layer) => layer.configReader.packageName(cliOptions).run(),
              ),
            );
          },
        );

Future<String> packageName(CliOptions cliOptions) async {
  final pubspec = File(cliOptions.pubspecPath);
  final fileContent = await pubspec.readAsString();
  final yamlContent = loadYaml(fileContent);
  final projectName = yamlContent['name'];
  return projectName;
}

TaskEither<CliError, (List<ImportMatch>, HashSet<ImportMatch>)> listFilesLibDir(
  CliOptions cliOptions,
) =>
    TaskEither.tryCatch(
      () async {
        final projectName = await packageName(cliOptions);
        final dir = Directory("lib"); // TODO: Specify directory in settings
        final appFileList = <ImportMatch>[];
        final imports = HashSet<ImportMatch>();

        final dirList = dir.list(recursive: true);
        await for (final file in dirList) {
          if (file is File && file.uri.fileExtension == "dart") {
            imports.addAll(await readImports(file, projectName));

            appFileList.add(ImportMatch.relative(file));
          }
        }

        return (appFileList, imports);
      },
      ReadFilesError.new,
    );

Future<List<ImportMatch>> readImports(File file, String projectName) async {
  final projectPackage = "package:$projectName";

  final linesStream = file
      .openRead()
      .transform(
        utf8.decoder,
      )
      .transform(
        LineSplitter(),
      );
  final importList = <ImportMatch>[];

  await for (final line in linesStream) {
    if (line.isEmpty) continue;

    final path = importRegex.firstMatch(line)?.namedGroup("path");

    /// `package:` refers to `lib`
    if (path != null) {
      if (path.startsWith(projectPackage)) {
        importList.add(
          ImportMatch(
            path.replaceFirst(projectPackage, ""),
          ),
        );
      }
    } else {
      break; // Assume all imports are declared first
    }
  }

  return importList;
}
