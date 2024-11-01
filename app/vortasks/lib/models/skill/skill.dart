import 'package:vortasks/models/enums/task_theme.dart';

class Skill {
  final String id;
  final String name;
  final double? xp;
  final int? level;
  final List<TaskTheme> taskThemes;

  Skill({
    required this.id,
    required this.name,
    required this.xp,
    required this.level,
    required this.taskThemes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'xp': xp,
      'level': level,
      'themes': taskThemes.map((theme) => theme.name).toList(),
    };
  }

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
      xp: json['xp'],
      level: json['level'],
      taskThemes: (json['themes'] as List)
          .map((theme) => TaskTheme.values.byName(theme))
          .toList(),
    );
  }
}

List<Skill> defaultSkills = [
  Skill(
    id: 'skill_1',
    name: 'Desenvolvedor',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.LEARNING, TaskTheme.CREATIVITY],
  ),
  Skill(
    id: 'skill_2',
    name: 'Artista',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.CREATIVITY, TaskTheme.HOBBIES],
  ),
  Skill(
    id: 'skill_3',
    name: 'Escritor',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.CREATIVITY, TaskTheme.LEARNING],
  ),
  Skill(
    id: 'skill_4',
    name: 'Músico',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.CREATIVITY, TaskTheme.HOBBIES],
  ),
  Skill(
    id: 'skill_5',
    name: 'Culinária',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.HOBBIES, TaskTheme.HEALTH],
  ),
  Skill(
    id: 'skill_6',
    name: 'Jogos',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.HOBBIES],
  ),
  Skill(
    id: 'skill_7',
    name: 'Línguas',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.LEARNING],
  ),
  Skill(
    id: 'skill_8',
    name: 'Organização',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.ORGANIZATION],
  ),
  Skill(
    id: 'skill_9',
    name: 'Finanças',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.FINANCE],
  ),
  Skill(
    id: 'skill_10',
    name: 'Saúde',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.HEALTH, TaskTheme.WELLNESS],
  ),
  Skill(
    id: 'skill_11',
    name: 'Comunicação',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.COMMUNICATION],
  ),
  Skill(
    id: 'skill_12',
    name: 'Relações interpessoais',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.COLLABORATION, TaskTheme.COMMUNICATION],
  ),
  Skill(
    id: 'skill_13',
    name: 'Fotografia',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.HOBBIES, TaskTheme.CREATIVITY],
  ),
  Skill(
    id: 'skill_14',
    name: 'Design',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.CREATIVITY],
  ),
  Skill(
    id: 'skill_15',
    name: 'Marketing',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.COMMUNICATION],
  ),
  Skill(
    id: 'skill_16',
    name: 'Música',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.HOBBIES, TaskTheme.CREATIVITY],
  ),
  Skill(
    id: 'skill_17',
    name: 'Leitura',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.LEARNING, TaskTheme.HOBBIES],
  ),
  Skill(
    id: 'skill_18',
    name: 'Dança',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.HOBBIES, TaskTheme.WELLNESS],
  ),
  Skill(
    id: 'skill_19',
    name: 'Yoga',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.WELLNESS, TaskTheme.HEALTH, TaskTheme.HOBBIES],
  ),
  Skill(
    id: 'skill_20',
    name: 'Meditação',
    xp: 0.0,
    level: 1,
    taskThemes: [TaskTheme.WELLNESS, TaskTheme.HEALTH, TaskTheme.HOBBIES],
  ),
];
