import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/onboarding_screen.dart';
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
    settings.loadSettings();

    settings.setChangeTheme(rebuild: () {
      setState(() {});
    });

    Data data = Data();

    return MaterialApp(
      home: const LoadingPage(),
      // theme: themeData(),
      // theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      theme: settings.getAppTheme(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
