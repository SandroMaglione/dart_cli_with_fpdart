import 'package:dart_cli_with_fpdart/arguments_parser.dart';
import 'package:dart_cli_with_fpdart/config_reader.dart';

abstract final class MainLayer {
  const MainLayer();
  ArgumentsParser get argumentsParser;
  ConfigReader get configReader;
}

final class AppMainLayer implements MainLayer {
  @override
  final ArgumentsParser argumentsParser;

  @override
  final ConfigReader configReader;

  const AppMainLayer({
    required this.argumentsParser,
    required this.configReader,
  });
}
