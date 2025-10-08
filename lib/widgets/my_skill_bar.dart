import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/dark_colors.dart';
import 'package:my_portfolio/widgets/gradiant_text.dart';

class MySkillBar extends StatelessWidget {
  const MySkillBar({
    super.key,
    required this.skill,
  });

  final Skill skill;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(
                height: 15,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: GradiantText(
                  skill.displayName,
                  colors: [
                    Color(0xFF7F7FD5),
                    Color(0xFF86A8E7),
                  ],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LinearProgressIndicator(
            color: Color.fromARGB(255, 1, 104, 183),
            backgroundColor: DarkColors.myWhite,
            value: skill.percentage,
            minHeight: 9,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }
}

enum Skill {
  dart(percentage: 0.8, displayName: "Dart"),
  flutter(percentage: 0.8, displayName: "Flutter"),
  kotlin(percentage: 0.6, displayName: "Kotlin"),
  go(percentage: 0.4, displayName: "Go"),
  postgresql(percentage: 0.2, displayName: "PostgreSQL"),
  mysql(percentage: 0.2, displayName: "MySQL"),
  redis(percentage: 0.2, displayName: "Redis"),
  linux(percentage: 0.3, displayName: "Linux"),
  git(percentage: 0.4, displayName: "Git"),
  github(percentage: 0.6, displayName: "Github"),
  githubactions(percentage: 0.5, displayName: "GH Actions");

  const Skill({required this.percentage, required this.displayName});

  final double percentage;
  final String displayName;
}
