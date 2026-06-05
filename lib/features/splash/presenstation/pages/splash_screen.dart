import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';
import '../../../../features/home/presentation/pages/home_page.dart';
import 'dart:ui';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isExpanding = false;
  bool _showSpinner = true;

  // ==========================================
  // YOUR TWEAKING CONTROLS
  // ==========================================
  // 1. How big should the full logo be on the phone? (360 is a good fit for mobile)
  final double imageSize = 360.0;

  // 2. How wide is the small 'Z' window? (Increase if the sides of Z are cut off)
  final double zWindowWidth = 83.0;

  // 3. Shift the image left to center the 'Z' in the window.
  // (Decrease to move right, increase to move left)
  final double zLeftOffset = -128.8;

  @override
  void initState() {
    super.initState();
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _showSpinner = false);
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) setState(() => _isExpanding = true);
    await Future.delayed(const Duration(milliseconds: 1200));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 1000),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // We make the window height smaller than the square image to crop out the empty top/bottom space
    const double windowHeight = 120.0;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. THE HORIZONTAL BURST REVEAL (Moved to the top so it renders underneath)
            Transform.translate(
              offset: const Offset(2, 6),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeInOutCubic,
                width: _isExpanding ? imageSize : zWindowWidth,
                height: windowHeight,
                child: ClipRect(
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.easeInOutCubic,
                        left: _isExpanding ? 0 : zLeftOffset,
                        top: (windowHeight - imageSize) / 2,
                        child: SizedBox(
                          width: imageSize,
                          height: imageSize,
                          child: Image.asset(
                            'assets/images/transparent_logo.png',
                            color: AppColors.golden,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. THE LOADING RING (Moved below so it renders safely on top of everything)
            // 2. THE GLOWING LOADING RING
            AnimatedOpacity(
              opacity: _showSpinner ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  fit: StackFit.expand, // Forces both spinners to perfectly fill the 120px box
                  children: [
                    // --- THE AURA (Outer Glow) ---
                    ImageFiltered(
                      // Increase sigmaX and sigmaY to make the glow spread further out
                      imageFilter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                      child: CircularProgressIndicator(
                        // Slightly thicker and highly opaque to cast a strong light
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.golden.withOpacity(0.8)),
                        strokeWidth: 4.0,
                      ),
                    ),

                    // --- THE CORE (Crisp Inner Line) ---
                    CircularProgressIndicator(
                      // Solid, bright color for the center of the "laser"
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.golden),
                      strokeWidth: 1.5, // Keeps that minimalist, sleek look
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
