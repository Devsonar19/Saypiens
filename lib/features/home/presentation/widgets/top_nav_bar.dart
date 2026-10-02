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
    final isMobile = MediaQuery.of(context).size.width < 800;

    // The Logo
    Widget logo = Image.asset(
      'assets/images/transparent_logo.png',
      height: 40,
      errorBuilder: (context, error, stackTrace) => Text(
        'Saypiens',
        style: GoogleFonts.cormorantGaramond(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );

    // Desktop Navigation Links
    Widget navLinks = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        HoverNavLink(text: 'About Us', onTap: onAboutTap),
        const SizedBox(width: 24),
        HoverNavLink(text: 'Meetups', onTap: onMeetupsTap),
        const SizedBox(width: 24),
        HoverNavLink(text: 'Socials', onTap: onSocialsTap),
      ],
    );

    // Join Button
    Widget actionButton = GlowingBorderButton(
      text: 'Become a Saypien',
      onTap: onBecomeSaypienTap ?? () {},
    );

    // Mobile Hamburger Menu
    Widget hamburger = Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: AppColors.surfaceContainerLowest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: AppColors.outlineVariant.withOpacity(0.3), width: 1),
          ),
          elevation: 12,
        ),
      ),
      child: PopupMenuButton<int>(
        icon: const Icon(Icons.menu, color: Colors.white, size: 28),
        offset: const Offset(0, 56),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1, 
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text('About Us', style: GoogleFonts.syne(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          PopupMenuItem(
            value: 2, 
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text('Meetups', style: GoogleFonts.syne(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          PopupMenuItem(
            value: 3, 
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text('Socials', style: GoogleFonts.syne(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
        onSelected: (value) {
          if (value == 1) onAboutTap();
          if (value == 2) onMeetupsTap();
          if (value == 3) onSocialsTap();
        },
      ),
    );

    Widget content;
    if (isMobile) {
      content = Stack(
        children: [
          // Logo slides left when button appears
          AnimatedAlign(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
            alignment: showBecomeSaypien ? Alignment.centerLeft : Alignment.center,
            child: logo,
          ),
          // Button and Hamburger on the right
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutBack,
                  scale: showBecomeSaypien ? 1.0 : 0.0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: showBecomeSaypien ? 1.0 : 0.0,
                    child: IgnorePointer(
                      ignoring: !showBecomeSaypien,
                      child: actionButton,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                hamburger,
              ],
            ),
          ),
        ],
      );
    } else {
      content = Stack(
        children: [
          Align(alignment: Alignment.centerLeft, child: navLinks),
          Align(alignment: Alignment.center, child: logo),
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: showBecomeSaypien ? 1.0 : 0.0,
              child: IgnorePointer(
                ignoring: !showBecomeSaypien,
                child: actionButton,
              ),
            ),
          ),
        ],
      );
    }

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
          child: content,
        ),
      ),
    );
  }
}