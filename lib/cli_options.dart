import 'dart:io';

import 'package:yaml/yaml.dart';

final class CliOptions {
  final String pubspecPath;
  final String entry;

  const CliOptions._({
    required this.pubspecPath,
    required this.entry,
  });

  factory CliOptions.init(dynamic optionsPath) {
    final options = File(optionsPath ?? "cli_options.yaml");

    if (options.existsSync()) {
      final fileContent = options.readAsStringSync();
      final yamlContent = loadYaml(fileContent);
      final pubspecPath = yamlContent?['pubspec_path'] ?? "pubspec.yaml";
      final entry = "${yamlContent?['entry'] ?? "main"}.dart";
      return CliOptions._(pubspecPath: pubspecPath, entry: entry);
    } else {
      if (optionsPath != null) {
        stderr.writeln(
            'Warning: $optionsPath invalid, fallback to default options');
      }

      return CliOptions._(
        pubspecPath: "pubspec.yaml",
        entry: "main.dart",
      );
    }
  }
}
