import 'package:flutter/material.dart';
import 'package:my_portfolio/extensions/context_extensions.dart';
import 'package:my_portfolio/theme/dark_colors.dart';
import 'package:vector_graphics/vector_graphics.dart';

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
            child: VectorGraphic(
              loader: AssetBytesLoader('assets/svg/${skill.name}.svg'),
              width: 40,
              height: 40,
            ),
          ),
          Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0,
                end: skill.percentage,
              ),
              curve: Curves.bounceInOut,
              duration: Duration(seconds: 2),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  color: Colors.indigoAccent,
                  backgroundColor: DarkColors.myWhite,
                  value: value,
                  minHeight: 9,
                  borderRadius: BorderRadius.circular(20),
                );
              },
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
