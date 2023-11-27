import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dart_cli_with_fpdart/cli_error.dart';
import 'package:dart_cli_with_fpdart/import_match.dart';
import 'package:fpdart/fpdart.dart';

extension on Uri {
  String get _fileExtension => toString().split('.').last;
}

abstract final class FileReader {
  const FileReader();
  TaskEither<
      CliError,
      ({
        List<ImportMatch> fileList,
        HashSet<ImportMatch> importSet,
      })> listFilesLibDir(String packageName);
}

final class FileReaderImpl implements FileReader {
  static final _importRegex = RegExp(r"""^import ['"](?<path>.+)['"];$""");

  @override
  TaskEither<
      CliError,
      ({
        List<ImportMatch> fileList,
        HashSet<ImportMatch> importSet,
      })> listFilesLibDir(String packageName) => TaskEither.tryCatch(
        () async {
          final dir = Directory("lib");

          final fileList = <ImportMatch>[];
          final importSet = HashSet<ImportMatch>();

          final dirList = dir.list(recursive: true);
          await for (final file in dirList) {
            if (file is File && file.uri._fileExtension == "dart") {
              importSet.addAll(await _readImports(file, packageName));

              fileList.add(ImportMatch.relative(file));
            }
          }

          return (fileList: fileList, importSet: importSet);
        },
        ReadFilesError.new,
      );

  Future<List<ImportMatch>> _readImports(File file, String packageName) async {
    final projectPackage = "package:$packageName";

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

      final path = _importRegex.firstMatch(line)?.namedGroup("path");

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
}
