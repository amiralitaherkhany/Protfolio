import 'package:flutter/material.dart';

class GradiantText extends StatelessWidget {
  const GradiantText(this.text, {required this.colors, this.style, super.key});
  final String text;
  final TextStyle? style;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
      ).createShader(bounds),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
