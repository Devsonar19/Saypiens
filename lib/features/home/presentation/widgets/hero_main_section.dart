import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/app_color.dart';
import 'join_dialog.dart';
import '../../../../core/app_constants.dart';
import 'dart:ui';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _shimmerAnimation = Tween<double>(begin: 0.1, end: 0.4).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: GestureDetector(
              onTap: () => showDialog(context: context, builder: (_) => const JoinSaypienDialog()),
              child: AnimatedBuilder(
                animation: _shimmerAnimation,
                builder: (context, child) {
                  final double glow = isMobile ? _shimmerAnimation.value : (_isHovered ? 0.3 : 0.0);
                  final bool active = isMobile || _isHovered;

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 28),
                          decoration: BoxDecoration(
                            color: AppColors.platinum.withOpacity(0.02),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: active ? AppColors.golden : AppColors.platinum.withOpacity(0.15),
                              width: 1.5,
                            ),
                            boxShadow: active
                                ? [BoxShadow(color: AppColors.golden.withOpacity(glow), blurRadius: 40, spreadRadius: 5)]
                                : [],
                          ),
                          child: child,
                        ),
                      ),
                    ),
                  );
                },
                child: Text(
                  'BECOME A SAYPIEN',
                  style: GoogleFonts.lato(
                    color: AppColors.platinum,
                    fontSize: 24,
                    fontWeight: FontWeight.w300, // Minimalistic, thin weight
                    letterSpacing: 6,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          Text(
            AppConstants.heroSubtitle,
            style: GoogleFonts.playfairDisplay(
              color: AppColors.platinum.withOpacity(0.6),
              fontSize: 22,
              fontStyle: FontStyle.italic,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}