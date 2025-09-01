import 'package:flutter/material.dart';
import 'package:TribbianiNotes/onboarding_screen.dart';
import 'package:TribbianiNotes/settings/notification.dart';
import 'package:TribbianiNotes/settings/settings.dart';
import 'package:TribbianiNotes/dataBase/data_class.dart';
import 'package:TribbianiNotes/Pages/loading_page.dart';

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
      darkTheme: settings.darkTheme,
      themeMode: settings.dynamicBrightness
          ? ThemeMode.system
          : settings.darkMode
              ? ThemeMode.dark
              : ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
