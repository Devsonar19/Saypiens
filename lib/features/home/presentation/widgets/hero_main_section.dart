import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/responsive_layout.dart';
import 'join_dialog.dart';
import '../../../../core/app_constants.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool _isHovered = false;


  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final shouldGlow = _isHovered || isMobile;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Glowing Button
          MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const JoinSaypienDialog(),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                  decoration: BoxDecoration(
                    color: shouldGlow
                        ? AppColors.golden.withOpacity(0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: shouldGlow
                          ? AppColors.golden
                          : AppColors.golden.withOpacity(0.5),
                      width: 2,
                    ),
                    boxShadow: shouldGlow
                        ? [
                      BoxShadow(
                        color: AppColors.golden.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 2,
                      )
                    ]
                        : [],
                  ),
                  child: Text(
                    'BECOME A SAYPIEN',
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.textPrimary,
                      fontSize: 36, // Slightly larger to match the theme
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Subtitle
          const Text(
            AppConstants.heroSubtitle,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 24,
              fontStyle: FontStyle.italic,
              letterSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }
}