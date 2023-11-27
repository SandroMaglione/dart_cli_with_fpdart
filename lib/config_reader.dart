import 'package:dart_cli_with_fpdart/cli_error.dart';
import 'package:dart_cli_with_fpdart/cli_options.dart';
import 'package:dart_cli_with_fpdart/yaml_loader.dart';
import 'package:fpdart/fpdart.dart';

abstract final class ConfigReader {
  const ConfigReader();
  TaskEither<CliError, String> packageName(CliOptions cliOptions);
}

final class ConfigReaderImpl implements ConfigReader {
  final YamlLoader _yamlLoader;
  const ConfigReaderImpl(this._yamlLoader);

  @override
  TaskEither<CliError, String> packageName(CliOptions cliOptions) =>
      TaskEither.Do(
        (_) async {
          final yamlContent = await _(
            _yamlLoader
                .loadFromPath(cliOptions.pubspecPath)
                .mapLeft(LoadYamlOptionsError.new),
          );

          return _(
            TaskEither.tryCatch(
              () => yamlContent["name"],
              (error, stackTrace) => MissingPackageNameError(),
            ),
          );
        },
      );
}
