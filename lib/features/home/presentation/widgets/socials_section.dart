import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../theme/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialsSection extends StatelessWidget {
  const SocialsSection({super.key});

  Future<void> _launchSocial(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) debugPrint('Could not launch $url');
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> socials = [
      {'icon': FontAwesomeIcons.instagram, 'label': 'Instagram', 'url': 'https://www.instagram.com/saypienss/'},
      {'icon': FontAwesomeIcons.xTwitter, 'label': 'X', 'url': 'https://x.com/Saypiens_1'},
      {'icon': FontAwesomeIcons.facebookF, 'label': 'Facebook', 'url': 'https://www.facebook.com/profile.php?id=61590641241593'},
      {'icon': FontAwesomeIcons.linkedinIn, 'label': 'LinkedIn', 'url': 'https://www.linkedin.com/in/saypiens-91b426412/'},
      {'icon': FontAwesomeIcons.reddit, 'label': 'Reddit', 'url': 'https://www.reddit.com/r/Saypiens/'},
      {'icon': FontAwesomeIcons.layerGroup, 'label': 'Substack', 'url': 'https://substack.com/@saypiens'},
      {'icon': FontAwesomeIcons.youtube, 'label': 'YouTube', 'url': 'https://youtube.com/@saypiens?si=roKO4EXFbd2iGVQZ'},
      {'icon': FontAwesomeIcons.threads, 'label': 'Threads', 'url': 'https://www.threads.com/@saypienss?xmt=AQG0Pio9ZLdFUe7lbgxZh_YRGHDxs5oNnOU6RmlJn5irDJREClwh35_W6tgwbhEwM17agzA'},
      {'icon': FontAwesomeIcons.squareWhatsapp, 'label': 'WhatsApp Community', 'url': 'https://chat.whatsapp.com/ESg5RG2cQ6a4LYsnqwYcfq'},
      {'icon': FontAwesomeIcons.pinterest, 'label': 'Pinterest', 'url': 'https://in.pinterest.com/saypiens/'}
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.platinum.withOpacity(0.02),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColors.platinum.withOpacity(0.1), width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    'Socials',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.golden,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Follow to keep up.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: AppColors.platinum.withOpacity(0.6),
                      fontSize: 16,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // --- RESPONSIVE GRID MAGIC ---
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const double spacing = 16.0;

                      // Dynamically calculate columns based on screen width
                      int columns = 2; // Default for mobile
                      if (constraints.maxWidth >= 800) {
                        columns = 4; // Desktop
                      } else if (constraints.maxWidth >= 600) {
                        columns = 3; // Tablet
                      }

                      // Mathematically calculate the exact width for each chip
                      // We use .floorToDouble() to prevent sub-pixel rounding errors that break Wrap
                      final double itemWidth = ((constraints.maxWidth - (spacing * (columns - 1))) / columns).floorToDouble();

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: socials.map((social) {
                          return SizedBox(
                            width: itemWidth,
                            child: _HoverSocialChip(
                              icon: social['icon'],
                              label: social['label'],
                              onTap: () => _launchSocial(social['url']),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverSocialChip extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;

  const _HoverSocialChip({required this.icon, required this.label, required this.onTap});

  @override
  State<_HoverSocialChip> createState() => _HoverSocialChipState();
}

class _HoverSocialChipState extends State<_HoverSocialChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.golden.withOpacity(0.1) : Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? AppColors.golden.withOpacity(0.5) : AppColors.platinum.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centers the content!
            children: [
              FaIcon(widget.icon, color: _isHovered ? AppColors.golden : AppColors.platinum.withOpacity(0.8), size: 18),
              const SizedBox(width: 12),
              Flexible( // Swapped Expanded for Flexible
                child: Text(
                  widget.label,
                  style: GoogleFonts.lato(
                    color: _isHovered ? AppColors.golden : AppColors.platinum.withOpacity(0.9),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}