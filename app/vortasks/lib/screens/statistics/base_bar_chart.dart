import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BaseBarChart extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> barData;
  final List<Color> barColors;

  const BaseBarChart({
    super.key,
    required this.title,
    required this.barData,
    required this.barColors,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: barData.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, dynamic> data = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: barColors.asMap().entries.map((colorEntry) {
              int colorIndex = colorEntry.key;
              Color color = colorEntry.value;

              double barValue = colorIndex == 0
                  ? (data['successes'] as int).toDouble()
                  : (data['failures'] as int).toDouble();

              return BarChartRodData(
                toY: barValue,
                color: color,
                width: 14,
              );
            }).toList(),
            showingTooltipIndicators:
                List.generate(barColors.length, (index) => index),
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
                  child: Text(barData[value.toInt()]['label']),
                );
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
            tooltipPadding: const EdgeInsets.all(0),
            tooltipMargin: 8,
            getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
            ) {
              return BarTooltipItem(
                rod.toY.round().toString(),
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
}
