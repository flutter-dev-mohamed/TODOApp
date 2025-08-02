import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DeleteTaskButton extends StatelessWidget {
  const DeleteTaskButton({
    super.key,
    required this.delete,
  });
  final Function() delete;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: (context) {
        delete();
      },
      backgroundColor: const Color(0xFFD5E2DE),
      foregroundColor: Colors.red[400],
      borderRadius: BorderRadius.circular(12),
      autoClose: true,
      icon: Icons.delete_rounded,
      label: 'Delete',
    );
  }
}
