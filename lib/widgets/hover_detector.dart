import 'package:flutter/material.dart';

class HoverDetector extends StatelessWidget {
  const HoverDetector({super.key, required this.onHover, required this.child});
  final void Function(bool isHovered) onHover;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTapDown: (_) => onHover(true),
        onTapUp: (_) => onHover(false),
        onTapCancel: () => onHover(false),
        child: child,
      ),
    );
  }
}
