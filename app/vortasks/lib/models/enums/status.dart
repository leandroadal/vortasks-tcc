// ignore_for_file: constant_identifier_names

enum Status {
  IN_PROGRESS('Em progresso'),
  COMPLETED('Finalizada'),
  FAILED('Falhou');

  final String namePtBr;

  const Status(this.namePtBr);
}
