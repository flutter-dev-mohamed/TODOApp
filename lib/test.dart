//
// class DateOption extends StatefulWidget {
//   DateOption({
//     super.key,
//     required this.task,
//     this.rebuild,
//   });
//   Task task;
//   final void Function()? rebuild;
//
//   @override
//   State<DateOption> createState() => _DateOptionState();
// }
//
// class _DateOptionState extends State<DateOption>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//
//   bool expand = false;
//
//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     if (widget.task.hasDate) {
//       animationController.value = 1.0;
//     }
//   }
//
//   void onTapToggleButton() {
//     // TODO: add the setState and change task values
//     widget.task.hasDate = !widget.task.hasDate;
//     if (widget.task.hasDate) {
//       animationController.forward();
//       if (widget.task.date == null) {
//         widget.task.date =
//         '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';
//         print('-\n\nDateOption\nonTapToggleButton\n${widget.task.date}\n\n');
//       }
//       print(
//           '-\n\nDateOption\nonTapToggleButton\ntask.hasDate: ${widget.task.hasDate}\n\n');
//     } else {
//       print(
//           '-\n\nDateOption\nonTapToggleButton\ntask.hasDate: ${widget.task.hasDate}\n\n');
//       widget.task.date = null;
//       expand = false;
//       animationController.reverse();
//     }
//     setState(() {});
//     widget.rebuild!();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DateOrTimePicker(
//       title: Text('Date'),
//       subtitle: widget.task.date != null
//           ? Timestamp(
//         task: widget.task,
//         dateOnly: true,
//       )
//           : null,
//       animationController: animationController,
//       initialDate: widget.task.date != null
//           ? DateTime.parse(widget.task.date!)
//           : DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100),
//       onDateTimeChanged: (date) {
//         //   TODO:
//         widget.task.date =
//         '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
//         print(
//             '-\n\nDateOption\nonDateTimeChanged\ntask.date: ${widget.task.date}\n\n');
//         // setState(() {});
//         if (widget.rebuild != null) widget.rebuild!();
//       },
//       onTapToggleButton: onTapToggleButton,
//       onTap: widget.task.hasDate
//           ? () {
//         expand = !expand;
//         print('-\n\nDateOption\nonTap\n$expand\n\n');
//         setState(() {});
//       }
//           : null,
//       expand: expand,
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.secondaryContainer,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//       ),
//     );
//   }
// }
