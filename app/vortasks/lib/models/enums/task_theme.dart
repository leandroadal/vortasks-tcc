// ignore_for_file: constant_identifier_names

enum TaskTheme {
  COLLABORATION('Colaboração'),
  LEARNING('Aprendizado'),
  WELLNESS('Bem-estar'),
  COMMUNICATION('Comunicação'),
  CREATIVITY('Criatividade'),
  HEALTH('Saúde'),
  ORGANIZATION('Organização'),
  FINANCE('Finanças'),
  HOUSEHOLD_TASKS('Tarefas Domésticas'),
  HOBBIES('Hobbies');

  final String namePtBr;

  const TaskTheme(this.namePtBr);
}

/*
const Map<TaskTheme, String> taskThemeNames = {
  TaskTheme.COLLABORATION: 'Colaboração',
  TaskTheme.LEARNING: 'Aprendizado',
  TaskTheme.WELLNESS: 'Bem-estar',
  TaskTheme.COMMUNICATION: 'Comunicação',
  TaskTheme.CREATIVITY: 'Criatividade',
  TaskTheme.HEALTH: 'Saúde',
  TaskTheme.ORGANIZATION: 'Organização',
  TaskTheme.FINANCE: 'Finanças',
  TaskTheme.HOUSEHOLD_TASKS: 'Tarefas Domésticas',
  TaskTheme.HOBBIES: 'Hobbies',
  TaskTheme.OTHER: 'Outro',
};*/
