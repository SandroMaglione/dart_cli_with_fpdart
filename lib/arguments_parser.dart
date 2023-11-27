import 'package:args/args.dart';
import 'package:dart_cli_with_fpdart/cli_error.dart';
import 'package:dart_cli_with_fpdart/cli_options.dart';
import 'package:fpdart/fpdart.dart';

abstract final class ArgumentsParser {
  const ArgumentsParser();
  IOEither<CliError, CliOptions> parse(List<String> arguments);
}

final class ArgumentsParserImpl extends ArgumentsParser {
  static const _options = "options";

  final ArgParser _argParser;
  const ArgumentsParserImpl(this._argParser);

  @override
  IOEither<CliError, CliOptions> parse(List<String> arguments) =>
      IOEither.tryCatch(
        () {
          final parser = _argParser..addOption(_options, abbr: 'o');

          final argResults = parser.parse(arguments);
          final optionsPath = argResults[_options];

          return CliOptions.init(optionsPath);
        },
        InvalidArgumentsError.new,
      );
}
