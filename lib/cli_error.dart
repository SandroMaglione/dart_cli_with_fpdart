sealed class CliError {
  const CliError();
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
