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

// 1. Add SingleTickerProviderStateMixin to allow animations
class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  // 2. Declare animation variables
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();

    // 3. Initialize the controller to loop back and forth seamlessly
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust for faster/slower pulse
    )..repeat(reverse: true);

    // 4. Set the minimum and maximum opacity/spread for the glow
    _shimmerAnimation = Tween<double>(begin: 0.1, end: 0.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose(); // Always clean up controllers!
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
                // 5. Wrap the container in AnimatedBuilder to rebuild on animation ticks
                child: AnimatedBuilder(
                  animation: _shimmerAnimation,
                  builder: (context, child) {
                    // Calculate dynamic values based on screen size
                    final double currentGlowOpacity = isMobile ? _shimmerAnimation.value : (_isHovered ? 0.3 : 0.0);
                    final double currentBgOpacity = isMobile ? (_shimmerAnimation.value * 0.4) : (_isHovered ? 0.15 : 0.0);
                    final double currentBlur = isMobile ? 20 + (_shimmerAnimation.value * 20) : 30;
                    final double currentSpread = isMobile ? (_shimmerAnimation.value * 6) : 2;
                    final bool shouldShowEffects = isMobile || _isHovered;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                      decoration: BoxDecoration(
                        color: shouldShowEffects
                            ? AppColors.golden.withOpacity(currentBgOpacity)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: shouldShowEffects
                              ? AppColors.golden
                              : AppColors.golden.withOpacity(0.5),
                          width: 2,
                        ),
                        boxShadow: shouldShowEffects
                            ? [
                          BoxShadow(
                            color: AppColors.golden.withOpacity(currentGlowOpacity),
                            blurRadius: currentBlur,
                            spreadRadius: currentSpread,
                          )
                        ]
                            : [],
                      ),
                      child: child,
                    );
                  },
                  // Pass the text as a static child so Flutter doesn't rebuild it every frame
                  child: Text(
                    'BECOME A SAYPIEN',
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.textPrimary,
                      fontSize: 36,
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