import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/constants/project_constants.dart';
import 'package:my_portfolio/theme/dark_colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project});
  final ProjectConstants project;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  final PageController _imageController = PageController();
  Timer? _imageTimer;
  int _currentImage = 0;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _startImageTimer();
  }

  void _startImageTimer() {
    _imageTimer?.cancel();
    _imageTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_isHovered) {
        if (_currentImage < widget.project.screenShots.length - 1) {
          _currentImage++;
        } else {
          _currentImage = 0;
        }
        if (mounted) {
          _imageController.animateToPage(
            _currentImage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _pauseImageTimer() => _isHovered = true;
  void _resumeImageTimer() => _isHovered = false;

  @override
  void dispose() {
    _imageTimer?.cancel();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => _pauseImageTimer(),
      onExit: (_) => _resumeImageTimer(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
        decoration: BoxDecoration(
          color: DarkColors.onBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 70,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _imageController,
                      itemCount: project.screenShots.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: project.screenShots[index],
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) {
                            return Shimmer.fromColors(
                              baseColor: DarkColors.headerTextColor,
                              highlightColor: DarkColors.myGrey,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.white,
                                child: SizedBox(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Positioned(
                      bottom: 8,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: _imageController,
                          count: project.screenShots.length,
                          effect: WormEffect(
                            dotHeight: 6,
                            dotWidth: 6,
                            spacing: 6,
                            activeDotColor: Colors.blueAccent,
                            dotColor: DarkColors.onBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 30,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: DarkColors.onBackgroundColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      project.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: () {
                        launchUrl(Uri.parse(project.repo));
                      },
                      icon: const Icon(FontAwesomeIcons.github, size: 25),
                      label: const Text("View on GitHub"),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
