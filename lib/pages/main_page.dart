import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/extensions/context_extensions.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    const texts = <String>[
      'Home',
      'Case Studies',
      'Testimonials',
      'Recent work',
      'Get In Touch',
    ];
    const icons = [
      FontAwesomeIcons.linkedinIn,
      FontAwesomeIcons.github,
      FontAwesomeIcons.telegram,
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ClipRSuperellipse(
              borderRadius: BorderRadiusGeometry.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Container(
                height: 70,
                margin: EdgeInsetsGeometry.symmetric(
                  horizontal: context.width * 6 / 100,
                ),
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
                                  for (var text in texts) ...{
                                    Text(
                                      text,
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
                                  LightedIcon(faIcon: FontAwesomeIcons.bars),
                                  if (context.width > 450) ...{
                                    AnimatedMyName(),
                                  },
                                ],
                              );
                          }
                        },
                      ),
                      Spacer(),
                      IconRow(icons: icons),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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
  }

  @override
  Widget build(BuildContext context) {
    _controler.repeat();
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
    required this.icons,
  });

  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 25,
      children: [
        for (var icon in icons) ...{
          LightedIcon(
            faIcon: icon,
          ),
        },
      ],
    );
  }
}

class LightedIcon extends StatefulWidget {
  const LightedIcon({super.key, required this.faIcon});
  final IconData faIcon;
  @override
  State<LightedIcon> createState() => _LightedIconState();
}

class _LightedIconState extends State<LightedIcon> {
  ValueNotifier<bool> ishovered = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        ishovered.value = true;
      },
      onExit: (event) {
        ishovered.value = false;
      },
      child: ListenableBuilder(
        listenable: ishovered,
        builder: (context, child) => FaIcon(
          widget.faIcon,
          color: ishovered.value ? Colors.white : Color(0xFF9C9C9C),
        ),
      ),
    );
  }
}
