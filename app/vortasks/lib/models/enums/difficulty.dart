// ignore_for_file: constant_identifier_names

enum Difficulty {
  EASY('Fácil'),
  MEDIUM('Médio'),
  HARD('Difícil'),
  VERY_HARD('Muito Difícil');

  final String namePtBr;

  const Difficulty(this.namePtBr);
}
