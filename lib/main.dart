import 'package:dart_cli_with_fpdart/cli_error.dart';
import 'package:dart_cli_with_fpdart/import_match.dart';
import 'package:dart_cli_with_fpdart/layer.dart';
import 'package:fpdart/fpdart.dart';

ReaderTaskEither<MainLayer, CliError,
    (Iterable<ImportMatch>, Iterable<ImportMatch>)> program(
        List<String> arguments) =>
    ReaderTaskEither<MainLayer, CliError,
        (Iterable<ImportMatch>, Iterable<ImportMatch>)>.Do(
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

        final imports = await _(
          ReaderTaskEither(
            (layer) => layer.fileReader.listFilesLibDir(packageName).run(),
          ),
        );

        return imports.$1.partition(
          (appFile) => imports.$2.contains(appFile),
        );
      },
    );
