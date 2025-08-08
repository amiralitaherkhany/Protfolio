import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/constants/link_constants.dart';
import 'package:my_portfolio/extensions/context_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: context.width * 6 / 100,
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
                right: context.width * 5 / 100,
                left: context.width * 5 / 100,
              ),
              sliver: MyInformation(),
            ),
            SliverList.builder(
              itemBuilder: (context, index) {
                return Text(
                  "1",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                );
              },
              itemCount: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class MyInformation extends StatelessWidget {
  const MyInformation({super.key});

  @override
  Widget build(BuildContext context) {
    switch (context.width) {
      case >= 1500:
        return SliverToBoxAdapter(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NameAndInfoSection(),
              SizedBox(
                width: context.width * 15 / 100,
              ),
              MyAvatar(),
            ],
          ),
        );
      default:
        return SliverList(
          delegate: SliverChildListDelegate(
            [
              MyAvatar(),
              SizedBox(
                height: 50,
              ),
              NameAndInfoSection(),
            ],
          ),
        );
    }
  }
}

class MyAvatar extends StatelessWidget {
  const MyAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(
            "assets/profile.png",
          ),
        ),
      ),
    );
  }
}

class NameAndInfoSection extends StatelessWidget {
  const NameAndInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 35 / 100,
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Text(
            "Amirali Taherkhany",
            style: TextStyle(
              fontSize: 60,
              color: Colors.white,
            ),
          ),
          Text(
            """Passionate and results-driven Android and Flutter Developer with a strong foundation in mobile application. Proficient in building high- performance, scalable applications using Kotlin for native Android (Jetpack Compose) and Flutter/Dart for cross-platform development.""",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 25,
            ),
          ),
        ],
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

class MainHeader extends StatelessWidget {
  const MainHeader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRSuperellipse(
      borderRadius: BorderRadiusGeometry.only(
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      ),
      child: Container(
        height: 70,
        decoration: ShapeDecoration(
          color: Color(0xFF1B1B1B),
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadiusGeometry.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 5 / 100,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  switch (context.width) {
                    case >= 1150:
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: context.width * 5 / 100,
                        children: [
                          for (var headerLink in HeaderLinks.values) ...{
                            Text(
                              headerLink.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF9C9C9C),
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
                            color: Color(0xFF1B1B1B),
                            icon: Icon(
                              FontAwesomeIcons.bars,
                              color: Color(0xFF9C9C9C),
                            ),
                            onSelected: (value) {
                              debugPrint(value.name);
                            },
                            itemBuilder: (context) => [
                              for (var headerLink in HeaderLinks.values) ...{
                                PopupMenuItem(
                                  value: headerLink,
                                  child: Text(
                                    headerLink.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF9C9C9C),
                                    ),
                                  ),
                                ),
                              },
                            ],
                          ),
                          if (context.width > 450) ...{
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
            begin: Colors.white,
            end: Color(0xFF9C9C9C),
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: ColorTween(
            begin: Color(0xFF9C9C9C),
            end: Colors.white,
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
      spacing: 25,
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
              color: ishovered.value ? Colors.white : Color(0xFF9C9C9C),
            ),
          ),
        ),
      ),
    );
  }
}
