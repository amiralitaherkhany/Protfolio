import 'package:flutter/material.dart';
import 'package:my_portfolio/extensions/context_extensions.dart';
import 'package:my_portfolio/widgets/main_header.dart';
import 'package:my_portfolio/widgets/my_information.dart';
import 'package:my_portfolio/widgets/my_skill_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: context.percentageOfWidth(6),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: MainHeader(),
            ),
            SliverPadding(
              padding: EdgeInsetsGeometry.only(
                top: 60,
                bottom: 60,
                right: context.percentageOfWidth(5),
                left: context.percentageOfWidth(5),
              ),
              sliver: MyInformation(),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Skills",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 52,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return MySkillBar(
                    skill: Skill.values[index],
                  );
                },
                childCount: Skill.values.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
