import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieToggleButton extends StatefulWidget {
  LottieToggleButton({
    super.key,
    required this.label,
    this.description = '',
    required this.lottieAsset,
    required this.onTap,
    required this.value,
    this.active = true,
    this.duration = const Duration(milliseconds: 300),
    this.size = const Size(50, 20),
    this.labelStyle = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    this.descriptionStyle = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
  });

  final String label;
  final String lottieAsset;
  final Function onTap;
  final Size size;
  final TextStyle labelStyle;
  final String description;
  final TextStyle descriptionStyle;
  final Duration duration;
  bool value;
  bool active;

  @override
  State<LottieToggleButton> createState() => _LottieToggleButtonState();
}

class _LottieToggleButtonState extends State<LottieToggleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.value) {
      _animationController.value = 1.0;
    } else {
      _animationController.value = 0;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void didUpdateWidget(covariant LottieToggleButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textAlign: TextAlign.start,
                softWrap: true,
                widget.label,
                style: widget.labelStyle,
              ),
              GestureDetector(
                onTap: widget.active
                    ? () {
                        widget.value = !widget.value;
                        widget.value
                            ? _animationController.forward()
                            : _animationController.reverse();
                        widget.onTap();
                      }
                    : null,
                child: SizedBox(
                  width: widget.size.width,
                  height: widget.size.height,
                  child: Lottie.asset(
                    widget.lottieAsset,
                    controller: _animationController,
                  ),
                ),
              ),
            ],
          ),
          if (widget.description.isNotEmpty)
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 200,
              ),
              child: Text(
                widget.description,
                softWrap: true,
                // overflow: TextOverflow.ellipsis,
                maxLines: null,
                style: widget.descriptionStyle,
              ),
            ),
        ],
      ),
    );
  }
}
