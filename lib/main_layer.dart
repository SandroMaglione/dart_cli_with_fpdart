import 'package:dart_cli_with_fpdart/arguments_parser.dart';
import 'package:dart_cli_with_fpdart/config_reader.dart';
import 'package:dart_cli_with_fpdart/file_reader.dart';

abstract final class MainLayer {
  const MainLayer();
  ArgumentsParser get argumentsParser;
  ConfigReader get configReader;
  FileReader get fileReader;
}

final class AppMainLayer implements MainLayer {
  @override
  final ArgumentsParser argumentsParser;

  @override
  final ConfigReader configReader;

  @override
  final FileReader fileReader;

  const AppMainLayer({
    required this.argumentsParser,
    required this.configReader,
    required this.fileReader,
  });
}
