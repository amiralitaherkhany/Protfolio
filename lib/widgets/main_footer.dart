import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/dark_colors.dart';

class MainFooter extends StatelessWidget {
  const MainFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: DarkColors.onBackgroundColor,
        shape: RoundedSuperellipseBorder(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
      ),
      height: 200,
      width: double.infinity,
      child: Center(
        child: Text("Footer"),
      ),
    );
  }
}
