// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskFormStore on TaskFormStoreBase, Store {
  Computed<bool>? _$isTitleValidComputed;

  @override
  bool get isTitleValid =>
      (_$isTitleValidComputed ??= Computed<bool>(() => super.isTitleValid,
              name: 'TaskFormStoreBase.isTitleValid'))
          .value;
  Computed<String?>? _$titleErrorComputed;

  @override
  String? get titleError =>
      (_$titleErrorComputed ??= Computed<String?>(() => super.titleError,
              name: 'TaskFormStoreBase.titleError'))
          .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: 'TaskFormStoreBase.isFormValid'))
          .value;

  late final _$loadingAtom =
      Atom(name: 'TaskFormStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$titleAtom =
      Atom(name: 'TaskFormStoreBase.title', context: context);

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: 'TaskFormStoreBase.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$selectedTypeAtom =
      Atom(name: 'TaskFormStoreBase.selectedType', context: context);

  @override
  String get selectedType {
    _$selectedTypeAtom.reportRead();
    return super.selectedType;
  }

  @override
  set selectedType(String value) {
    _$selectedTypeAtom.reportWrite(value, super.selectedType, () {
      super.selectedType = value;
    });
  }

  late final _$selectedDifficultyAtom =
      Atom(name: 'TaskFormStoreBase.selectedDifficulty', context: context);

  @override
  Difficulty get selectedDifficulty {
    _$selectedDifficultyAtom.reportRead();
    return super.selectedDifficulty;
  }

  @override
  set selectedDifficulty(Difficulty value) {
    _$selectedDifficultyAtom.reportWrite(value, super.selectedDifficulty, () {
      super.selectedDifficulty = value;
    });
  }

  late final _$selectedTaskThemeAtom =
      Atom(name: 'TaskFormStoreBase.selectedTaskTheme', context: context);

  @override
  TaskTheme? get selectedTaskTheme {
    _$selectedTaskThemeAtom.reportRead();
    return super.selectedTaskTheme;
  }

  @override
  set selectedTaskTheme(TaskTheme? value) {
    _$selectedTaskThemeAtom.reportWrite(value, super.selectedTaskTheme, () {
      super.selectedTaskTheme = value;
    });
  }

  late final _$selectedSkillsAtom =
      Atom(name: 'TaskFormStoreBase.selectedSkills', context: context);

  @override
  ObservableList<String> get selectedSkills {
    _$selectedSkillsAtom.reportRead();
    return super.selectedSkills;
  }

  @override
  set selectedSkills(ObservableList<String> value) {
    _$selectedSkillsAtom.reportWrite(value, super.selectedSkills, () {
      super.selectedSkills = value;
    });
  }

  late final _$allDayEnabledAtom =
      Atom(name: 'TaskFormStoreBase.allDayEnabled', context: context);

  @override
  bool get allDayEnabled {
    _$allDayEnabledAtom.reportRead();
    return super.allDayEnabled;
  }

  @override
  set allDayEnabled(bool value) {
    _$allDayEnabledAtom.reportWrite(value, super.allDayEnabled, () {
      super.allDayEnabled = value;
    });
  }

  late final _$startDateEnabledAtom =
      Atom(name: 'TaskFormStoreBase.startDateEnabled', context: context);

  @override
  bool get startDateEnabled {
    _$startDateEnabledAtom.reportRead();
    return super.startDateEnabled;
  }

  @override
  set startDateEnabled(bool value) {
    _$startDateEnabledAtom.reportWrite(value, super.startDateEnabled, () {
      super.startDateEnabled = value;
    });
  }

  late final _$startDateAtom =
      Atom(name: 'TaskFormStoreBase.startDate', context: context);

  @override
  DateTime get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(DateTime value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  late final _$endDateAtom =
      Atom(name: 'TaskFormStoreBase.endDate', context: context);

  @override
  DateTime get endDate {
    _$endDateAtom.reportRead();
    return super.endDate;
  }

  @override
  set endDate(DateTime value) {
    _$endDateAtom.reportWrite(value, super.endDate, () {
      super.endDate = value;
    });
  }

  late final _$repetitionEnabledAtom =
      Atom(name: 'TaskFormStoreBase.repetitionEnabled', context: context);

  @override
  bool get repetitionEnabled {
    _$repetitionEnabledAtom.reportRead();
    return super.repetitionEnabled;
  }

  @override
  set repetitionEnabled(bool value) {
    _$repetitionEnabledAtom.reportWrite(value, super.repetitionEnabled, () {
      super.repetitionEnabled = value;
    });
  }

  late final _$selectedRepetitionAtom =
      Atom(name: 'TaskFormStoreBase.selectedRepetition', context: context);

  @override
  int? get selectedRepetition {
    _$selectedRepetitionAtom.reportRead();
    return super.selectedRepetition;
  }

  @override
  set selectedRepetition(int? value) {
    _$selectedRepetitionAtom.reportWrite(value, super.selectedRepetition, () {
      super.selectedRepetition = value;
    });
  }

  late final _$reminderEnabledAtom =
      Atom(name: 'TaskFormStoreBase.reminderEnabled', context: context);

  @override
  bool get reminderEnabled {
    _$reminderEnabledAtom.reportRead();
    return super.reminderEnabled;
  }

  @override
  set reminderEnabled(bool value) {
    _$reminderEnabledAtom.reportWrite(value, super.reminderEnabled, () {
      super.reminderEnabled = value;
    });
  }

  late final _$selectedReminderAtom =
      Atom(name: 'TaskFormStoreBase.selectedReminder', context: context);

  @override
  int? get selectedReminder {
    _$selectedReminderAtom.reportRead();
    return super.selectedReminder;
  }

  @override
  set selectedReminder(int? value) {
    _$selectedReminderAtom.reportWrite(value, super.selectedReminder, () {
      super.selectedReminder = value;
    });
  }

  late final _$selectedParticipantsAtom =
      Atom(name: 'TaskFormStoreBase.selectedParticipants', context: context);

  @override
  ObservableList<String> get selectedParticipants {
    _$selectedParticipantsAtom.reportRead();
    return super.selectedParticipants;
  }

  @override
  set selectedParticipants(ObservableList<String> value) {
    _$selectedParticipantsAtom.reportWrite(value, super.selectedParticipants,
        () {
      super.selectedParticipants = value;
    });
  }

  late final _$TaskFormStoreBaseActionController =
      ActionController(name: 'TaskFormStoreBase', context: context);

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitle(String value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedType(String value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setSelectedType');
    try {
      return super.setSelectedType(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedDifficulty(Difficulty value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setSelectedDifficulty');
    try {
      return super.setSelectedDifficulty(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedTaskTheme(TaskTheme? theme) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setSelectedTaskTheme');
    try {
      return super.setSelectedTaskTheme(theme);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSelectedSkill(String skillId) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.addSelectedSkill');
    try {
      return super.addSelectedSkill(skillId);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSelectedSkill(String skillId) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.removeSelectedSkill');
    try {
      return super.removeSelectedSkill(skillId);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void switchAllDayEnabled(bool value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.switchAllDayEnabled');
    try {
      return super.switchAllDayEnabled(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStartDateEnabled(bool value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setStartDateEnabled');
    try {
      return super.setStartDateEnabled(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStartDate(DateTime value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setStartDate');
    try {
      return super.setStartDate(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEndDate(DateTime value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setEndDate');
    try {
      return super.setEndDate(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRepetitionEnabled(bool value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setRepetitionEnabled');
    try {
      return super.setRepetitionEnabled(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedRepetition(int value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setSelectedRepetition');
    try {
      return super.setSelectedRepetition(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReminderEnabled(bool value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setReminderEnabled');
    try {
      return super.setReminderEnabled(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedReminder(int value) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.setSelectedReminder');
    try {
      return super.setSelectedReminder(value);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addParticipant(String participant) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.addParticipant');
    try {
      return super.addParticipant(participant);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeParticipant(String participant) {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.removeParticipant');
    try {
      return super.removeParticipant(participant);
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$TaskFormStoreBaseActionController.startAction(
        name: 'TaskFormStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$TaskFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
title: ${title},
description: ${description},
selectedType: ${selectedType},
selectedDifficulty: ${selectedDifficulty},
selectedTaskTheme: ${selectedTaskTheme},
selectedSkills: ${selectedSkills},
allDayEnabled: ${allDayEnabled},
startDateEnabled: ${startDateEnabled},
startDate: ${startDate},
endDate: ${endDate},
repetitionEnabled: ${repetitionEnabled},
selectedRepetition: ${selectedRepetition},
reminderEnabled: ${reminderEnabled},
selectedReminder: ${selectedReminder},
selectedParticipants: ${selectedParticipants},
isTitleValid: ${isTitleValid},
titleError: ${titleError},
isFormValid: ${isFormValid}
    ''';
  }
}
