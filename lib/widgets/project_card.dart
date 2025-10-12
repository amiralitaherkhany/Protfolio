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
  final PageController _imageController = PageController(keepPage: true);

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
      decoration: BoxDecoration(
        color: DarkColors.onBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  AnimatedPageView(
                    imageController: _imageController,
                    images: widget.project.screenShots,
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
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                color: DarkColors.onBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      project.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      project.description,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    child: TextButton.icon(
                      onPressed: () {
                        launchUrl(Uri.parse(project.repo));
                      },
                      icon: const Icon(FontAwesomeIcons.github, size: 22),
                      label: const Text(
                        "View on GitHub",
                        style: TextStyle(fontSize: 17),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedPageView extends StatefulWidget {
  const AnimatedPageView({
    super.key,
    required this.imageController,
    required this.images,
  });
  final PageController imageController;
  final List<String> images;
  @override
  State<AnimatedPageView> createState() => _AnimatedPageViewState();
}

class _AnimatedPageViewState extends State<AnimatedPageView>
    with AutomaticKeepAliveClientMixin {
  Timer? _imageTimer;
  int _currentImage = 0;

  @override
  void initState() {
    super.initState();
    _startImageTimer();
  }

  @override
  void dispose() {
    _imageTimer?.cancel();
    super.dispose();
  }

  void _startImageTimer() {
    _imageTimer?.cancel();
    _imageTimer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (_currentImage < widget.images.length - 1) {
          _currentImage++;
        } else {
          _currentImage = 0;
        }
        if (mounted) {
          widget.imageController.animateToPage(
            _currentImage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView.builder(
      controller: widget.imageController,
      itemCount: widget.images.length,
      onPageChanged: (index) {
        setState(() {
          _currentImage = index;
          _startImageTimer();
        });
      },
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: widget.images[index],
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: DarkColors.headerTextColor,
            highlightColor: DarkColors.myGrey,
            child: Container(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
