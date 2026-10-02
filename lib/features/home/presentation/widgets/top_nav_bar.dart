import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';
import 'glowing_border_button.dart';

import 'package:google_fonts/google_fonts.dart';

class HoverNavLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const HoverNavLink({super.key, required this.text, required this.onTap});

  @override
  State<HoverNavLink> createState() => _HoverNavLinkState();
}

class _HoverNavLinkState extends State<HoverNavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isHovered ? const Color(0xFFB8860B) : Colors.transparent,
                width: 2.0,
              ),
            ),
          ),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 250),
            scale: _isHovered ? 1.05 : 1.0,
            curve: Curves.easeOut,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              style: GoogleFonts.syne(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _isHovered ? const Color(0xFFB8860B) : AppColors.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
              child: Text(widget.text),
            ),
          ),
        ),
      ),
    );
  }
}

class TopNavBar extends StatelessWidget {
  final VoidCallback onAboutTap;
  final VoidCallback onMeetupsTap;
  final VoidCallback onSocialsTap;
  final bool showBecomeSaypien;
  final VoidCallback? onBecomeSaypienTap;

  const TopNavBar({
    super.key,
    required this.onAboutTap,
    required this.onMeetupsTap,
    required this.onSocialsTap,
    this.showBecomeSaypien = false,
    this.onBecomeSaypienTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.08),
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HoverNavLink(text: 'About Us', onTap: onAboutTap),
                  const SizedBox(width: 24),
                  HoverNavLink(text: 'Meetups', onTap: onMeetupsTap),
                  const SizedBox(width: 24),
                  HoverNavLink(text: 'Socials', onTap: onSocialsTap),
                ],
              ),
              if (showBecomeSaypien)
                GlowingBorderButton(
                  text: 'Become a Saypien',
                  onTap: onBecomeSaypienTap ?? () {},
                ),
            ],
          ),
        ),
      ),
    );
  }
}