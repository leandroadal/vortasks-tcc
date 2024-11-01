import 'package:flutter/material.dart';

import 'package:vortasks/screens/statistics/all_skills_XP_chart.dart';
import 'package:vortasks/screens/statistics/daily_goal_bar_chart.dart';
import 'package:vortasks/screens/statistics/skill_level_chart.dart';
import 'package:vortasks/screens/statistics/task_completion_chart.dart';
import 'package:vortasks/screens/statistics/weekly_goal_bar_chart.dart';
import 'package:vortasks/screens/widgets/my_bottom_navigation_bar.dart';

class AllChartsScreen extends StatelessWidget {
  const AllChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficos'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      bottomNavigationBar: isSmallScreen ? const MyBottomNavigationBar() : null,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TaskCompletionChart(),
              SizedBox(height: 16.0),
              DailyGoalBarChart(),
              WeeklyGoalBarChart(),
              SkillLevelChart(),
              AllSkillsXPChart(),
            ],
          ),
        ),
      ),
    );
  }
}
