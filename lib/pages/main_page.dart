import 'package:flutter/material.dart';
import 'package:my_portfolio/extensions/context_extensions.dart';
import 'package:my_portfolio/theme/dark_colors.dart';
import 'package:my_portfolio/widgets/main_footer.dart';
import 'package:my_portfolio/widgets/main_header.dart';
import 'package:my_portfolio/widgets/my_information.dart';
import 'package:my_portfolio/widgets/my_skill_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          MainHeader(),
          SliverPadding(
            padding: EdgeInsetsGeometry.only(
              top: 60,
              right: context.percentageOfWidth(10),
              left: context.percentageOfWidth(10),
            ),
            sliver: MyInformation(),
          ),
          SliverDevider(
            key: HeaderLink.skills.key,
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
                    color: DarkColors.headerTextColor,
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
          SliverDevider(
            key: HeaderLink.projects.key,
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Projects",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 52,
                    color: DarkColors.headerTextColor,
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsetsGeometry.only(
              top: 50,
              bottom: 50,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Working on it...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: DarkColors.headerTextColor,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: MainFooter(),
          ),
        ],
      ),
    );
  }
}

class SliverDevider extends StatelessWidget {
  const SliverDevider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 75.0),
        child: Divider(
          color: Colors.grey,
          height: 2,
          endIndent: context.percentageOfWidth(25),
          indent: context.percentageOfWidth(25),
          radius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
