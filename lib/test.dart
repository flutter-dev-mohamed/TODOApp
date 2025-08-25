// import 'package:flutter/material.dart';
// import 'package:todo_app/theme/theme.dart';
// import 'package:todo_app/theme/util.dart';
// import 'package:todo_app/dataBase/database_helper.dart';
// import 'package:todo_app/settings/notification.dart';
//
// class Settings {
//   // Private constructor
//   Settings._({
//     this.autoDeleteDoneTask = true,
//     this.dynamicBrightness = true,
//     this.darkMode = false,
//     this.sendNotifications = false,
//   });
//
//   // Singleton instance
//   static final Settings _instance = Settings._();
//
//   // Factory constructor to return the singleton instance
//   factory Settings() => _instance;
//
//   // Settings properties
//   bool autoDeleteDoneTask;
//   bool dynamicBrightness;
//   bool darkMode;
//   bool sendNotifications;
//
//   // Theme change callback
//   VoidCallback? _onThemeChange;
//
//   // Database helper instance
//   final DatabaseHelper _dbHelper = DatabaseHelper();
//
//   /// Initialize settings from database
//   Future<void> loadSettings() async {
//     try {
//       final Settings savedSettings = await _dbHelper.getSettings();
//       autoDeleteDoneTask = savedSettings.autoDeleteDoneTask;
//       sendNotifications = savedSettings.sendNotifications;
//       dynamicBrightness = savedSettings.dynamicBrightness;
//       darkMode = savedSettings.darkMode;
//     } catch (e) {
//       // Handle error (e.g., use default values)
//       print('Error loading settings: $e');
//     }
//   }
//
//   /// Save current settings to database
//   Future<void> saveSettings() async {
//     try {
//       print('\n\n\n----Settings Saved----');
//       print(toString());
//       await _dbHelper.updateSettings(this);
//
//       // Notify listeners about theme changes
//       if (_onThemeChange != null) {
//         _onThemeChange!();
//       }
//     } catch (e) {
//       print('Error saving settings: $e');
//       rethrow;
//     }
//   }
//
//   /// Get appropriate theme based on settings
//   ThemeData getAppTheme(BuildContext context) {
//     final TextTheme textTheme = createTextTheme(context, "Roboto", "Lexend");
//     final MaterialTheme theme = MaterialTheme(textTheme);
//
//     if (dynamicBrightness) {
//       final brightness = View.of(context).platformDispatcher.platformBrightness;
//       return brightness == Brightness.light ? theme.light() : theme.dark();
//     } else {
//       return darkMode ? theme.dark() : theme.light();
//     }
//   }
//
//   /// Register a callback for theme changes
//   void setOnThemeChangeListener(VoidCallback callback) {
//     _onThemeChange = callback;
//   }
//
//   /// Remove theme change listener
//   void removeOnThemeChangeListener() {
//     _onThemeChange = null;
//   }
//
//   void sendNotification({
//     required int id,
//     required String? title,
//     String? body,
//   }) {
//     if (!sendNotifications) return;
//     print('Sending Notification...');
//
//     Notifications().sendNotification(
//       id: id,
//       title: title,
//       body: body,
//     );
//   }
//
//   /// Convert settings to map for database storage
//   Map<String, dynamic> toMap() {
//     return {
//       'autoDeleteDoneTask': autoDeleteDoneTask ? 1 : 0,
//       'dynamicBrightness': dynamicBrightness ? 1 : 0,
//       'darkMode': darkMode ? 1 : 0,
//       'sendNotifications': sendNotifications ? 1 : 0,
//     };
//   }
//
//   /// Create settings from map
//   factory Settings.fromMap(Map<String, dynamic> map) {
//     return Settings._(
//       autoDeleteDoneTask: map['autoDeleteDoneTask'] == 1,
//       dynamicBrightness: map['dynamicBrightness'] == 1,
//       darkMode: map['darkMode'] == 1,
//       sendNotifications: map['sendNotifications'] == 1,
//     );
//   }
// }
