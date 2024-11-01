import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vortasks/screens/goals/widgets/daily_tasks_input.dart';
import 'package:vortasks/screens/goals/widgets/goal_card.dart';
import 'package:vortasks/screens/goals/widgets/goals_slider.dart';
import 'package:vortasks/screens/goals/widgets/proportion_item.dart';
import 'package:vortasks/stores/user_data/goals/goals_store.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  final GoalsStore _goalsStore = GetIt.I<GoalsStore>();
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  double _currentPage = 0.0;
  double _sliderValue = 70;

  late TextEditingController _totalDailyTasksController;
  late TextEditingController _dailyProductivityController;
  late TextEditingController _dailyWellBeingController;
  late TextEditingController _weeklyProductivityController;
  late TextEditingController _weeklyWellBeingController;

  @override
  void initState() {
    super.initState();
    _initializeTextControllers();
    _calculateInitialSliderValue();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _totalDailyTasksController.dispose();
    _dailyProductivityController.dispose();
    _dailyWellBeingController.dispose();
    _weeklyProductivityController.dispose();
    _weeklyWellBeingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Definir Metas'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                DailyTasksInput(
                  totalDailyTasksController: _totalDailyTasksController,
                  onChanged: (value) => _distributeTasksFromTotal(),
                ),
                const SizedBox(height: 32.0),
                GoalsSlider(
                  sliderValue: _sliderValue,
                  onChanged: (newValue) {
                    setState(() {
                      _sliderValue = newValue;
                      _updateGoalsFromSlider();
                      _updateTextControllersFromSlider();
                    });
                  },
                ),
                // Exibir a proporção atual
                Observer(builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProportionItem(
                        color: Theme.of(context).colorScheme.primary,
                        label: 'Produtividade',
                        percentage: _sliderValue.toInt(),
                      ),
                      ProportionItem(
                        color: Theme.of(context).colorScheme.secondary,
                        label: 'Bem-estar',
                        percentage: (100 - _sliderValue).toInt(),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 32.0),
                // Área dos cards deslizáveis
                SizedBox(
                  height: 220,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      _buildGoalCard('Diária'),
                      _buildGoalCard('Semanal'),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                // Indicador de página
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 2; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == i
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 32.0),
                _buildSaveGoalButton(context),
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildSaveGoalButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _saveGoals();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      child: const Text(
        'Salvar Metas',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildGoalCard(String cardType) {
    return GoalCard(
      cardType: cardType,
      productivityController: cardType == 'Diária'
          ? _dailyProductivityController
          : _weeklyProductivityController,
      wellBeingController: cardType == 'Diária'
          ? _dailyWellBeingController
          : _weeklyWellBeingController,
      calculatePercentage: _calculatePercentage,
      updatePercentagesFromGoals: _updatePercentagesFromGoals,
      updateWeeklyFromDaily: _updateWeeklyFromDaily,
      updateDailyFromWeekly: _updateDailyFromWeekly,
    );
  }

  void _initializeTextControllers() {
    _totalDailyTasksController = TextEditingController(
        text: (_goalsStore.goals.dailyProductivity +
                _goalsStore.goals.dailyWellBeing)
            .toString());

    _dailyProductivityController = TextEditingController(
        text: _goalsStore.goals.dailyProductivity.toString());
    _dailyWellBeingController = TextEditingController(
        text: _goalsStore.goals.dailyWellBeing.toString());
    _weeklyProductivityController = TextEditingController(
        text: _goalsStore.goals.weeklyProductivity.toString());
    _weeklyWellBeingController = TextEditingController(
        text: _goalsStore.goals.weeklyWellBeing.toString());
  }

  void _calculateInitialSliderValue() {
    int totalDailyGoals =
        _goalsStore.goals.dailyProductivity + _goalsStore.goals.dailyWellBeing;
    if (totalDailyGoals > 0) {
      _sliderValue =
          (_goalsStore.goals.dailyProductivity / totalDailyGoals) * 100;
    }
  }

  void _saveGoals() {
    _goalsStore.updateGoals(
      int.parse(_dailyProductivityController.text),
      int.parse(_dailyWellBeingController.text),
      int.parse(_weeklyProductivityController.text),
      int.parse(_weeklyWellBeingController.text),
      _goalsStore.goals.dailyProductivityProgress,
      _goalsStore.goals.dailyWellBeingProgress,
      _goalsStore.goals.weeklyProductivityProgress,
      _goalsStore.goals.weeklyWellBeingProgress,
    );
    Navigator.pop(context);
  }

  String _calculatePercentage(int goalValue) {
    int total = _currentPage <= 0.5
        ? _goalsStore.goals.dailyProductivity + _goalsStore.goals.dailyWellBeing
        : _goalsStore.goals.weeklyProductivity +
            _goalsStore.goals.weeklyWellBeing;
    if (total == 0) {
      return '0';
    } else {
      return ((goalValue / total) * 100).toStringAsFixed(0);
    }
  }

  void _updateWeeklyFromDaily() {
    _weeklyProductivityController.text =
        (int.parse(_dailyProductivityController.text) * 7).toString();
    _weeklyWellBeingController.text =
        (int.parse(_dailyWellBeingController.text) * 7).toString();
  }

  void _updateDailyFromWeekly() {
    _dailyProductivityController.text =
        (int.parse(_weeklyProductivityController.text) / 7).round().toString();
    _dailyWellBeingController.text =
        (int.parse(_weeklyWellBeingController.text) / 7).round().toString();
  }

  void _updateTextControllersFromSlider() {
    _updateGoalsFromSlider();
    _dailyProductivityController.text =
        _goalsStore.goals.dailyProductivity.toString();
    _dailyWellBeingController.text =
        _goalsStore.goals.dailyWellBeing.toString();
    _weeklyProductivityController.text =
        _goalsStore.goals.weeklyProductivity.toString();
    _weeklyWellBeingController.text =
        _goalsStore.goals.weeklyWellBeing.toString();
  }

  void _updateGoalsFromSlider() {
    int dailyTotal = int.tryParse(_totalDailyTasksController.text) ??
        (_goalsStore.goals.dailyProductivity +
            _goalsStore.goals.dailyWellBeing);
    int newDailyProductivity = (_sliderValue / 100 * dailyTotal).round();
    int newDailyWellBeing = dailyTotal - newDailyProductivity;

    _goalsStore.updateGoals(
      newDailyProductivity,
      newDailyWellBeing,
      newDailyProductivity * 7,
      newDailyWellBeing * 7,
      _goalsStore.goals.dailyProductivityProgress,
      _goalsStore.goals.dailyWellBeingProgress,
      _goalsStore.goals.weeklyProductivityProgress,
      _goalsStore.goals.weeklyWellBeingProgress,
    );
  }

  void _distributeTasksFromTotal() {
    int totalTasks = int.tryParse(_totalDailyTasksController.text) ?? 0;
    int productivityTasks = (_sliderValue / 100 * totalTasks).round();
    int wellBeingTasks = totalTasks - productivityTasks;

    _dailyProductivityController.text = productivityTasks.toString();
    _dailyWellBeingController.text = wellBeingTasks.toString();
    _updateWeeklyFromDaily();
  }

  void _updatePercentagesFromGoals(String cardType) {
    int productivity = cardType == 'Diária'
        ? int.tryParse(_dailyProductivityController.text) ?? 0
        : int.tryParse(_weeklyProductivityController.text) ?? 0;
    int wellBeing = cardType == 'Diária'
        ? int.tryParse(_dailyWellBeingController.text) ?? 0
        : int.tryParse(_weeklyWellBeingController.text) ?? 0;
    int total = productivity + wellBeing;

    if (total > 0) {
      setState(() {
        _sliderValue = (productivity / total) * 100;
      });
    }
  }
}
