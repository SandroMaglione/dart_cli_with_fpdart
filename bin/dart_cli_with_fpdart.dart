import 'package:dart_cli_with_fpdart/main.dart';
import 'package:fpdart/fpdart.dart';

void main(List<String> arguments) async {
  final program = listFilesCurrentDir.flatMap(
    (r) => r.traverseTaskEitherSeq(readImports),
  );

  final files = await program.run();
  print(files);
}
