import 'dart:io';

import 'package:dart_cli_with_fpdart/import_match.dart';
import 'package:equatable/equatable.dart';

final class FileImport extends Equatable {
  final File file;
  final List<ImportMatch> importMatchList;
  const FileImport({
    required this.file,
    required this.importMatchList,
  });

  @override
  String toString() {
    return "${file.path}: $importMatchList";
  }

  @override
  List<Object?> get props => [file.path];
}
