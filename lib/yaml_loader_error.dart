sealed class YamlLoaderError {
  const YamlLoaderError();
}

final class MissingFile extends YamlLoaderError {}

final class ReadingFileAsStringError extends YamlLoaderError {}

final class ParsingFailed extends YamlLoaderError {}
