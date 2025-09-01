import 'package:flutter/material.dart';
import 'package:TribbianiNotes/Pages/date_and_time.dart';
import 'package:TribbianiNotes/Pages/repeat_page.dart';
import 'package:TribbianiNotes/dataBase/task_class_mod.dart';
import 'package:TribbianiNotes/onboarding_screen.dart';
import 'package:TribbianiNotes/settings/notification.dart';
import 'package:TribbianiNotes/settings/settings.dart';
import 'package:TribbianiNotes/test.dart';
import 'Pages/task_list_page.dart';
import 'package:TribbianiNotes/Pages/home_page.dart';
import 'package:TribbianiNotes/dataBase/data_class.dart';
import 'package:TribbianiNotes/Pages/taskGroups_drawer.dart';
import 'package:TribbianiNotes/gp_widgets/task_check_box.dart';
import 'package:TribbianiNotes/theme/theme.dart';
import 'package:TribbianiNotes/theme/util.dart';
import 'package:TribbianiNotes/Pages/loading_page.dart';
import 'package:TribbianiNotes/gp_widgets/custom_checkbox.dart';
import 'package:TribbianiNotes/settings/settings_button.dart';

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
    settings.loadSettings().then(
      (value) {
        if (settings.onboarding) {
          setState(() {});
        }
      },
    );

    settings.setChangeTheme(rebuild: () {
      setState(() {});
    });

    Data data = Data();

    settings.setAppTheme(context);
    return MaterialApp(
      home: settings.onboarding ? IntroductionPage() : LoadingPage(),
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
