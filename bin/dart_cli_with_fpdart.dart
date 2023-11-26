import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_cli_with_fpdart/cli_options.dart';
import 'package:dart_cli_with_fpdart/main.dart';
import 'package:fpdart/fpdart.dart';

const options = "options";

void main(List<String> arguments) async {
  /// https://dart.dev/tutorials/server/cmdline#setting-exit-codes
  exitCode = 0;

  final parser = ArgParser()..addOption(options, abbr: 'o');

  ArgResults argResults = parser.parse(arguments);
  final optionsPath = argResults[options];
  final cliOptions = CliOptions.init(optionsPath);

  /// 1. List all files (`path`), use `HashSet`
  /// 2. For each file, also list the imports (get `path` relative to current directory)
  /// 3. Remove files from `HashSet` if found in imports
  /// 4. What's left in the `HashSet` is unused
  final program = listFilesLibDir;

  final files = await program(cliOptions).run();

  files.match((l) {
    print("Error: $l");
  }, (r) {
    print("Files: ${r.$1}");
    print("Imports: ${r.$2}");

    // TODO: The entry file is not imported but used!
    final unusedFiles = r.$1.partition(
      (appFile) => r.$2.contains(appFile),
    );
    print("Unused: ${unusedFiles.$1}");
    print("Used: ${unusedFiles.$2}");
  });
}
