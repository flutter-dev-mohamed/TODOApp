import 'package:flutter/material.dart';
import 'package:todo_app/Pages/date_and_time.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/onboarding_screen.dart';
import 'package:todo_app/settings/notification.dart';
import 'package:todo_app/settings/settings.dart';
import 'package:todo_app/test.dart';
import 'Pages/task_list_page.dart';
import 'package:todo_app/Pages/home_page.dart';
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/Pages/taskGroups_drawer.dart';
import 'package:todo_app/gp_widgets/task_check_box.dart';
import 'package:todo_app/theme/theme.dart';
import 'package:todo_app/theme/util.dart';
import 'package:todo_app/Pages/loading_page.dart';
import 'package:todo_app/gp_widgets/custom_checkbox.dart';
import 'package:todo_app/settings/settings_button.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Notifications().initNotifications();

  runApp(const TODOApp());
}

class TODOApp extends StatefulWidget {
  const TODOApp({super.key});

  @override
  State<TODOApp> createState() => _TODOAppState();
}

class _TODOAppState extends State<TODOApp> {
  @override
  Widget build(BuildContext context) {
    final Settings settings = Settings();
    settings.loadSettings();

    settings.setChangeTheme(rebuild: () {
      setState(() {});
    });

    Data data = Data();

    settings.setAppTheme(context);
    return MaterialApp(
      home: const LoadingPage(),
      // home: const ShowBottomSheet(),
      // theme: themeData(),
      // theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      // theme: settings.getAppTheme(context),
      // darkTheme: settings.dark,
      theme: settings.lightTheme,
      darkTheme: settings.darkMode
          ? settings.darkTheme
          : settings.dynamicBrightness
              ? settings.darkTheme
              : null,
      themeMode: settings.dynamicBrightness ? ThemeMode.system : null,
      debugShowCheckedModeBanner: false,
    );
  }
}
