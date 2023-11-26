import 'dart:io';

import 'package:yaml/yaml.dart';

final class CliOptions {
  final String pubspecPath;
  const CliOptions._(this.pubspecPath);

  factory CliOptions.init() {
    final options = File("cli_options.yaml");

    if (options.existsSync()) {
      final fileContent = options.readAsStringSync();
      final yamlContent = loadYaml(fileContent);
      final pubspecPath = yamlContent?['pubspec_path'] ?? "pubspec.yaml";
      return CliOptions._(pubspecPath);
    } else {
      return CliOptions._("pubspec.yaml");
    }
  }
}
