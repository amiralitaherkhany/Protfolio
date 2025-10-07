import 'package:flutter/material.dart';
import 'package:my_portfolio/extensions/context_extensions.dart';
import 'package:my_portfolio/theme/dark_colors.dart';

class MySkillBar extends StatelessWidget {
  const MySkillBar({
    super.key,
    required this.skill,
  });

  final Skill skill;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: context.percentageOfWidth(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: ShapeDecoration(
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: DarkColors.myWhite,
            ),
            child: Image.asset(
              "assets/${skill.name}.png",
              width: 50,
              height: 50,
              filterQuality: FilterQuality.high,
            ),
          ),
          Expanded(
            child: LinearProgressIndicator(
              color: Colors.indigoAccent,
              backgroundColor: DarkColors.myWhite,
              value: skill.percentage,
              minHeight: 9,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}

enum Skill {
  dart(percentage: 0.8),
  flutter(percentage: 0.8),
  kotlin(percentage: 0.6),
  go(percentage: 0.4),
  git(percentage: 0.4),
  github(percentage: 0.6),
  githubactions(percentage: 0.5);

  const Skill({required this.percentage});

  final double percentage;
}
