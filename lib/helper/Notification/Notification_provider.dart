import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../Database/database_model.dart';
import '../../Database/database_service.dart';

class TaskNotificationProvider extends ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  TaskNotificationProvider() {
    _initFirebaseMessaging();
    _initLocalNotifications();
    _setupBackgroundTask();
  }

  Future<void> _initFirebaseMessaging() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

      String? token = await _firebaseMessaging.getToken();
      if (token != null) {}
    } else {
      print("User denied notification permissions.");
    }
  }

  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _setupBackgroundTask() {
    Workmanager().initialize(
      _backgroundTaskCallback,
      isInDebugMode: true,
    );

    Workmanager().registerPeriodicTask(
      "task-notification-checker",
      "checkUpcomingTasks",
      frequency: const Duration(minutes: 15),
    );
  }

  static void _backgroundTaskCallback() {
    Workmanager().executeTask((taskName, inputData) async {
      if (taskName == "checkUpcomingTasks") {
        final provider = TaskNotificationProvider();
        await provider._checkAndScheduleNotifications();
      }
      return Future.value(true);
    });
  }

  Future<void> _checkAndScheduleNotifications() async {
    final taskDatabase = TaskDatabase.instance;
    final upcomingTasks = await _getUpcomingTasks(taskDatabase);

    for (var task in upcomingTasks) {
      await _scheduleNotification(task);
    }
  }

  Future<List<Task>> _getUpcomingTasks(TaskDatabase database) async {
    final allTasks = await database.getAllTasks();
    final now = DateTime.now();

    return allTasks.where((task) {
      final taskDateTime = _parseDateAndTime(task);
      return taskDateTime.isAfter(now) && task.status != 'Completed';
    }).toList();
  }

  DateTime _parseDateAndTime(Task task) {
    final dateParts = task.dueDate.split('-');
    final timeParts = task.time.toString().split(':');

    return DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1]),
    );
  }

  Future<void> _scheduleNotification(Task task) async {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'task_channel',
        'Task Notifications',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    final notificationTime =
        _parseDateAndTime(task).subtract(const Duration(minutes: 30));

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      task.taskId ?? 0,
      'Upcoming Task: ${task.taskTitle}',
      'Priority: ${task.priority} | Assignee: ${task.assignee}',
      tz.TZDateTime.from(notificationTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  void _handleForegroundMessage(RemoteMessage message) {
    _showLocalNotification(message);
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    _showLocalNotification(message);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'task_channel',
        'Task Notifications',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecond,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }

  Future<void> triggerTaskNotification(Task task) async {
    await _scheduleNotification(task);
  }

  Future<void> checkOverdueTasks() async {
    final taskDatabase = TaskDatabase.instance;
    final allTasks = await taskDatabase.getAllTasks();
    final now = DateTime.now();

    for (var task in allTasks) {
      final taskDateTime = _parseDateAndTime(task);

      if (taskDateTime.isBefore(now) && task.status != 'Completed') {
        await _showOverdueTaskNotification(task);
      }
    }
  }

  Future<void> _showOverdueTaskNotification(Task task) async {
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'overdue_task_channel',
        'Overdue Task Notifications',
        importance: Importance.high,
        priority: Priority.high,
        color: Colors.red,
      ),
    );

    await _flutterLocalNotificationsPlugin.show(
      task.taskId ?? 0,
      'Overdue Task: ${task.taskTitle}',
      'This task was due on ${task.dueDate}',
      notificationDetails,
      payload: task.taskId.toString(),
    );
  }
}
