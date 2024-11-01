import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:vortasks/core/storage/local_storage.dart';
import 'package:vortasks/core/themes/app_theme.dart';
import 'package:vortasks/utils/lifecycle_event_handler.dart';
import 'package:vortasks/screens/home/home_screen.dart';
import 'package:vortasks/services/notification_service.dart';
import 'package:vortasks/utils/setup_locator.dart';
import 'package:vortasks/stores/theme_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();

  Intl.defaultLocale = 'pt_BR';
  await initializeDateFormatting('pt_BR', null);
  setupGetIt();

  // Inicializa o serviço de notificação
  final notificationService = GetIt.I<NotificationService>();
  await notificationService.initialize();

  // Define um listener para verificar se o aplicativo está em primeiro plano
  WidgetsBinding.instance.addObserver(
    LifecycleEventHandler(
      resumeCallBack: () => NotificationService.isAppForeground = true,
      suspendingCallBack: () => NotificationService.isAppForeground = false,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeStore themeStore = GetIt.I<ThemeStore>();
    return Observer(builder: (_) {
      return MaterialApp(
        title: 'Vortasks',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeStore.currentTheme,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: const HomeScreen(),
      );
    });
  }
}
