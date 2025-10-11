import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/link_constants.dart';
import 'package:my_portfolio/constants/project_constants.dart';
import 'package:my_portfolio/widgets/lighted_icon_button.dart';
import 'package:my_portfolio/widgets/lighted_text_button.dart';
import 'package:url_launcher/url_launcher.dart';

const double desktopBreakpoint = 800;

const Color footerBackgroundColor = Color(0xFF0F172A);
const Color footerTextColor = Color(0xFFCBD5E1);
const Color accentColor = Color(0xFF38BDF8);

class MainFooter extends StatelessWidget {
  const MainFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth > desktopBreakpoint
                ? const _DesktopFooter()
                : const _MobileFooter();
          },
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CopyRight(),
          ),
        ),
      ],
    );
  }
}

class CopyRight extends StatelessWidget {
  const CopyRight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '© ${DateTime.now().year} Amirali | Built with Flutter ❤️',
      style: TextStyle(
        color: footerTextColor.withAlpha(180),
        fontSize: 12,
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: const Text(
            'Amirali Taherkhany',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            width: 260,
            child: Text(
              'Transforming ideas into elegant code and purposeful innovation.',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: footerTextColor,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LinkSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _LinkSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }
}

class _SocialSection extends StatelessWidget {
  const _SocialSection();
  void _launchURL(String url) {
    launchUrl(
      Uri.parse(url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: LinkConstants.values.map<Widget>(
        (e) {
          return LightedIconButton(
            faIcon: e.icon,
            onClick: () {
              _launchURL(e.url);
            },
            color: Colors.grey,
            hoverColor: Colors.white,
            toolTip: e.name,
          );
        },
      ).toList(),
    );
  }
}

class _DesktopFooter extends StatelessWidget {
  const _DesktopFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: footerBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _InfoSection(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Center(child: _ProjectsSection())),

                        Expanded(child: Center(child: _ConnectSection())),
                      ],
                    ),
                  ),
                  const _SocialSection(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConnectSection extends StatelessWidget {
  void _launchURL(String url) {
    launchUrl(
      Uri.parse(url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _LinkSection(
      title: 'Connect',
      children: LinkConstants.values.map<Widget>(
        (e) {
          return LightedTextButton(
            text: e.name,
            color: footerTextColor,
            fontSize: 15,
            onPressed: () {
              _launchURL(e.url);
            },
          );
        },
      ).toList(),
    );
  }
}

// --- Mobile Layout ---
class _MobileFooter extends StatelessWidget {
  const _MobileFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: footerBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _InfoSection(),
          const Divider(color: footerTextColor, height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _ProjectsSection()),
              Expanded(child: _ConnectSection()),
            ],
          ),
          const Divider(color: footerTextColor, height: 40),
          const _SocialSection(),
        ],
      ),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  void _launchURL(String url) {
    launchUrl(
      Uri.parse(url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _LinkSection(
      title: 'Projects',
      children: ProjectConstants.values.map<LightedTextButton>(
        (e) {
          return LightedTextButton(
            text: e.name,
            fontSize: 15,
            color: footerTextColor,
            onPressed: () {
              _launchURL(e.repo);
            },
          );
        },
      ).toList(),
    );
  }
}
