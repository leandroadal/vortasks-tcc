import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vortasks/models/achievement/achievement.dart';
import 'package:vortasks/models/checkin/check_in.dart';
import 'package:vortasks/models/goals/goals.dart';
import 'package:vortasks/models/skill/skill.dart';
import 'package:vortasks/models/tasks/task.dart';

class BackupCategory extends StatelessWidget {
  final String title;
  final dynamic data;
  final String categoryName;

  const BackupCategory({
    super.key,
    required this.title,
    required this.data,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (categoryName == 'Goals')
            _buildGoalData(data as Goals)
          else if (categoryName == 'Achievements')
            _buildAchievementData(data as List<Achievement>)
          else if (categoryName == 'Tasks')
            _buildTaskData(data as List<Task>)
          else if (categoryName == 'Skills')
            _buildSkillData(data as List<Skill>)
          else if (categoryName == 'CheckIns')
            _buildCheckInData(data as List<CheckIn>)
        ],
      ),
    );
  }

  Widget _buildGoalData(Goals goals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBackupDataItem(
            'Meta Diária de Produtividade:', '${goals.dailyProductivity}'),
        _buildBackupDataItem(
            'Meta Diária de Bem-estar:', '${goals.dailyWellBeing}'),
        _buildBackupDataItem(
            'Meta Semanal de Produtividade:', '${goals.weeklyProductivity}'),
        _buildBackupDataItem(
            'Meta Semanal de Bem-estar:', '${goals.weeklyWellBeing}'),
        _buildBackupDataItem('Prog. Diário de Produtividade:',
            '${goals.dailyProductivityProgress}/${goals.dailyProductivity}'),
        _buildBackupDataItem('Prog. Diário de Bem-estar:',
            '${goals.dailyWellBeingProgress}/${goals.dailyWellBeing}'),
        _buildBackupDataItem('Prog. Semanal de Produtividade:',
            '${goals.weeklyProductivityProgress}/${goals.weeklyProductivity}'),
        _buildBackupDataItem('Prog. Semanal de Bem-estar:',
            '${goals.weeklyWellBeingProgress}/${goals.weeklyWellBeing}'),
      ],
    );
  }

  Widget _buildAchievementData(List<Achievement> achievements) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: achievements
          .map((achievement) => _buildBackupDataItem(
                achievement.title,
                achievement.unlocked ? 'Aquirido' : 'Não',
                //'gemas: ',
              ))
          .toList(),
    );
  }

  Widget _buildTaskData(List<Task> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tasks
          .map((task) => _buildBackupDataItem(
                task.title,
                'Data: ${DateFormat('dd/MM/yyyy').format(task.endDate)}',
              ))
          .toList(),
    );
  }

  Widget _buildSkillData(List<Skill> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skills
          .map((skill) => _buildBackupDataItem(
                skill.name,
                'Nível: ${skill.level?.toString()}\nXP: ${skill.xp?.toString()}',
              ))
          .toList(),
    );
  }

  Widget _buildCheckInData(List<CheckIn> checkIns) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: checkIns
          .map((checkIn) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBackupDataItem('ID do CheckIn:', checkIn.id),
                  _buildBackupDataItem(
                      'Dias de Check-in:', '${checkIn.countCheckInDays}'),
                  _buildBackupDataItem('Mês:', '${checkIn.month}'),
                  _buildBackupDataItem('Ano:', '${checkIn.year}'),
                  _buildBackupDataItem(
                      'Último Check-in:',
                      checkIn.lastCheckInDate != null
                          ? DateFormat('dd/MM/yyyy HH:mm')
                              .format(checkIn.lastCheckInDate!.toLocal())
                          : "Nunca"),
                  const Divider(),
                ],
              ))
          .toList(),
    );
  }

  Widget _buildBackupDataItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
