import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:TribbianiNotes/settings/settings.dart';

class Notifications {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool _hasPermission = false;

  bool get isInitialized => _isInitialized;
  bool get hasPermission => _hasPermission;

  Future<void> initNotifications() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const _androidInitSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const DarwinInitializationSettings _iosInitSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: _androidInitSettings,
      iOS: _iosInitSettings,
    );

    _isInitialized = await _flutterLocalNotificationsPlugin
            .initialize(initializationSettings) ??
        false;

    _hasPermission = await requestNotificationsPermission();
  }

  Future<bool> requestNotificationsPermission() async {
    if (Platform.isIOS) {
      bool iosPermission = await _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
      return iosPermission;
    }
    if (Platform.isAndroid) {
      bool androidPermission = await _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.requestNotificationsPermission() ??
          false;
      return androidPermission;
    }
    return false;
  }

  Future<NotificationDetails> notificationDetails(
      {int groupId = 0, String taskGroupName = 'Task Group Name'}) async {
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '$groupId',
      taskGroupName, // what the user sees in system setting
      groupKey: '$groupId', // used to group notifications
      channelDescription: 'Notifications from: $taskGroupName',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      // TODO: add an Icon
      // icon: "ic_notification",
    );
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(threadIdentifier: 'threadIdentifier');

    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  tz.TZDateTime parseToTZDateTime(String dateStr, String timeStr) {
    // Parse the date and time strings
    final dateTimeStr = '$dateStr $timeStr';
    final dateTime = DateTime.parse(dateTimeStr);

    // Convert to TZDateTime in local timezone
    return tz.TZDateTime.from(dateTime, tz.local);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String dateStr,
    required String timeStr,
    String? body,
    Repeat? repeat,
  }) async {
    final scheduledDate = parseToTZDateTime(dateStr, timeStr);
    const AndroidScheduleMode androidScheduleMode =
        AndroidScheduleMode.inexactAllowWhileIdle;
    DateTimeComponents? dateTimeComponents;

    switch (repeat) {
      case Repeat.Daily:
        dateTimeComponents = DateTimeComponents.time;
        break;
      case Repeat.Weekly:
        dateTimeComponents = DateTimeComponents.dayOfWeekAndTime;
        break;
      case Repeat.Monthly:
        dateTimeComponents = DateTimeComponents.dayOfMonthAndTime;
        break;
      case Repeat.Yearly:
        dateTimeComponents = DateTimeComponents.dateAndTime;
        break;
      default:
        dateTimeComponents = null;
    }

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      await notificationDetails(),
      androidScheduleMode: androidScheduleMode,
      matchDateTimeComponents: dateTimeComponents,
    );
  }
}
