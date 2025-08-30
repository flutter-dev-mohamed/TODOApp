import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/theme/util.dart';
import 'package:todo_app/dataBase/database_helper.dart';

import 'notification.dart';

class Settings {
  Settings.init({
    this.autoDeleteDoneTask = true,
    this.dynamicBrightness = true,
    this.darkMode = false,
    this.sendNotifications = false,
  });
  static final Settings _settings = Settings.init();
  factory Settings() => _settings;

  // Settings properties
  bool autoDeleteDoneTask;
  bool dynamicBrightness;
  bool darkMode;
  bool sendNotifications;

  // Theme change callback
  late Function changeTheme;

  Future<void> loadSettings() async {
    final Settings savedSettings = await DatabaseHelper().getSettings();
    autoDeleteDoneTask = savedSettings.autoDeleteDoneTask;
    sendNotifications = savedSettings.sendNotifications;
    dynamicBrightness = savedSettings.dynamicBrightness;
    darkMode = savedSettings.darkMode;
  }

  Future<void> saveSettings() async {
    print('\n\n\n----Settings Updated----');
    print(toString());
    await DatabaseHelper().updateSettings(this);
    loadSettings();
  }

  ThemeData darkTheme = ThemeData();
  ThemeData lightTheme = ThemeData();
  void setAppTheme(BuildContext context) {
    final TextTheme textTheme = createTextTheme(context, "Roboto", "Lexend");
    final MaterialTheme theme = MaterialTheme(textTheme);
    darkTheme = theme.dark();
    lightTheme = theme.light();
  }

  void setChangeTheme({required Function rebuild}) {
    changeTheme = rebuild;
  }

  /// Send notification if enabled
  void sendNotification({
    required int id,
    required String? title,
    String? body,
  }) {
    if (!sendNotifications) return;
    print('-\n\n\nSending Notification...\n\n\n');

    Notifications().sendNotification(
      id: id,
      title: title,
      body: body,
    );
  }

  void scheduleNotification({required Task task}) {
    String time;
    try {
      final timeParts = task.time!.split(':');
      int hour = int.parse(timeParts[0]);
      final int minute = int.parse(timeParts[1]);

      String meridiem = 'AM';
      if (hour >= 12) {
        meridiem = 'PM';
        if (hour > 12) hour -= 12;
      }
      if (hour == 0) hour = 12;

      final mm = minute.toString().padLeft(2, '0');
      time = '$hour:$mm $meridiem';
    } catch (e) {
      print(
          '=\n\nSettings:\nscheduleNotification:\n Time and Date issue:\n $e\n\n');
      time = '';
    }

    try {
      Notifications().scheduleNotification(
        id: task.id!,
        title: task.title,
        body: 'Today, $time',
        dateStr: task.date!,
        timeStr: task.time!,
        // repeat: task.repeat,
      );
    } catch (e) {
      print('=\n\nSettings:\nscheduleNotification:\n$e\n\n');
    }
  }

  /// Convert settings to map for database storage
  Map<String, dynamic> toMap() {
    return {
      'autoDeleteDoneTask': autoDeleteDoneTask ? 1 : 0,
      'dynamicBrightness': dynamicBrightness ? 1 : 0,
      'darkMode': darkMode ? 1 : 0,
      'sendNotifications': sendNotifications ? 1 : 0,
    };
  }

  /// Create settings from map
  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings.init(
      autoDeleteDoneTask: map['autoDeleteDoneTask'] == 1,
      dynamicBrightness: map['dynamicBrightness'] == 1,
      darkMode: map['darkMode'] == 1,
      sendNotifications: map['sendNotifications'] == 1,
    );
  }

  //
  @override
  String toString() {
    return '''
Settings:
  autoDeleteDoneTask: $autoDeleteDoneTask
  sendNotifications: $sendNotifications
  dynamicBrightness: $dynamicBrightness
  darkMode: $darkMode
''';
  }
}

enum Repeat {
  Never,
  Daily,
  Weekly,
  Monthly,
  Yearly,
}

// final Settings settings = Settings();
