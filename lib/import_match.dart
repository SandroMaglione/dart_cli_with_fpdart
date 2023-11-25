import 'dart:io';

final class ImportMatch {
  final File file;
  final String path; // TODO: Parse (validate) this path
  const ImportMatch({required this.path, required this.file});

  /// TODO: Do not access [Directory.current] directly
  String get relativePath => file.uri.toString().replaceFirst(
        Directory.current.uri.toString(),
        "",
      );

  List<String> get pathList => relativePath.split("/");

  @override
  String toString() {
    return pathList.toString();
  }
}
