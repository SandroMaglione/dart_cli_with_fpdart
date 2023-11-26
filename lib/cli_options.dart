import 'dart:io';

import 'package:yaml/yaml.dart';

final class CliOptions {
  final String pubspecPath;
  const CliOptions._(this.pubspecPath);

  factory CliOptions.init(dynamic optionsPath) {
    final options = File(optionsPath ?? "cli_options.yaml");

    if (options.existsSync()) {
      final fileContent = options.readAsStringSync();
      final yamlContent = loadYaml(fileContent);
      final pubspecPath = yamlContent?['pubspec_path'] ?? "pubspec.yaml";
      return CliOptions._(pubspecPath);
    } else {
      if (optionsPath != null) {
        stderr.writeln(
            'Warning: $optionsPath invalid, fallback to default options');
      }

      return CliOptions._("pubspec.yaml");
    }
  }
}
