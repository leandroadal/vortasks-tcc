import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vortasks/screens/tasks/task_info_screen.dart';
import 'package:vortasks/utils/setup_locator.dart';
import 'package:vortasks/stores/tasks/task_store.dart';

class NotificationService {
  static bool isAppForeground = true;

  // Cria uma instância do plugin de notificações locais
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Inicializa o serviço de notificação
  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (payload != null) {
          // Buscar a tarefa pelo ID no TaskStore
          final taskStore = GetIt.I<TaskStore>();
          final task =
              taskStore.observableTasks.firstWhere((t) => t.id == payload);
          // Navega para a tela da tarefa com o ID do payload
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => TaskInfoScreen(
                  task: task.task), // Passa o ID da tarefa para a tela
            ),
          );
        }
      },
    );
  }

  // Cancela uma notificação agendada pelo ID
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // Exibe uma notificação imediatamente
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await requestNotificationPermission();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('vortasks_channel_id', 'Vortasks',
            channelDescription: 'Notificações do Vortasks',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<void> requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied) {
      // Solicita a permissão
      status = await Permission.notification.request();
      if (status.isGranted) {
        // Permissão concedida
      } else if (status.isPermanentlyDenied) {
        // O usuário negou permanentemente a permissão
        // Direciona o usuário para as configurações do aplicativo para conceder a permissão manualmente
        openAppSettings();
      }
    }
  }
}
