// import 'package:todo_app/dataBase/task_class_mod.dart';
// import 'package:todo_app/dataBase/data_class.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
//
// class EditableTextWidget extends StatefulWidget {
//   EditableTextWidget({
//     super.key,
//     required this.data,
//     required this.groupId,
//     this.textStyle = const TextStyle(),
//     required this.initText,
//     required this.task,
//     required this.taskTitle,
//     // required this.updateTask,
//     // required this.addTask,
//     required this.edit,
//     required this.rebuild,
//   });
//
//   Data data;
//   int groupId;
//   final String initText; //-------------------------------
//   final TextStyle textStyle;
//   Task task;
//   bool taskTitle;
//   // final Function(Task) updateTask;
//   // final Function(Task) addTask;
//   final Function(bool, Task) edit;
//   final Function() rebuild;
//
//   @override
//   State<EditableTextWidget> createState() => _EditableTextWidgetState();
// }
//
// class _EditableTextWidgetState extends State<EditableTextWidget> {
//   late String text; //-------------------------------
//   bool isEditing = false; //-------------------------------
//   bool newTask =
//       false; // anewTask flag just for the FUCKING focusNode.dispose func!!!
//   late TextEditingController _controller;
//   FocusNode? _focusNode;
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//
//     if (widget.task.newTask) {
//       _focusNode = FocusNode();
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _focusNode!.requestFocus();
//         newTask = true;
//         widget.edit(true, widget.task);
//       });
//     }
//     text = widget.initText; //-------------------------------
//     _controller.text = text; //-------------------------------
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//     if (newTask) {
//       _focusNode!.dispose();
//     }
//   }
//
//   void _saveEdit() {
//     text = _controller.text; //-------------------------------
//     isEditing = false; //-------------------------------
//     widget.edit(isEditing, widget.task);
//
//     // new task
//     if (widget.task.newTask) {
//       if (_controller.text.isNotEmpty) {
//         widget.task.title = _controller.text;
//         widget.task.newTask = false;
//         widget.data.addTask(
//             task: widget.task,
//             groupId: widget.groupId,
//             rebuild: widget.rebuild);
//       } else {
//         widget.task.newTask = false;
//         widget.edit(false, widget.task);
//       }
//     } else {
//       // old task
//
//       if (widget.taskTitle) {
//         widget.task.title = text;
//       } else {
//         widget.task.description = text;
//       }
//       widget.data.updateTask(task: widget.task, rebuild: widget.rebuild);
//     }
//     widget.rebuild();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Color? defaultTextColor = Theme.of(context).textTheme.bodyMedium?.color;
//     Color hinTextColor = (defaultTextColor ?? Colors.black).withOpacity(0.2);
//     return (isEditing || widget.task.newTask)
//         ? TextField(
//             style: widget.textStyle,
//             controller: _controller,
//             focusNode: widget.task.newTask ? _focusNode : null,
//             maxLines: null,
//             minLines: 1,
//             keyboardType: TextInputType.multiline,
//             autofocus: true,
//             onEditingComplete: _saveEdit,
//             onTapOutside: (event) {
//               setState(() {
//                 isEditing = false;
//               });
//               widget.edit(isEditing, widget.task);
//               _saveEdit();
//             },
//
//             //
//             decoration: widget.taskTitle
//                 ? const InputDecoration(
//                     border: InputBorder.none,
//                   )
//                 : InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "Add note",
//                     hintStyle: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: hinTextColor,
//                     ),
//                   ),
//           )
// //-----------------------------------------------------------------
//         : GestureDetector(
//             onTap: () {
//               setState(() {
//                 isEditing = true;
//                 widget.edit(isEditing, widget.task);
//               });
//             },
//             child: Container(
//               width: RenderErrorBox.minimumWidth,
//               child: !widget.taskTitle && text.isEmpty
//                   ? Text(
//                       'Add note',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: hinTextColor,
//                       ),
//                     )
//                   : Text(
//                       text,
//                       style: widget.textStyle,
//                     ),
//             ),
//           );
//   }
// }
