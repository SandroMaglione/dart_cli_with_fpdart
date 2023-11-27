import 'dart:io';

import 'package:dart_cli_with_fpdart/yaml_loader_error.dart';
import 'package:fpdart/fpdart.dart';
import 'package:yaml/yaml.dart';

abstract final class YamlLoader {
  const YamlLoader();
  TaskEither<YamlLoaderError, dynamic> loadFromPath(String path);
}

final class YamlLoaderImpl implements YamlLoader {
  @override
  TaskEither<YamlLoaderError, dynamic> loadFromPath(String path) =>
      TaskEither.Do(
        (_) async {
          final file = await _(
            IO(
              () => File(path),
            ).toTaskEither<YamlLoaderError>().flatMap(
                  (file) => TaskEither<YamlLoaderError, File>(
                    () async => (await file.exists())
                        ? Either.right(file)
                        : Either.left(MissingFile(path)),
                  ),
                ),
          );

          final fileContent = await _(
            TaskEither.tryCatch(
              file.readAsString,
              (error, stackTrace) => ReadingFileAsStringError(),
            ),
          );

          return _(
            TaskEither.tryCatch(
              () async => loadYaml(fileContent),
              ParsingFailed.new,
            ),
          );
        },
      );
}
