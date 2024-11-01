import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/goals/goals_screen.dart';
import 'package:vortasks/screens/home/resume/widgets/goals/goal_item.dart';
import 'package:vortasks/stores/user_data/goals/goals_store.dart';

class GoalSection extends StatefulWidget {
  const GoalSection({super.key});

  @override
  State<GoalSection> createState() => _GoalSectionState();
}

class _GoalSectionState extends State<GoalSection> {
  final GoalsStore goalsStore = GetIt.I<GoalsStore>();
  final PageController _pageController = PageController();
  double _currentPage = 0.0; // Índice da página atual

  @override
  void initState() {
    super.initState();
    // Listener para atualizar a página atual
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 240,
          child: PageView(
            controller: _pageController,
            children: [
              _buildDailyGoalsCard(context),
              _buildWeeklyGoalsCard(context),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        // Indica o card atual (Diário ou Semanal)
        _buildPageIndicator(context),
      ],
    );
  }

  Widget _buildDailyGoalsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Metas Diárias',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GoalsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Observer(builder: (_) {
              return GoalItem(
                'Produtividade',
                goalsStore.goals.dailyProductivity > 0
                    ? goalsStore.goals.dailyProductivityProgress /
                        goalsStore.goals.dailyProductivity
                    : 0,
                Theme.of(context).colorScheme.onSecondary,
                goal: goalsStore.goals.dailyProductivity > 0
                    ? goalsStore.goals.dailyProductivity
                    : 0,
              );
            }),
            const SizedBox(height: 8.0),
            Observer(builder: (_) {
              return GoalItem(
                'Bem-estar',
                goalsStore.goals.dailyWellBeing > 0
                    ? goalsStore.goals.dailyWellBeingProgress /
                        goalsStore.goals.dailyWellBeing
                    : 0,
                Theme.of(context).colorScheme.onSecondary,
                goal: goalsStore.goals.dailyWellBeing > 0
                    ? goalsStore.goals.dailyWellBeing
                    : 0,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyGoalsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Metas Semanais',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GoalsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Observer(builder: (_) {
              if (kDebugMode) {
                print(
                    'a${goalsStore.goals.weeklyProductivity}\n b${goalsStore.goals.weeklyProductivityProgress}');
              }
              return GoalItem(
                'Produtividade',
                goalsStore.goals.weeklyProductivityProgress /
                    goalsStore.goals.weeklyProductivity,
                Theme.of(context).colorScheme.onSecondary,
                goal: goalsStore.goals.weeklyProductivity,
              );
            }),
            const SizedBox(height: 8.0),
            Observer(builder: (_) {
              return GoalItem(
                'Bem-estar',
                goalsStore.goals.weeklyWellBeingProgress /
                    goalsStore.goals.weeklyWellBeing,
                Theme.of(context).colorScheme.onSecondary,
                goal: goalsStore.goals.weeklyWellBeing,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Indicador para o card da esquerda
        _buildIndicatorDot(
          context,
          _currentPage <= 0.5
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
        ),
        // Indicador para o card da direita
        _buildIndicatorDot(
          context,
          _currentPage > 0.5
              ? Theme.of(context).colorScheme.primary
              : Colors.grey,
        ),
      ],
    );
  }

  Widget _buildIndicatorDot(BuildContext context, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
