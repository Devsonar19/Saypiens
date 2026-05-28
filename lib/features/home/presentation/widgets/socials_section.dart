import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../theme/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialsSection extends StatelessWidget {
  const SocialsSection({super.key});

  Future<void> _launchSocial(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      // Adding a slight opacity creates a subtle visual break from the Hero section
      color: Colors.black.withValues(alpha: 0.6),
      child: Column(
        children: [
          Text(
            'Socials',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
                color: AppColors.golden,
                fontSize: 36,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
            ),
          ),
          Text(
            'Follow to Keep up.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary.withValues(alpha: 0.7),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          // Wrap automatically handles wrapping to the next line on small screens (mobile)
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              _HoverSocialChip(
                  icon: FontAwesomeIcons.instagram, label: 'Instagram', 
                  onTap: () {
                _launchSocial("https://www.instagram.com/saypiens_1/");
              }),
              _HoverSocialChip(
                  icon: FontAwesomeIcons.xTwitter, label: 'X', 
                  onTap: () {
                    _launchSocial("https://x.com/Saypiens_1");
                  }),
              _HoverSocialChip(
                  icon: FontAwesomeIcons.facebookF, label: 'Facebook', 
                  onTap: () {
                    _launchSocial("https://www.facebook.com/profile.php?id=61590641241593");
                  }),
              _HoverSocialChip(
                  icon: FontAwesomeIcons.linkedinIn, label: 'LinkedIn', 
                  onTap: () {
                    _launchSocial("https://www.linkedin.com/in/saypiens-91b426412/");
                  }),
              _HoverSocialChip(
                  icon: FontAwesomeIcons.reddit, label: 'Reddit', 
                  onTap: () {
                    _launchSocial("https://www.reddit.com/r/Saypiens/");
                  }),
              _HoverSocialChip(
                  icon: FontAwesomeIcons.youtube, label: 'YouTube', 
                  onTap: () {
                    _launchSocial("https://youtube.com/@saypiens?si=roKO4EXFbd2iGVQZ");
                  }),
            ],
          ),
        ],
      ),
    );
  }
}

/// A private widget to handle the hover animations for individual social chips
class _HoverSocialChip extends StatefulWidget {
  final dynamic icon;
  final String label;
  final VoidCallback onTap;

  const _HoverSocialChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

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
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            // Slightly lighten the background on hover
            color: _isHovered
                ? AppColors.golden.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered ? AppColors.golden : AppColors.goldenDark.withValues(alpha: 0.3)
            ),
            // Add a subtle shadow on hover
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: AppColors.golden.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animate the icon scaling up slightly on hover
              AnimatedScale(
                scale: _isHovered ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: FaIcon(
                  widget.icon,
                  color: _isHovered ? AppColors.golden : AppColors.textPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered ? AppColors.golden : AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
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