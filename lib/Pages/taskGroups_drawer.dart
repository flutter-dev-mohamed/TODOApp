import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/data_class.dart';

class TaskgroupsDrawer extends StatefulWidget {
  TaskgroupsDrawer({
    super.key,
    required this.data,
  });
  Data data;

  @override
  State<TaskgroupsDrawer> createState() => _TaskgroupsDrawerState();
}

class _TaskgroupsDrawerState extends State<TaskgroupsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.data.taskGroupsList.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      onPressed: () {},
                      child: Text(widget.data.taskGroupsList[index].title),
                    );
                  },
                ),
              ),
            ),

            //
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Add a task group'),
                      Icon(Icons.format_list_bulleted_add),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
