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
  double _lastViewportFraction = 0.9;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: _lastViewportFraction,
      keepPage: true,
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void _updatePageController(double screenWidth) {
    final newFraction = _getAdaptiveViewportFraction(screenWidth);
    if (newFraction != _lastViewportFraction) {
      final oldController = _pageController;
      _pageController = PageController(
        viewportFraction: newFraction,
        initialPage: oldController?.initialPage ?? 0,
        keepPage: true,
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
          child: AnimatedPageView(
            pageController: _pageController!,
            projects: projects,
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

  double _getAdaptiveViewportFraction(double screenWidth) {
    switch (screenWidth) {
      case < 480:
        return 1;
      case < 565:
        return 0.75;

      case < 679:
        return 0.80;

      case < 700:
        return 0.80;

      case < 800:
        return 0.65;

      case < 900:
        return 0.55;

      case < 1000:
        return 0.45;

      case < 1100:
        return 0.40;

      case < 1200:
        return 0.38;

      case < 1300:
        return 0.35;

      case < 1400:
        return 0.36;

      case < 1600:
        return 0.37;

      default:
        return 0.3;
    }
  }

  double _getPageViewHeight(double screenWidth) {
    switch (screenWidth) {
      case < 300:
        return 660;
      case < 400:
        return 690;
      case < 480:
        return 730;
      case < 565:
        return 690;
      case < 632:
        return 760;

      case < 679:
        return 780;

      case < 700:
        return 820;

      case < 800:
        return 770;

      case < 900:
        return 740;

      case < 1000:
        return 720;

      case < 1100:
        return 700;

      case < 1200:
        return 720;

      case < 1300:
        return 740;

      case < 1400:
        return 740;

      case < 1500:
        return 790;

      case < 1600:
        return 840;
      case < 1700:
        return 790;
      case < 1800:
        return 810;
      default:
        return context.percentageOfWidth(30) * 1.45;
    }
  }
}

class AnimatedPageView extends StatefulWidget {
  const AnimatedPageView({
    super.key,
    required this.pageController,
    required this.projects,
  });
  final PageController pageController;
  final List<ProjectConstants> projects;
  @override
  State<AnimatedPageView> createState() => _AnimatedPageViewState();
}

class _AnimatedPageViewState extends State<AnimatedPageView>
    with AutomaticKeepAliveClientMixin {
  Timer? _timer;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_currentPage < ProjectConstants.values.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (mounted) {
        widget.pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView.builder(
      controller: widget.pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
          _startTimer();
        });
      },
      itemCount: widget.projects.length,
      itemBuilder: (context, index) {
        return ProjectCard(project: widget.projects[index]);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
