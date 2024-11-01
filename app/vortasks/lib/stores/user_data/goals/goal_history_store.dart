import 'package:mobx/mobx.dart';
import 'package:vortasks/core/storage/local_storage.dart';
import 'package:vortasks/models/goals/goal_history.dart';
import 'dart:convert';

part 'goal_history_store.g.dart';

class GoalHistoryStore = GoalHistoryStoreBase with _$GoalHistoryStore;

abstract class GoalHistoryStoreBase with Store {
  GoalHistoryStoreBase() {
    _loadGoalHistory();
  }

  @observable
  ObservableList<GoalHistory> goalHistoryList = ObservableList<GoalHistory>();

  @action
  void addGoalHistory(GoalHistory goalHistory) {
    goalHistoryList.add(goalHistory);
    _saveGoalHistory();
  }

  @action
  void updateGoalHistory(GoalHistory goalHistory) {
    final index = goalHistoryList.indexWhere((gh) => gh.id == goalHistory.id);
    if (index != -1) {
      goalHistoryList[index] = goalHistory;
      _saveGoalHistory();
    }
  }

  @action
  void removeGoalHistory(String goalHistoryId) {
    goalHistoryList.removeWhere((gh) => gh.id == goalHistoryId);
    _saveGoalHistory();
  }

  // ================ Armazenamento local ================

  // Salva o histórico no armazenamento local
  void _saveGoalHistory() {
    final jsonList = goalHistoryList.map((gh) => gh.toJson()).toList();
    LocalStorage.saveData('goalHistory', jsonEncode(jsonList));
  }

  // Carrega o histórico do armazenamento local
  void _loadGoalHistory() {
    final historyJson = LocalStorage.getString('goalHistory');
    if (historyJson != null) {
      final decodedJson = jsonDecode(historyJson) as List;
      final loadedHistory =
          decodedJson.map((item) => GoalHistory.fromJson(item)).toList();
      goalHistoryList = ObservableList.of(loadedHistory);
    }
  }
}
