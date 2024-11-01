import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/statistics/widgets/custom_axis_title.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class AllSkillsXPChart extends StatefulWidget {
  const AllSkillsXPChart({super.key});

  @override
  State<AllSkillsXPChart> createState() => _AllSkillsXPChartState();
}

class _AllSkillsXPChartState extends State<AllSkillsXPChart> {
  final TaskStore taskStore = GetIt.I<TaskStore>();
  final SkillStore skillStore = GetIt.I<SkillStore>();
  String _selectedPeriod = 'Semanal';

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
              'XP Ganho por Habilidade',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            _buildPeriodSelector(),
            const SizedBox(height: 40.0),
            SizedBox(
              height: 300,
              child: Observer(
                builder: (_) {
                  Map<String, double> skillXP = _calculateSkillXPByPeriod();

                  // Garante que todas as habilidades estejam no mapa
                  for (var skill in skillStore.skills) {
                    skillXP.putIfAbsent(skill.name, () => 0);
                  }

                  // Ordena as habilidades por XP decrescente
                  var sortedSkills = skillXP.entries.toList()
                    ..sort((a, b) => b.value.compareTo(a.value));

                  // Scrollbar horizontal para o gráfico
                  return Scrollbar(
                    thumbVisibility: true, // Mostra a barra de rolagem
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: sortedSkills.length * 60.0, // Largura do gráfico
                        child: _skillXpBarChart(sortedSkills),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChart _skillXpBarChart(List<MapEntry<String, double>> sortedSkills) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: sortedSkills.asMap().entries.map((entry) {
          int index = entry.key;
          MapEntry<String, double> data = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: data.value, // Valor do XP
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
                String skillName = sortedSkills[value.toInt()].key;
                return CustomAxisTitle(text: skillName, maxWidth: 60);
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
  }

  Widget _buildPeriodSelector() {
    return DropdownButton<String>(
      value: _selectedPeriod,
      onChanged: (String? newValue) {
        setState(() {
          _selectedPeriod = newValue!;
        });
      },
      items: const <String>[
        'Diário',
        'Semanal',
        'Mensal',
        'Anual',
        'Todo o Período'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Map<String, double> _calculateSkillXPByPeriod() {
    DateTime now = DateTime.now();
    DateTime startDate;
    DateTime endDate = now;

    switch (_selectedPeriod) {
      case 'Diário':
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case 'Semanal':
        startDate = now.subtract(Duration(days: now.weekday % 7));
        break;
      case 'Mensal':
        startDate = DateTime(now.year, now.month, 1);
        break;
      case 'Anual':
        startDate = DateTime(now.year, 1, 1);
        break;
      case 'Todo o Período':
        startDate = DateTime(2000); // Uma data antiga
        break;
      default:
        startDate = now.subtract(Duration(days: now.weekday % 7));
    }

    Map<String, double> skillXP = {};

    for (var task in taskStore.observableTasks.where((task) =>
        task.finish == true &&
        task.dateFinish != null &&
        task.dateFinish!.isAfter(startDate) &&
        task.dateFinish!.isBefore(endDate))) {
      for (var skill in task.skills) {
        skillXP.update(skill.name, (value) => value + task.xp.toDouble(),
            ifAbsent: () => task.xp.toDouble());
      }
    }

    return skillXP;
  }
}
