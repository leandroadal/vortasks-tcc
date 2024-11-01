import 'package:mobx/mobx.dart';
import 'package:vortasks/core/storage/local_storage.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

import 'package:vortasks/models/checkin/check_in.dart';

part 'checkin_store.g.dart';

class CheckInStore = CheckInStoreBase with _$CheckInStore;

abstract class CheckInStoreBase with Store {
  CheckInStoreBase() {
    _loadCheckInData();
  }

  @observable
  ObservableList<CheckIn> checkIns = ObservableList<CheckIn>();

  @observable
  DateTime? lastCheckInDate;

  @action
  void setCheckIns(List<CheckIn> newCheckIns) {
    checkIns.clear();
    checkIns.addAll(newCheckIns);
    _saveCheckIns();
  }

  @action
  void checkIn() {
    DateTime now = DateTime.now().toUtc();

    // Cria um novo CheckIn caso não exista para o mes
    CheckIn newCheckIn = CheckIn(
      id: const Uuid().v4(),
      countCheckInDays: 0,
      month: now.month,
      year: now.year,
      lastCheckInDate: now,
    );

    // Verifica se já existe um check-in para o mês atual
    CheckIn currentMonthCheckIn = checkIns.firstWhere(
        (checkIn) => checkIn.year == now.year && checkIn.month == now.month,
        orElse: () => newCheckIn); // Retorna o newCheckIn se não encontrar

    if (currentMonthCheckIn == newCheckIn) {
      // Se o currentMonthCheckIn é o new, significa que não havia um check-in para o mês atual
      checkIns.add(currentMonthCheckIn);
    } else {
      // Se já houver um check-in para o mês atual:
      // 1. Verifica se o último check-in foi hoje
      if (currentMonthCheckIn.lastCheckInDate != null &&
          currentMonthCheckIn.lastCheckInDate!.day == now.day) {
        // Se já fez check-in hoje, não faz nada
        return;
      }

      // 2. Se o último check-in não foi hoje, incrementa o contador e atualiza a data do último check-in
      currentMonthCheckIn.countCheckInDays++;
      currentMonthCheckIn.lastCheckInDate = now;
    }

    _saveCheckInData();
  }

  // ================ Armazenamento local ================

  // Carregar dados de check-in do armazenamento local
  void _loadCheckInData() {
    _loadCheckIns();

    // Carrega a data do ultimo check-in
    final lastCheckInDateJson = LocalStorage.getString('lastCheckInDate');
    if (lastCheckInDateJson != null) {
      lastCheckInDate = DateTime.parse(lastCheckInDateJson);
    }
  }

  // Salvar dados de check-in no armazenamento local
  void _saveCheckInData() {
    _saveCheckIns();

    // Salva a data do ultimo check-in
    if (lastCheckInDate != null) {
      LocalStorage.saveData(
          'lastCheckInDate', lastCheckInDate!.toIso8601String());
    }
  }

  // Salva a lista de CheckIns no armazenamento local
  void _saveCheckIns() {
    final jsonList = checkIns.map((checkIn) => checkIn.toJson()).toList();
    LocalStorage.saveData('checkIns', jsonEncode(jsonList));
  }

  // Carrega a lista de CheckIns do armazenamento local
  void _loadCheckIns() {
    final checkInsJson = LocalStorage.getString('checkIns');
    if (checkInsJson != null) {
      final decodedJson = jsonDecode(checkInsJson) as List;
      final loadedCheckIns =
          decodedJson.map((item) => CheckIn.fromJson(item)).toList();
      checkIns = ObservableList.of(loadedCheckIns);
    }
  }
}
