import 'package:dart_cli_with_fpdart/cli_error.dart';
import 'package:dart_cli_with_fpdart/import_match.dart';
import 'package:dart_cli_with_fpdart/layer.dart';
import 'package:fpdart/fpdart.dart';

typedef FileUsage = ({
  Iterable<ImportMatch> unused,
  Iterable<ImportMatch> used,
  ImportMatch entry,
});

ReaderTaskEither<MainLayer, CliError, FileUsage> program(
        List<String> arguments) =>
    ReaderTaskEither<MainLayer, CliError, FileUsage>.Do(
      (_) async {
        final layer = await _(ReaderTaskEither.ask());

        final cliOptions = await _(
          ReaderTaskEither.fromIOEither(
            layer.argumentsParser.parse(arguments),
          ),
        );

        final packageName = await _(
          ReaderTaskEither.fromTaskEither(
            layer.configReader.packageName(cliOptions),
          ),
        );

        final entry = ImportMatch(cliOptions.entry);
        final readFile = await _(
          ReaderTaskEither.fromTaskEither(
            layer.fileReader.listFilesLibDir(packageName, entry),
          ),
        );

        final fileUsage = readFile.fileList.partition(
          (projectFile) => readFile.importSet.contains(projectFile),
        );

        return (
          unused: fileUsage.$1,
          used: fileUsage.$2,
          entry: entry,
        );
      },
    );
