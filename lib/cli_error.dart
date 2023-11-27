import 'package:dart_cli_with_fpdart/yaml_loader_error.dart';

sealed class CliError {
  const CliError();
}

class InvalidArgumentsError extends CliError {
  final Object error;
  final StackTrace stackTrace;
  const InvalidArgumentsError(this.error, this.stackTrace);
}

class LoadYamlOptionsError extends CliError {
  final YamlLoaderError yamlLoaderError;
  const LoadYamlOptionsError(this.yamlLoaderError);
}

class MissingPackageNameError extends CliError {
  final String path;
  const MissingPackageNameError(this.path);
}

class ReadFilesError extends CliError {
  final Object error;
  final StackTrace stackTrace;
  const ReadFilesError(this.error, this.stackTrace);
}

class ReadFileImportsError extends CliError {
  final Object error;
  final StackTrace stackTrace;
  const ReadFileImportsError(this.error, this.stackTrace);
}
