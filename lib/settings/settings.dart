import 'package:flutter/material.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/theme/util.dart';
import 'package:todo_app/dataBase/database_helper.dart';

import 'notification.dart';

class Settings {
  Settings({
    this.autoDeleteDoneTask = true,
    this.dynamicBrightness = true,
    this.darkMode = false,
    this.sendNotifications = false,
  });

  bool autoDeleteDoneTask;
  bool dynamicBrightness;
  Brightness? _brightness;
  bool darkMode;
  bool sendNotifications;
  late Function changeTheme;

  Future<void> loadSettings() async {
    final Settings _settings = await DatabaseHelper().getSettings();
    autoDeleteDoneTask = _settings.autoDeleteDoneTask;
    sendNotifications = _settings.sendNotifications;
    dynamicBrightness = _settings.dynamicBrightness;
    darkMode = _settings.darkMode;
  }

  Future<void> updateSettings() async {
    print('\n\n\n----Settings Updated----');
    print(toString());
    await DatabaseHelper().updateSettings(Settings(
      sendNotifications: sendNotifications,
      autoDeleteDoneTask: autoDeleteDoneTask,
      dynamicBrightness: dynamicBrightness,
      darkMode: darkMode,
    ));
    loadSettings();
  }

  ThemeData getAppTheme(BuildContext context) {
    final TextTheme textTheme = createTextTheme(context, "Roboto", "Lexend");
    final MaterialTheme theme = MaterialTheme(textTheme);

    if (dynamicBrightness) {
      final brightness = View.of(context).platformDispatcher.platformBrightness;
      return brightness == Brightness.light ? theme.light() : theme.dark();
    } else {
      return darkMode ? theme.dark() : theme.light();
    }
  }

  void setChangeTheme({required Function rebuild}) {
    changeTheme = rebuild;
  }

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

  Map<String, dynamic> toMap() {
    return {
      'autoDeleteDoneTask': autoDeleteDoneTask ? 1 : 0,
      'dynamicBrightness': dynamicBrightness ? 1 : 0,
      'darkMode': darkMode ? 1 : 0,
      'sendNotifications': sendNotifications ? 1 : 0,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
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

final Settings settings = Settings();
