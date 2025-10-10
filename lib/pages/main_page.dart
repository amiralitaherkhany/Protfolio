import 'package:flutter/material.dart';
import 'package:my_portfolio/extensions/context_extensions.dart';
import 'package:my_portfolio/theme/dark_colors.dart';
import 'package:my_portfolio/widgets/main_footer.dart';
import 'package:my_portfolio/widgets/main_header.dart';
import 'package:my_portfolio/widgets/my_information.dart';
import 'package:my_portfolio/widgets/my_skill_bar.dart';
import 'package:my_portfolio/widgets/project_viewer.dart';

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
          SliverPadding(
            padding: EdgeInsets.symmetric(
              vertical: 40.0,
              horizontal: _getSkillsPadding(context),
            ),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                addRepaintBoundaries: true,
                childCount: Skill.values.length,
                (context, index) {
                  return SizedBox(
                    width: 500,
                    child: MySkillBar(
                      skill: Skill.values[index],
                    ),
                  );
                },
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getSkillsGridColumnCount(context),
                mainAxisExtent: 75,
                crossAxisSpacing: 30,
                mainAxisSpacing: 25,
              ),
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
              child: ProjectViewer(),
            ),
          ),
          SliverToBoxAdapter(
            child: MainFooter(),
          ),
        ],
      ),
    );
  }

  int _getSkillsGridColumnCount(BuildContext context) {
    return (context.width - (2 * _getSkillsPadding(context))) ~/ 500 <= 0
        ? 1
        : (context.width - (2 * _getSkillsPadding(context))) ~/ 500;
  }

  double _getSkillsPadding(BuildContext context) {
    return context.width > 1000
        ? context.percentageOfWidth(10)
        : context.percentageOfWidth(5);
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
