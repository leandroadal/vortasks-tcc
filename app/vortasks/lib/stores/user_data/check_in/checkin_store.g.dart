// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckInStore on CheckInStoreBase, Store {
  late final _$checkInsAtom =
      Atom(name: 'CheckInStoreBase.checkIns', context: context);

  @override
  ObservableList<CheckIn> get checkIns {
    _$checkInsAtom.reportRead();
    return super.checkIns;
  }

  @override
  set checkIns(ObservableList<CheckIn> value) {
    _$checkInsAtom.reportWrite(value, super.checkIns, () {
      super.checkIns = value;
    });
  }

  late final _$lastCheckInDateAtom =
      Atom(name: 'CheckInStoreBase.lastCheckInDate', context: context);

  @override
  DateTime? get lastCheckInDate {
    _$lastCheckInDateAtom.reportRead();
    return super.lastCheckInDate;
  }

  @override
  set lastCheckInDate(DateTime? value) {
    _$lastCheckInDateAtom.reportWrite(value, super.lastCheckInDate, () {
      super.lastCheckInDate = value;
    });
  }

  late final _$CheckInStoreBaseActionController =
      ActionController(name: 'CheckInStoreBase', context: context);

  @override
  void setCheckIns(List<CheckIn> newCheckIns) {
    final _$actionInfo = _$CheckInStoreBaseActionController.startAction(
        name: 'CheckInStoreBase.setCheckIns');
    try {
      return super.setCheckIns(newCheckIns);
    } finally {
      _$CheckInStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void checkIn() {
    final _$actionInfo = _$CheckInStoreBaseActionController.startAction(
        name: 'CheckInStoreBase.checkIn');
    try {
      return super.checkIn();
    } finally {
      _$CheckInStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
checkIns: ${checkIns},
lastCheckInDate: ${lastCheckInDate}
    ''';
  }
}
