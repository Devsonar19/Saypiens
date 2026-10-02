import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../theme/app_color.dart';


class SocialsSection extends StatelessWidget {
  const SocialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> socials = [
      {'name': 'WhatsApp', 'icon': FontAwesomeIcons.whatsapp, 'color': const Color(0xFF25D366), 'url': 'https://chat.whatsapp.com/ESg5RG2cQ6a4LYsnqwYcfq'},
      {'name': 'Substack', 'icon': (Color color) => Image.asset('assets/images/substack_logo.png', width: 28, height: 28, color: color), 'color': const Color(0xFFFF6719), 'url': 'https://substack.com/@saypiens'},
      {'name': 'Instagram', 'icon': FontAwesomeIcons.instagram, 'color': const Color(0xFFE1306C), 'url': 'https://www.instagram.com/saypienss/'},
      {'name': 'Reddit', 'icon': FontAwesomeIcons.redditAlien, 'color': const Color(0xFFFF4500), 'url': 'https://www.reddit.com/r/Saypiens/'},
      {'name': 'X', 'icon': FontAwesomeIcons.xTwitter, 'color': Colors.white, 'url': 'https://x.com/Saypiens_1'},
      {'name': 'Facebook', 'icon': FontAwesomeIcons.facebookF, 'color': const Color(0xFF1877F2), 'url': 'https://www.facebook.com/profile.php?id=61590641241593'},
      {'name': 'LinkedIn', 'icon': FontAwesomeIcons.linkedinIn, 'color': const Color(0xFF0A66C2), 'url': 'https://www.linkedin.com/in/saypiens-91b426412/'},
      {'name': 'YouTube', 'icon': FontAwesomeIcons.youtube, 'color': const Color(0xFFFF0000), 'url': 'https://youtube.com/@saypiens?si=roKO4EXFbd2iGVQZ'},
      {'name': 'Threads', 'icon': FontAwesomeIcons.threads, 'color': Colors.white, 'url': 'https://www.threads.com/@saypienss?xmt=AQG0Pio9ZLdFUe7lbgxZh_YRGHDxs5oNnOU6RmlJn5irDJREClwh35_W6tgwbhEwM17agzA'},
      {'name': 'Pinterest', 'icon': FontAwesomeIcons.pinterestP, 'color': const Color(0xFFE60023), 'url': 'https://in.pinterest.com/saypiens/'},
    ];

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Connect with Us:',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'follow to keep up',
                  style: GoogleFonts.syne(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 64),
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 5;
                    if (constraints.maxWidth < 600) {
                      crossAxisCount = 2;
                    } else if (constraints.maxWidth < 900) {
                      crossAxisCount = 3;
                    }
                    
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: 1.8, // Rectangular wide boxes
                      ),
                      itemCount: socials.length,
                      itemBuilder: (context, index) {
                        final social = socials[index];
                        return _HoverSocialBox(
                          name: social['name'],
                          icon: social['icon'],
                          color: social['color'],
                          url: social['url'],
                        );
                      },
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverSocialBox extends StatefulWidget {
  final String name;
  final dynamic icon;
  final Color color;
  final String url;

  const _HoverSocialBox({
    required this.name,
    required this.icon,
    required this.color,
    required this.url,
  });

  @override
  State<_HoverSocialBox> createState() => _HoverSocialBoxState();
}

class _HoverSocialBoxState extends State<_HoverSocialBox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final bool showActiveState = _isHovered || isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh, // Solid background, no transparency
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: showActiveState ? widget.color.withOpacity(0.5) : Colors.white.withOpacity(0.05),
              width: 1,
            ),
            boxShadow: showActiveState
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: _isHovered ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                child: widget.icon is Widget Function(Color)
                    ? (widget.icon as Widget Function(Color))(showActiveState ? widget.color : Colors.white.withOpacity(0.7))
                    : widget.icon is Widget
                        ? widget.icon
                        : FaIcon(
                            widget.icon,
                            color: showActiveState ? widget.color : Colors.white.withOpacity(0.7),
                            size: 28,
                          ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.name,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: showActiveState ? Colors.white : Colors.white.withOpacity(0.7),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}