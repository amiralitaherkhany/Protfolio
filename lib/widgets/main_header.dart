import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/constants/link_constants.dart';
import 'package:my_portfolio/extensions/context_extensions.dart';
import 'package:my_portfolio/theme/dark_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: context.percentageOfWidth(6),
        ),
        child: ClipRSuperellipse(
          borderRadius: BorderRadiusGeometry.only(
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          child: Container(
            height: 70,
            decoration: ShapeDecoration(
              color: DarkColors.onBackgroundColor,
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadiusGeometry.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.percentageOfWidth(5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) {
                      switch (context.width) {
                        case >= 1200:
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: context.percentageOfWidth(5),
                            children: [
                              for (var headerLink in HeaderLinks.values) ...{
                                Text(
                                  headerLink.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: DarkColors.myGrey,
                                  ),
                                ),
                              },
                            ],
                          );
                        default:
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 15,
                            children: [
                              PopupMenuButton<HeaderLinks>(
                                color: DarkColors.onBackgroundColor,
                                icon: Icon(
                                  FontAwesomeIcons.bars,
                                  color: DarkColors.myGrey,
                                ),
                                onSelected: (value) {
                                  debugPrint(value.name);
                                },
                                itemBuilder: (context) => [
                                  for (var headerLink
                                      in HeaderLinks.values) ...{
                                    PopupMenuItem(
                                      value: headerLink,
                                      child: Text(
                                        headerLink.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: DarkColors.myGrey,
                                        ),
                                      ),
                                    ),
                                  },
                                ],
                              ),
                              if (context.width > 530) ...{
                                AnimatedMyName(),
                              },
                            ],
                          );
                      }
                    },
                  ),
                  Spacer(),
                  IconRow(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedMyName extends StatefulWidget {
  const AnimatedMyName({
    super.key,
  });

  @override
  State<AnimatedMyName> createState() => _AnimatedMyNameState();
}

class _AnimatedMyNameState extends State<AnimatedMyName>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controler;
  late final Animation _animation;

  @override
  void dispose() {
    _controler.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controler = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = TweenSequence(
      [
        TweenSequenceItem(
          tween: ColorTween(
            begin: DarkColors.myWhite,
            end: DarkColors.myGrey,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(
            begin: DarkColors.myGrey,
            end: DarkColors.myWhite,
          ),
          weight: 1,
        ),
      ],
    ).animate(_controler);
    _controler.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controler,
      builder: (context, child) {
        return Text(
          "Amirali Taherkhany",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: _animation.value,
          ),
        );
      },
    );
  }
}

class IconRow extends StatelessWidget {
  const IconRow({
    super.key,
  });
  void _launchURL(String url) {
    launchUrl(
      Uri.parse(url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        LightedIconButton(
          faIcon: FontAwesomeIcons.linkedinIn,
          onClick: () {
            _launchURL(
              LinkConstants.myLinkedIn,
            );
          },
        ),
        LightedIconButton(
          faIcon: FontAwesomeIcons.github,
          onClick: () {
            _launchURL(LinkConstants.myGithub);
          },
        ),
        LightedIconButton(
          faIcon: FontAwesomeIcons.telegram,
          onClick: () {
            _launchURL(LinkConstants.myTelegram);
          },
        ),
      ],
    );
  }
}

class LightedIconButton extends StatefulWidget {
  const LightedIconButton({
    super.key,
    required this.faIcon,
    required this.onClick,
  });
  final IconData faIcon;
  final VoidCallback onClick;
  @override
  State<LightedIconButton> createState() => _LightedIconButtonState();
}

class _LightedIconButtonState extends State<LightedIconButton> {
  ValueNotifier<bool> ishovered = ValueNotifier(false);
  void _setHovered(bool isHovered) {
    if (isHovered) {
      ishovered.value = true;
    } else {
      ishovered.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: GestureDetector(
        onTapDown: (_) => _setHovered(true),
        onTapUp: (_) => _setHovered(false),
        onTapCancel: () => _setHovered(false),
        child: ListenableBuilder(
          listenable: ishovered,
          builder: (context, child) => IconButton(
            onPressed: widget.onClick,
            icon: FaIcon(
              widget.faIcon,
              color: ishovered.value ? DarkColors.myWhite : DarkColors.myGrey,
            ),
          ),
        ),
      ),
    );
  }
}

enum HeaderLinks {
  home(name: 'Home', link: ""),
  caseStudies(name: 'Case Studies', link: ""),
  testimonials(name: 'Testimonials', link: ""),
  recentWork(name: 'Recent work', link: ""),
  getInTouch(name: 'Get In Touch', link: "");

  const HeaderLinks({required this.name, required this.link});
  final String name;
  final String link;
}
