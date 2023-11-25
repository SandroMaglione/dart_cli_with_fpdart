import 'dart:io';

import 'package:equatable/equatable.dart';

final class ImportMatch extends Equatable {
  final String path;
  const ImportMatch(this.path);

  factory ImportMatch.relative(File file) => ImportMatch(
        file.path.replaceFirst(
          Directory.current.path,
          "",
        ),
      );

  @override
  String toString() {
    return path;
  }

  @override
  List<Object?> get props => [path];
}
