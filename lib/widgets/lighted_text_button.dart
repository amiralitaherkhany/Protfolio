import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/dark_colors.dart';
import 'package:my_portfolio/widgets/hover_detector.dart';

class LightedTextButton extends StatefulWidget {
  const LightedTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.hoverColor = DarkColors.headerTextColor,
    this.color = DarkColors.myGrey,
    this.fontSize = 20,
  });
  final double fontSize;
  final String text;
  final VoidCallback onPressed;
  final Color hoverColor;
  final Color color;

  @override
  State<LightedTextButton> createState() => _LightedTextButtonState();
}

class _LightedTextButtonState extends State<LightedTextButton> {
  ValueNotifier<bool> isHovered = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return HoverDetector(
      onHover: (value) => isHovered.value = value,
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          overlayColor: Colors.transparent,
        ),
        child: ListenableBuilder(
          listenable: isHovered,
          builder: (context, child) {
            return Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: isHovered.value ? widget.hoverColor : widget.color,
              ),
            );
          },
        ),
      ),
    );
  }
}
