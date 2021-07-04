import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

//Not working;
class AnimatedIconLoader extends StatefulWidget {
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  AnimatedIconLoader({
    Key? key,
    required this.icon,
    required this.iconSize,
    this.iconColor = const Color(0xFF30169D),
  }) : super(key: key);
  @override
  _AnimatedIconLoaderState createState() => _AnimatedIconLoaderState();
}

class _AnimatedIconLoaderState extends State<AnimatedIconLoader>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Icon(
        widget.icon,
        size: widget.iconSize * controller.value,
        color: widget.iconColor,
      ),
    );
  }
}
