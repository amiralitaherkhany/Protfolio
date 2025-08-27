import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/constants/link_constants.dart';
import 'package:my_portfolio/extensions/context_extensions.dart';
import 'package:my_portfolio/theme/dark_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    required this.scrollKeys,
    super.key,
  });
  final Map<HeaderLink, GlobalKey> scrollKeys;
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
                          return DesktopView(
                            scrollKeys: scrollKeys,
                          );
                        default:
                          return MobileView(
                            keys: scrollKeys,
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

class DesktopView extends StatelessWidget {
  const DesktopView({
    super.key,
    required this.scrollKeys,
  });
  final Map<HeaderLink, GlobalKey> scrollKeys;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: context.percentageOfWidth(5),
      children: [
        for (var headerLink in HeaderLink.values) ...{
          LightedTextButton(
            headerLinkName: headerLink,
            onPressed: () => scrollToSection(headerLink, scrollKeys),
          ),
        },
      ],
    );
  }
}

class LightedTextButton extends StatefulWidget {
  const LightedTextButton({
    super.key,
    required this.headerLinkName,
    required this.onPressed,
  });

  final HeaderLink headerLinkName;
  final VoidCallback onPressed;

  @override
  State<LightedTextButton> createState() => _LightedTextButtonState();
}

class _LightedTextButtonState extends State<LightedTextButton> {
  ValueNotifier<bool> isHovered = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return HoverDetector(
      onHover: (value) => isHovered.value = value,
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          overlayColor: Colors.transparent,
        ),
        child: ListenableBuilder(
          listenable: isHovered,
          builder: (context, child) {
            return Text(
              widget.headerLinkName.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: isHovered.value
                    ? DarkColors.headerTextColor
                    : DarkColors.myGrey,
              ),
            );
          },
        ),
      ),
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({
    super.key,
    required this.keys,
  });
  final Map<HeaderLink, GlobalKey> keys;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 15,
      children: [
        PopupMenuButton<HeaderLink>(
          color: DarkColors.onBackgroundColor,
          icon: Icon(
            FontAwesomeIcons.bars,
            color: DarkColors.myGrey,
          ),
          onSelected: (value) => scrollToSection(value, keys),
          itemBuilder: (context) => [
            for (var headerLink in HeaderLink.values) ...{
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
}

void scrollToSection(HeaderLink value, Map<HeaderLink, GlobalKey> keys) {
  switch (value) {
    case HeaderLink.skills:
      Scrollable.ensureVisible(
        keys[value]!.currentContext!,
        duration: const Duration(
          milliseconds: 1000,
        ),
        curve: Curves.easeInOut,
      );
      break;
    case HeaderLink.projects:
      Scrollable.ensureVisible(
        keys[value]!.currentContext!,
        duration: const Duration(
          milliseconds: 1000,
        ),
        curve: Curves.easeInOut,
      );
      break;
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

  @override
  Widget build(BuildContext context) {
    return HoverDetector(
      onHover: (value) => ishovered.value = value,
      child: IconButton(
        onPressed: widget.onClick,
        icon: ListenableBuilder(
          listenable: ishovered,
          builder: (context, child) => FaIcon(
            widget.faIcon,
            color: ishovered.value ? DarkColors.myWhite : DarkColors.myGrey,
          ),
        ),
      ),
    );
  }
}

class HoverDetector extends StatelessWidget {
  const HoverDetector({super.key, required this.onHover, required this.child});
  final void Function(bool isHovered) onHover;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTapDown: (_) => onHover(true),
        onTapUp: (_) => onHover(false),
        onTapCancel: () => onHover(false),
        child: child,
      ),
    );
  }
}

enum HeaderLink {
  skills(name: 'Skills'),
  projects(name: 'Projects');

  const HeaderLink({required this.name});

  final String name;
}
