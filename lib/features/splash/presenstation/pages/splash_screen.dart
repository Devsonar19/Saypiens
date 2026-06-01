import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';
import '../../../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _introController;
  late AnimationController _breatheController;
  late AnimationController _expandController;

  late Animation<double> _introOpacity;
  late Animation<double> _breatheAnimation;
  late Animation<double> _expandScaleAnimation;
  late Animation<double> _expandOpacityAnimation;
  late Animation<double> _flashAnimation;

  @override
  void initState() {
    super.initState();

    // Fade in
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _introOpacity = CurvedAnimation(
      parent: _introController,
      curve: Curves.easeOut,
    );

    // Breathing
    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _breatheAnimation = Tween<double>(
      begin: 0.96,
      end: 1.06,
    ).animate(
      CurvedAnimation(
        parent: _breatheController,
        curve: Curves.easeInOut,
      ),
    );

    // Expansion
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _expandScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.12,
        ).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.12,
          end: 80.0,
        ).chain(
          CurveTween(curve: Curves.easeInExpo),
        ),
        weight: 85,
      ),
    ]).animate(_expandController);

    _expandOpacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _expandController,
        curve: const Interval(
          0.45,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    _flashAnimation = Tween<double>(
      begin: 0.0,
      end: 0.15,
    ).animate(
      CurvedAnimation(
        parent: _expandController,
        curve: const Interval(
          0.0,
          0.25,
          curve: Curves.easeOut,
        ),
      ),
    );

    _introController.forward();

    _expandController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: Duration.zero,
            pageBuilder: (_, __, ___) => HomePage(),
          ),
        );
      }
    });

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (!mounted) return;

      _breatheController.stop();
      _expandController.forward();
    });
  }

  @override
  void dispose() {
    _introController.dispose();
    _breatheController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _introController,
          _breatheController,
          _expandController,
        ]),
        builder: (context, child) {
          final isExpanding =
              _expandController.isAnimating ||
                  _expandController.isCompleted;

          final logoScale = isExpanding
              ? _expandScaleAnimation.value * _breatheAnimation.value
              : _breatheAnimation.value;

          final logoOpacity = isExpanding
              ? _expandOpacityAnimation.value
              : 1.0;

          return Stack(
            fit: StackFit.expand,
            children: [
              // Background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/main_bg.jpeg',
                  fit: BoxFit.cover,
                  color: Colors.black.withValues(alpha: 0.65),
                  colorBlendMode: BlendMode.darken,
                ),
              ),

              // Premium vignette
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.15,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.45),
                    ],
                  ),
                ),
              ),

              // Main content
              FadeTransition(
                opacity: _introOpacity,
                child: Center(
                  child: Opacity(
                    opacity: logoOpacity,
                    child: Transform.scale(
                      scale: logoScale,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                              AppColors.golden.withValues(alpha: 0.35),
                              blurRadius: 50,
                              spreadRadius: 5,
                            ),
                            BoxShadow(
                              color:
                              AppColors.golden.withValues(alpha: 0.18),
                              blurRadius: 120,
                              spreadRadius: 15,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/transparent_logo2.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                          color: AppColors.golden,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Flash reveal
              IgnorePointer(
                child: Container(
                  color: Colors.white.withValues(
                    alpha: _flashAnimation.value,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}