import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:vortasks/core/storage/local_storage.dart';
part 'theme_store.g.dart';

class ThemeStore = ThemeStoreBase with _$ThemeStore;

abstract class ThemeStoreBase with Store {
  ThemeStoreBase() {
    _loadTheme();
  }

  @observable
  ThemeMode currentTheme = ThemeMode.system;

  @action
  void toggleTheme() {
    switch (currentTheme) {
      case ThemeMode.system:
        currentTheme = ThemeMode.light;
        break;
      case ThemeMode.light:
        currentTheme = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        currentTheme = ThemeMode.system;
        break;
    }
    _saveTheme();
  }

  // ================ Armazenamento local ================

  void _saveTheme() {
    final themeName = currentTheme.toString().split('.').last;
    LocalStorage.saveData('theme', themeName);
  }

  void _loadTheme() {
    final themeName = LocalStorage.getString('theme') ?? 'system';
    currentTheme = ThemeMode.values.firstWhere(
      (theme) => theme.toString().split('.').last == themeName,
      orElse: () => ThemeMode.system,
    );
  }
}
