import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/home/statistics/widgets/skills_bar_chart.dart';
import 'package:vortasks/screens/home/statistics/widgets/task_statistics_card.dart';
import 'package:vortasks/screens/home/resume/widgets/header_tab.dart';
import 'package:vortasks/screens/home/statistics/widgets/monthly_goal_proportion_bar.dart';
import 'package:vortasks/screens/home/statistics/widgets/weekly_tasks_pie_chart.dart';
import 'package:vortasks/screens/widgets/my_navigation_rail.dart';
import 'package:vortasks/stores/user_data/goals/goals_store.dart';
import 'package:vortasks/stores/user_data/skill/skill_store.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class StatisticsTab extends StatefulWidget {
  const StatisticsTab({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<StatisticsTab> createState() => _StatisticsTabState();
}

class _StatisticsTabState extends State<StatisticsTab> {
  final TaskStore taskStore = GetIt.I<TaskStore>();
  final GoalsStore goalsStore = GetIt.I<GoalsStore>();
  final SkillStore skillStore = GetIt.I<SkillStore>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyNavigationRail(),
              Expanded(
                child: _buildStatisticsContent(),
              ),
            ],
          );
        } else {
          return _buildStatisticsContent();
        }
      },
    );
  }

  Widget _buildStatisticsContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HeaderTab(pageController: widget.pageController),
          const SizedBox(height: 16.0),
          const MonthlyGoalProportionBar(),
          const SizedBox(height: 16),
          WeeklyTasksPieChart(taskStore: taskStore),
          const SizedBox(height: 16.0),
          SkillsBarChart(skillStore: skillStore, taskStore: taskStore),
          const SizedBox(height: 16.0),
          TaskStatisticsCard(taskStore: taskStore),
        ],
      ),
    );
  }
}
