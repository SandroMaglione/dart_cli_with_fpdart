import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_cli_with_fpdart/arguments_parser.dart';
import 'package:dart_cli_with_fpdart/cli_error.dart';
import 'package:dart_cli_with_fpdart/config_reader.dart';
import 'package:dart_cli_with_fpdart/file_reader.dart';
import 'package:dart_cli_with_fpdart/layer.dart';
import 'package:dart_cli_with_fpdart/main.dart';
import 'package:dart_cli_with_fpdart/yaml_loader.dart';

const options = "options";

void main(List<String> arguments) async =>
    program(arguments).match<void>((cliError) {
      exitCode = 2;

      final errorMessage = switch (cliError) {
        InvalidArgumentsError() => "Invalid CLI arguments",
        LoadYamlOptionsError(yamlLoaderError: final yamlLoaderError) =>
          "Error while loading yaml configuration: $yamlLoaderError",
        MissingPackageNameError(path: final path) =>
          "Missing package name in pubspec.yaml at path '$path'",
        ReadFilesError() => "Error while reading project files",
        ReadFileImportsError() => "Error while decoding file imports",
      };

      stderr.writeln(errorMessage);
    }, (result) {
      exitCode = 0;

      stdout.writeln();

      stdout.writeln("Entry 👉: ${result.entry}");

      stdout.writeln();

      stdout.writeln("Unused 👎");
      for (final file in result.unused) {
        stdout.writeln("  => $file");
      }

      stdout.writeln();

      stdout.writeln("Used 👍");
      for (final file in result.used) {
        stdout.writeln("  => $file");
      }
    }).run(
      AppMainLayer(
        argumentsParser: ArgumentsParserImpl(ArgParser()),
        configReader: ConfigReaderImpl(YamlLoaderImpl()),
        fileReader: FileReaderImpl(),
      ),
    );
