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
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
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
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _HoverSocialChip(icon: FontAwesomeIcons.instagram, label: 'Instagram', onTap: () => _launchSocial("https://www.instagram.com/saypienss/")),
                      _HoverSocialChip(icon: FontAwesomeIcons.xTwitter, label: 'X', onTap: () => _launchSocial("https://x.com/Saypiens_1")),
                      _HoverSocialChip(icon: FontAwesomeIcons.facebookF, label: 'Facebook', onTap: () => _launchSocial("https://www.facebook.com/profile.php?id=61590641241593")),
                      _HoverSocialChip(icon: FontAwesomeIcons.linkedinIn, label: 'LinkedIn', onTap: () => _launchSocial("https://www.linkedin.com/in/saypiens-91b426412/")),
                      _HoverSocialChip(icon: FontAwesomeIcons.reddit, label: 'Reddit', onTap: () => _launchSocial("https://www.reddit.com/r/Saypiens/")),
                      _HoverSocialChip(icon: FontAwesomeIcons.youtube, label: 'YouTube', onTap: () => _launchSocial("https://youtube.com/@saypiens?si=roKO4EXFbd2iGVQZ")),
                    ],
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

// Keep your existing _HoverSocialChip class here below...
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.golden.withOpacity(0.1) : Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? AppColors.golden.withOpacity(0.5) : AppColors.platinum.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(widget.icon, color: _isHovered ? AppColors.golden : AppColors.platinum.withOpacity(0.8), size: 20),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: GoogleFonts.lato(
                  color: _isHovered ? AppColors.golden : AppColors.platinum.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}