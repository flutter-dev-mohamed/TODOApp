// ignore_for_file: prefer_const_constructors

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ConfettiMiss extends StatefulWidget {
  ConfettiMiss({super.key});

  @override
  State<ConfettiMiss> createState() => _ConfettiMissState();
}

class _ConfettiMissState extends State<ConfettiMiss> {
  ConfettiController confettiController = ConfettiController(
    duration: Duration(milliseconds: 1),
  );

  Widget confetti = Container();

  void callback(Widget) {
    setState(() {
      confetti = Widget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: NewCheckBox(
                callback: callback,
              ),
            ),
            confetti,
          ],
        ),
      ),
    );
  }
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
class NewCheckBox extends StatefulWidget {
  NewCheckBox({
    super.key,
    required this.callback,
  });
  Function(Widget) callback;
  @override
  State<NewCheckBox> createState() => _NewCheckBoxState();
}

class _NewCheckBoxState extends State<NewCheckBox> {
  bool value = false;
  ConfettiController confettiController = ConfettiController();

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (bool? newValue) {
        setState(() {
          value = newValue ?? false;
          widget.callback(
            confetti(),
          );
        });
        if (newValue!) {
          confettiController.play();
          Future.delayed(
            Duration(milliseconds: 300),
            () {
              confettiController.stop();
            },
          );
        }
      },
      shape: const CircleBorder(),
    );
  }

  Widget confetti() {
    return ConfettiWidget(
      confettiController: confettiController,
      shouldLoop: false,
      strokeWidth: 1,
      numberOfParticles: 80,
      emissionFrequency: 0.01,
      blastDirection: -30 * (pi / 180),
      strokeColor: Colors.blue[200]!,
      pauseEmissionOnLowFrameRate: false,

      colors: [
        Theme.of(context).primaryColor.withOpacity(0.8),
        const Color(0xFF7FE7D0),
        const Color(0x947FE7D0),
        const Color(0xFFACEAD5),
        const Color(0xFF54CBB1),
      ],
      child: Container(
        child: Text('🥳'),
      ), // empty container to mark origin
    );
  }
}
