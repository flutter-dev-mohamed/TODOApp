import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'Pages/task_list_page.dart';
import 'theme_data.dart';
import 'package:todo_app/Pages/home_page.dart';
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/Pages/taskGroups_drawer.dart';
import 'package:todo_app/gp_widgets/task_check_box.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'package:todo_app/gp_widgets/confetti_miss.dart';
// import 'package:todo_app/theme/theme.dart';
// import 'package:todo_app/theme/util.dart';

void main() {
  runApp(const TODOApp());
}

class TODOApp extends StatelessWidget {
  const TODOApp({super.key});

  @override
  Widget build(BuildContext context) {
    // get system brightness
    // final brightness = View.of(context).platformDispatcher.platformBrightness;

    // TextTheme textTheme = createTextTheme(context, "Roboto", "Lexend");

    // MaterialTheme theme = MaterialTheme(textTheme);

    Data data = Data();

    return MaterialApp(
      home: const LoadingPage(),
      theme: themeData(),
      // theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Data data = Data();
  bool dataIsLoaded = false;
  bool navigated = false; // track if navigation already happened

  Future<void> loadData() async {
    print('loadData');
    await data.loadTaskGroups();
    // await data.loadTasks(groupId: data.taskGroupsList[0].id!);
    setState(() {
      dataIsLoaded = true;
    });
  }

  @override
  void initState() {
    print('init loadingPage');
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (dataIsLoaded && !navigated && data.taskGroupsList.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navigated = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              data: data,
              groupId: 1,
              groupIndex: 0,
            ),
          ),
        );
      });
    }
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
