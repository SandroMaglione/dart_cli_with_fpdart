sealed class YamlLoaderError {
  const YamlLoaderError();
  String get errorMessage;

  @override
  String toString() {
    return errorMessage;
  }
}

final class MissingFile extends YamlLoaderError {
  final String path;
  const MissingFile(this.path);

  @override
  String get errorMessage => "Missing file error at path: '$path'";
}

final class ReadingFileAsStringError extends YamlLoaderError {
  const ReadingFileAsStringError();

  @override
  String get errorMessage => "Error while reading file content as string";
}

final class ParsingFailed extends YamlLoaderError {
  final Object error;
  final StackTrace stackTrace;
  const ParsingFailed(this.error, this.stackTrace);

  @override
  String get errorMessage => "Error while parsing yaml: $error";
}
