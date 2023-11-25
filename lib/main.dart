import 'dart:convert';
import 'dart:io';

import 'package:dart_cli_with_fpdart/cli_error.dart';
import 'package:dart_cli_with_fpdart/import_match.dart';
import 'package:fpdart/fpdart.dart';

extension on Uri {
  String get fileExtension => toString().split('.').last;
}

// TODO: Verify possible import formats (e.g. "import 'package" or "import './")
final importRegex = RegExp(r"""^import ['"](?<path>.+)['"];$""");

TaskEither<CliError, List<File>> listFilesCurrentDir = TaskEither.tryCatch(
  () async {
    final dir = Directory.current;
    final fileList = <File>[];

    final dirList = dir.list(recursive: true);
    await for (final FileSystemEntity f in dirList) {
      if (f is File && f.uri.fileExtension == "dart") {
        fileList.add(f);
      }
    }

    return fileList;
  },
  ReadFilesError.new,
);

TaskEither<CliError, List<ImportMatch>> readImports(File file) =>
    TaskEither.tryCatch(
      () async {
        final linesStream =
            file.openRead().transform(utf8.decoder).transform(LineSplitter());
        final importList = <ImportMatch>[];

        await for (var line in linesStream) {
          final path = importRegex.firstMatch(line)?.namedGroup("path");
          if (path != null) {
            importList.add(ImportMatch(path: path, file: file));
          } else {
            break; // Assume all imports are declared first
          }
        }

        return importList;
      },
      ReadFileImportsError.new,
    );


// TODO: Build an efficient data structure (Tree-like) to scan unused files