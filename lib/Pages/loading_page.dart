import 'package:flutter/material.dart';
import 'package:TribbianiNotes/Pages/home_page.dart';
import 'package:TribbianiNotes/dataBase/data_class.dart';

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
    await data.loadTaskGroups();
    // await data.loadTasks(groupId: data.taskGroupsList[0].id!);
    setState(() {
      dataIsLoaded = true;
    });
  }

  @override
  void initState() {
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
