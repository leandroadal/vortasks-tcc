import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:vortasks/screens/statistics/skills_screen.dart';
import 'package:vortasks/screens/statistics/widgets/custom_axis_title.dart';
import 'package:vortasks/stores/tasks/task_store.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';

class SkillsBarChart extends StatelessWidget {
  const SkillsBarChart(
      {super.key, required this.skillStore, required this.taskStore});

  final SkillStore skillStore;
  final TaskStore taskStore;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Habilidades',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 75.0),
            SizedBox(
              height: 250,
              width: 320,
              child: Observer(
                builder: (_) {
                  Map<String, double> skillXP = _calculateSkillXPThisWeek();
                  var topSkills = skillXP.entries.toList()
                    ..sort((a, b) => b.value.compareTo(a.value))
                    ..take(6);

                  return BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barGroups: topSkills.asMap().entries.map((entry) {
                        int index = entry.key;
                        MapEntry<String, double> data = entry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: data.value,
                              color: Colors.blue,
                              width: 16,
                              borderRadius: BorderRadius.circular(4),
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
                              String skillName = topSkills[value.toInt()].key;
                              return CustomAxisTitle(text: skillName);
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
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
                          tooltipPadding: const EdgeInsets.all(8),
                          tooltipMargin: 8,
                          getTooltipItem: (
                            BarChartGroupData group,
                            int groupIndex,
                            BarChartRodData rod,
                            int rodIndex,
                          ) {
                            return BarTooltipItem(
                              '${rod.toY.toInt()} XP',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SkillsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(
                  'Todas as habilidades',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, double> _calculateSkillXPThisWeek() {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    Map<String, double> skillXP = {};

    for (var task in taskStore.observableTasks.where((task) =>
        task.finish == true &&
        task.dateFinish != null &&
        task.dateFinish!.isAfter(startOfWeek) &&
        task.dateFinish!.isBefore(endOfWeek.add(const Duration(days: 1))))) {
      for (var skill in task.skills) {
        skillXP.update(skill.name, (value) => value + task.xp.toDouble(),
            ifAbsent: () => task.xp.toDouble());
      }
    }

    return skillXP;
  }
}
