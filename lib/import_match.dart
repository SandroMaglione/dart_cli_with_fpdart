final class ImportMatch {
  final String path; // TODO: Parse (validate) this path
  const ImportMatch(this.path);

  @override
  String toString() {
    return 'import "$path";';
  }
}
