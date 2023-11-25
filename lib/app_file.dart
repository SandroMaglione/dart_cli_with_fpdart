import 'dart:io';

import 'package:equatable/equatable.dart';

final class AppFile extends Equatable {
  final File file;
  const AppFile._(this.file);

  /// TODO: Do not access [Directory.current] directly
  String get relativePath => file.path.replaceFirst(
        Directory.current.path,
        "",
      );

  @override
  String toString() {
    return relativePath;
  }

  @override
  List<Object?> get props => [relativePath];
}
