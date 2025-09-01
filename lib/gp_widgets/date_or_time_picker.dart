import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DateOrTimePicker extends StatelessWidget {
  DateOrTimePicker({
    super.key,
    required this.title,
    required this.onTapToggleButton,
    required this.animationController,
    required this.onDateTimeChanged,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.onTap,
    this.leading,
    this.subtitle,
    this.decoration,
    this.expand = false,
    this.timePicker = false,
  });

  final Decoration? decoration;
  final GestureTapCallback onTapToggleButton;
  final AnimationController animationController;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime) onDateTimeChanged;
  final void Function()? onTap;
  final Widget? title;
  final Widget? leading;
  final Widget? subtitle;
  final bool expand;
  final bool timePicker;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: leading,
            title: title,
            subtitle: subtitle,
            trailing: trailing(),
            onTap: onTap,
          ),
          if (expand)
            Divider(
              height: 0,
              color: Theme.of(context).colorScheme.primary,
            ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: expand
                ? timePicker
                    ? timePickerW()
                    : datePicker()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget trailing() {
    return GestureDetector(
      onTap: onTapToggleButton,
      child: SizedBox(
        width: 50,
        height: 24,
        child: Lottie.asset(
          'assets/Discord Toggle (Sized).json',
          controller: animationController,
        ),
      ),
    );
  }

  Widget datePicker() {
    return CalendarDatePicker(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onDateChanged: onDateTimeChanged,
    );
  }

  Widget timePickerW() {
    return SizedBox(
      height: 216,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: initialDate,
        onDateTimeChanged: onDateTimeChanged,
      ),
    );
  }
}
