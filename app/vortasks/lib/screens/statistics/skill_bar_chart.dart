import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class SkillXpBarChart extends StatefulWidget {
  const SkillXpBarChart({super.key});

  @override
  State<SkillXpBarChart> createState() => _SkillXpBarChartState();
}

class _SkillXpBarChartState extends State<SkillXpBarChart> {
  final TaskStore _taskStore = GetIt.I<TaskStore>();
  final SkillStore _skillStore = GetIt.I<SkillStore>();

  // Função para obter as 6 habilidades com mais XP ganho na semana
  List<Map<String, dynamic>> _getTopSkillsThisWeek() {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    // Mapa para armazenar o XP total ganho por habilidade
    Map<String, int> skillXpMap = {};

    // Itera sobre as tarefas concluídas na semana
    for (var task in _taskStore.observableTasks.where((task) =>
        task.finish == true &&
        task.dateFinish != null &&
        task.dateFinish!.isAfter(startOfWeek) &&
        task.dateFinish!.isBefore(endOfWeek))) {
      for (var skill in task.skills) {
        // Incrementa o XP da habilidade no mapa
        skillXpMap.update(skill.id, (value) => value + task.xp,
            ifAbsent: () => task.xp);
      }
    }

    // Converte o mapa em uma lista de Maps, ordenada pelo XP
    List<Map<String, dynamic>> skillXpList = skillXpMap.entries
        .map((entry) => {'skillId': entry.key, 'xp': entry.value})
        .toList();
    skillXpList.sort((a, b) => (b['xp'] as int).compareTo(a['xp'] as int));

    // Retorna as 6 primeiras habilidades com mais XP
    return skillXpList.take(6).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> topSkills = _getTopSkillsThisWeek();

    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Habilidades da Semana',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: topSkills.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> data = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: (data['xp'] as int).toDouble(),
                          color: Colors.blue,
                          width: 20,
                        ),
                      ],
                      showingTooltipIndicators: [0],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 4,
                            child: Text(topSkills[value.toInt()]['skillId']),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        String skillName = _skillStore.skills
                            .firstWhere((skill) =>
                                skill.id == topSkills[groupIndex]['skillId'])
                            .name;
                        return BarTooltipItem(
                          '$skillName\n${rod.toY.round()} XP',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
