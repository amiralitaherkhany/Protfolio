import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/project_constants.dart';
import 'package:my_portfolio/extensions/context_extensions.dart';
import 'package:my_portfolio/theme/dark_colors.dart';
import 'package:my_portfolio/widgets/project_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProjectViewer extends StatefulWidget {
  const ProjectViewer({super.key});

  @override
  State<ProjectViewer> createState() => _ProjectViewerState();
}

class _ProjectViewerState extends State<ProjectViewer> {
  PageController? _pageController;
  late Timer _timer;
  int _currentPage = 0;
  double _lastViewportFraction = 0.9;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: _lastViewportFraction);

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_currentPage < ProjectConstants.values.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (mounted) {
        _pageController?.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  double _getViewportFraction(double width) {
    if (width < 600) return 1;
    if (width < 1100) return 0.75;
    return 0.4;
  }

  void _updatePageController(double screenWidth) {
    final newFraction = _getViewportFraction(screenWidth);
    if (newFraction != _lastViewportFraction) {
      final oldController = _pageController;
      _pageController = PageController(
        viewportFraction: newFraction,
        initialPage: oldController?.initialPage ?? 0,
      );
      _lastViewportFraction = newFraction;
      oldController?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final projects = ProjectConstants.values;
    final screenWidth = context.width;

    _updatePageController(screenWidth);

    return Column(
      children: [
        SizedBox(
          height: _getPageViewHeight(screenWidth),
          child: PageView.builder(
            controller: _pageController,
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(project: projects[index]);
            },
          ),
        ),
        const SizedBox(height: 25),
        SmoothPageIndicator(
          controller: _pageController!,
          count: projects.length,
          effect: ExpandingDotsEffect(
            expansionFactor: 4,
            spacing: 10,
            radius: 12,
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: const Color.fromARGB(255, 1, 104, 183),
            dotColor: DarkColors.myWhite,
          ),
          onDotClicked: (index) {
            _pageController?.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }

  double _getPageViewHeight(double width) {
    if (width < 600) return 600;
    if (width < 1100) return 700;
    return 700;
  }
}
