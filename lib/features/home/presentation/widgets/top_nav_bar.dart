import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/responsive_layout.dart';
import 'join_dialog.dart';

class TopNavBar extends StatefulWidget {
  final VoidCallback onGatheringsTap;
  final VoidCallback onSocialsTap;
  final VoidCallback onAboutTap;
  final ScrollController scrollController;

  const TopNavBar({
    super.key,
    required this.onGatheringsTap,
    required this.onSocialsTap,
    required this.onAboutTap,
    required this.scrollController,
  });

  @override
  State<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    // Listen to scrolling to fade in the glassmorphism effect
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = widget.scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    // Calculate how intense the glass effect should be based on scroll position.
    final double glassIntensity = (_scrollOffset / 100).clamp(0.0, 1.0);

    return ClipRRect(
      child: BackdropFilter(
        // The blur dynamically increases as you scroll
        filter: ImageFilter.blur(sigmaX: 20.0 * glassIntensity, sigmaY: 20.0 * glassIntensity),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 40,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: AppColors.platinum.withOpacity(0.03 * glassIntensity),
            border: Border(
              bottom: BorderSide(
                  color: AppColors.platinum.withOpacity(0.08 * glassIntensity),
                  width: 1
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saypiens',
                style: GoogleFonts.playfairDisplay(
                  color: AppColors.golden,
                  fontSize: isMobile ? 28 : 34,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.5,
                ),
              ),

              if (!isMobile) ...[
                Row(
                  children: [
                    _AnimatedNavButton(title: 'Gatherings', onTap: widget.onGatheringsTap),
                    const SizedBox(width: 40),
                    _AnimatedNavButton(title: 'About Us', onTap: widget.onAboutTap),
                    const SizedBox(width: 40),
                    _AnimatedNavButton(title: 'Socials', onTap: widget.onSocialsTap),
                  ],
                ),
                _AnimatedCTA(
                  title: 'BECOME A SAYPIEN',
                  onTap: () => showDialog(context: context, builder: (_) => const JoinSaypienDialog()),
                ),
              ] else ...[
                IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.golden, size: 28),
                  onPressed: () => _showMobileMenu(context),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // --- MOBILE FULL-SCREEN MENU ---

  void _showMobileMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Mobile Menu',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              color: AppColors.black.withOpacity(0.6), // Dark ambient tint
              width: double.infinity,
              height: double.infinity,
              child: SafeArea(
                child: Column(
                  children: [
                    // Close Button
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: IconButton(
                          icon: const Icon(Icons.close, color: AppColors.golden, size: 36),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Menu Links
                    _mobileMenuLink(context, 'Gatherings', widget.onGatheringsTap),
                    const SizedBox(height: 40),
                    _mobileMenuLink(context, 'About Us', widget.onAboutTap),
                    const SizedBox(height: 40),
                    _mobileMenuLink(context, 'Socials', widget.onSocialsTap),
                    const SizedBox(height: 60),

                    // Mobile CTA Button
                    _mobileGlassCTA(context),

                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _mobileMenuLink(BuildContext context, String title, VoidCallback onTap) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context); // Close menu
        onTap(); // Execute scroll action
      },
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
      ),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.lato(
          color: AppColors.platinum.withOpacity(0.9),
          fontSize: 22,
          fontWeight: FontWeight.w300,
          letterSpacing: 4,
        ),
      ),
    );
  }

  Widget _mobileGlassCTA(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context); // Close the full-screen menu first
        showDialog(context: context, builder: (_) => const JoinSaypienDialog()); // Open the form
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
            color: AppColors.golden.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppColors.golden.withOpacity(0.6), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.golden.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ]
        ),
        child: Text(
          'BECOME A SAYPIEN',
          style: GoogleFonts.lato(
            color: AppColors.golden,
            fontWeight: FontWeight.w800,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

// --- NEW ANIMATED CUSTOM WIDGETS ---

/// An ultra-minimalist navigation button with a growing hover underline and click-scale.
class _AnimatedNavButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _AnimatedNavButton({required this.title, required this.onTap});

  @override
  State<_AnimatedNavButton> createState() => _AnimatedNavButtonState();
}

class _AnimatedNavButtonState extends State<_AnimatedNavButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : 1.0, // Scales down slightly when clicked
          duration: const Duration(milliseconds: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title.toUpperCase(),
                style: GoogleFonts.lato(
                  color: _isHovered ? AppColors.golden : AppColors.platinum.withOpacity(0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 6),
              // The animated hover underline
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutQuint,
                height: 1, // Razor thin
                width: _isHovered ? 30 : 0, // Grows from 0 to 30 pixels wide
                color: AppColors.golden,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A sleek, minimalist CTA button with a refined, subtle glow and tactile bounce.
class _AnimatedCTA extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _AnimatedCTA({required this.title, required this.onTap});

  @override
  State<_AnimatedCTA> createState() => _AnimatedCTAState();
}

class _AnimatedCTAState extends State<_AnimatedCTA> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : (_isHovered ? 1.02 : 1.0), // Milder bounce
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.golden.withOpacity(0.1)
                  : AppColors.golden.withOpacity(0.05),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: _isHovered ? AppColors.golden.withOpacity(0.8) : AppColors.golden.withOpacity(0.3),
                width: 1, // Thinner border for a cleaner look
              ),
              boxShadow: _isHovered
                  ? [
                // Subdued, elegant glow
                BoxShadow(
                  color: AppColors.golden.withOpacity(0.25), // Much lower opacity
                  blurRadius: 15, // Softer blur
                  spreadRadius: 1, // Barely pushes outside the button
                ),
              ]
                  : [], // No shadow when resting to keep the navbar ultra-clean
            ),
            child: Text(
              widget.title,
              style: GoogleFonts.lato(
                color: AppColors.golden,
                fontWeight: FontWeight.w700,
                fontSize: 13,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}