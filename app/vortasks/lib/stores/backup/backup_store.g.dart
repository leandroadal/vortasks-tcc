// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BackupStore on BackupStoreBase, Store {
  Computed<Backup>? _$latestBackupDataComputed;

  @override
  Backup get latestBackupData => (_$latestBackupDataComputed ??=
          Computed<Backup>(() => super.latestBackupData,
              name: 'BackupStoreBase.latestBackupData'))
      .value;

  late final _$backupAtom =
      Atom(name: 'BackupStoreBase.backup', context: context);

  @override
  Backup? get backup {
    _$backupAtom.reportRead();
    return super.backup;
  }

  @override
  set backup(Backup? value) {
    _$backupAtom.reportWrite(value, super.backup, () {
      super.backup = value;
    });
  }

  late final _$expandedCategoriesAtom =
      Atom(name: 'BackupStoreBase.expandedCategories', context: context);

  @override
  Map<String, bool> get expandedCategories {
    _$expandedCategoriesAtom.reportRead();
    return super.expandedCategories;
  }

  @override
  set expandedCategories(Map<String, bool> value) {
    _$expandedCategoriesAtom.reportWrite(value, super.expandedCategories, () {
      super.expandedCategories = value;
    });
  }

  late final _$hasConflictAtom =
      Atom(name: 'BackupStoreBase.hasConflict', context: context);

  @override
  bool get hasConflict {
    _$hasConflictAtom.reportRead();
    return super.hasConflict;
  }

  @override
  set hasConflict(bool value) {
    _$hasConflictAtom.reportWrite(value, super.hasConflict, () {
      super.hasConflict = value;
    });
  }

  late final _$localBackupAtom =
      Atom(name: 'BackupStoreBase.localBackup', context: context);

  @override
  Backup? get localBackup {
    _$localBackupAtom.reportRead();
    return super.localBackup;
  }

  @override
  set localBackup(Backup? value) {
    _$localBackupAtom.reportWrite(value, super.localBackup, () {
      super.localBackup = value;
    });
  }

  late final _$remoteBackupAtom =
      Atom(name: 'BackupStoreBase.remoteBackup', context: context);

  @override
  Backup? get remoteBackup {
    _$remoteBackupAtom.reportRead();
    return super.remoteBackup;
  }

  @override
  set remoteBackup(Backup? value) {
    _$remoteBackupAtom.reportWrite(value, super.remoteBackup, () {
      super.remoteBackup = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'BackupStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$selectedFrequencyAtom =
      Atom(name: 'BackupStoreBase.selectedFrequency', context: context);

  @override
  String? get selectedFrequency {
    _$selectedFrequencyAtom.reportRead();
    return super.selectedFrequency;
  }

  @override
  set selectedFrequency(String? value) {
    _$selectedFrequencyAtom.reportWrite(value, super.selectedFrequency, () {
      super.selectedFrequency = value;
    });
  }

  late final _$resolveConflictWithRemoteAsyncAction = AsyncAction(
      'BackupStoreBase.resolveConflictWithRemote',
      context: context);

  @override
  Future<void> resolveConflictWithRemote() {
    return _$resolveConflictWithRemoteAsyncAction
        .run(() => super.resolveConflictWithRemote());
  }

  late final _$resolveConflictWithLocalAsyncAction =
      AsyncAction('BackupStoreBase.resolveConflictWithLocal', context: context);

  @override
  Future<void> resolveConflictWithLocal() {
    return _$resolveConflictWithLocalAsyncAction
        .run(() => super.resolveConflictWithLocal());
  }

  late final _$BackupStoreBaseActionController =
      ActionController(name: 'BackupStoreBase', context: context);

  @override
  void setBackup(Backup backup) {
    final _$actionInfo = _$BackupStoreBaseActionController.startAction(
        name: 'BackupStoreBase.setBackup');
    try {
      return super.setBackup(backup);
    } finally {
      _$BackupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExpandedCategory(String categoryName, bool isExpanded) {
    final _$actionInfo = _$BackupStoreBaseActionController.startAction(
        name: 'BackupStoreBase.setExpandedCategory');
    try {
      return super.setExpandedCategory(categoryName, isExpanded);
    } finally {
      _$BackupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasConflict(bool value) {
    final _$actionInfo = _$BackupStoreBaseActionController.startAction(
        name: 'BackupStoreBase.setHasConflict');
    try {
      return super.setHasConflict(value);
    } finally {
      _$BackupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocalBackup(Backup? progress) {
    final _$actionInfo = _$BackupStoreBaseActionController.startAction(
        name: 'BackupStoreBase.setLocalBackup');
    try {
      return super.setLocalBackup(progress);
    } finally {
      _$BackupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRemoteBackup(Backup? progress) {
    final _$actionInfo = _$BackupStoreBaseActionController.startAction(
        name: 'BackupStoreBase.setRemoteBackup');
    try {
      return super.setRemoteBackup(progress);
    } finally {
      _$BackupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(String? value) {
    final _$actionInfo = _$BackupStoreBaseActionController.startAction(
        name: 'BackupStoreBase.setError');
    try {
      return super.setError(value);
    } finally {
      _$BackupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedFrequency(String? frequency) {
    final _$actionInfo = _$BackupStoreBaseActionController.startAction(
        name: 'BackupStoreBase.setSelectedFrequency');
    try {
      return super.setSelectedFrequency(frequency);
    } finally {
      _$BackupStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
backup: ${backup},
expandedCategories: ${expandedCategories},
hasConflict: ${hasConflict},
localBackup: ${localBackup},
remoteBackup: ${remoteBackup},
error: ${error},
selectedFrequency: ${selectedFrequency},
latestBackupData: ${latestBackupData}
    ''';
  }
}
