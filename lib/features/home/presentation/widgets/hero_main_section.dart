import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../../../../theme/app_color.dart';
import 'glowing_border_button.dart';

class KineticTextRoller extends StatefulWidget {
  const KineticTextRoller({super.key});

  @override
  State<KineticTextRoller> createState() => _KineticTextRollerState();
}

class _KineticTextRollerState extends State<KineticTextRoller> {
  final List<String> _suffixes = [
    "with pride,",
    "what you feel,",
    "what you think,",
    "it out loud,",
    "less,",
    "it with",
    "piens",
  ];

  int _currentIndex = 0;
  bool _isFused = false;
  bool _isScaled = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startSequence();
  }

  void _startSequence() {
    if (!mounted) return;
    setState(() {
      _currentIndex = 0;
      _isFused = false;
      _isScaled = false;
    });
    
    _timer?.cancel();
    
    _timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (!mounted) return;
      if (_currentIndex < _suffixes.length - 1) {
        setState(() {
          _currentIndex++;
        });
        if (_currentIndex == _suffixes.length - 1) {
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 150), () {
            if (mounted) {
              setState(() {
                _isFused = true;
              });
              
              // Wait for gap closing animation (850ms) to finish, then scale up
              Future.delayed(const Duration(milliseconds: 850), () {
                if (mounted) {
                  setState(() {
                    _isScaled = true;
                  });
                }
              });
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 800;
    
    final double baseSize = isDesktop ? 60 : 45;
    final double fusedSize = isDesktop ? 100 : 55;
    final double targetFontSize = _isScaled ? fusedSize : baseSize;
    
    final TextStyle prefixStyle = GoogleFonts.plusJakartaSans(
      fontSize: targetFontSize,
      fontWeight: FontWeight.w800,
      color: Colors.white,
      letterSpacing: -2.0,
    );
    
    final TextStyle rollerStyle = GoogleFonts.plusJakartaSans(
      fontSize: baseSize,
      fontWeight: FontWeight.w800,
      color: const Color(0xFF94A3B8), // Slate gray
      letterSpacing: -2.0,
    );

    final TextStyle fusedStyle = GoogleFonts.plusJakartaSans(
      fontSize: targetFontSize,
      fontWeight: FontWeight.w800,
      color: const Color(0xFFB8860B), // Goldenrod accent
      letterSpacing: -2.0,
    );

    // The gap between "Say" and the suffix shrinks to 0 when fused
    final double gapWidth = _isFused ? 0.0 : (isDesktop ? 16.0 : 8.0);
    final double itemHeight = isDesktop ? 120 : 80; // Enough height for the largest font

    return GestureDetector(
      onTap: _startSequence, // Tap to replay
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCubic,
              style: prefixStyle,
              child: const Text('Say'),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 850),
              curve: Curves.easeInOutCubic,
              width: gapWidth,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 850),
              curve: Curves.easeInOutCubic,
              alignment: Alignment.centerLeft,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  if (_isFused) {
                    return const LinearGradient(
                      colors: [Colors.white, Colors.white],
                    ).createShader(bounds);
                  }
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                      Colors.black,
                      Colors.transparent
                    ],
                    stops: [0.0, 0.15, 0.85, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCubic,
                  height: itemHeight,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Opacity(
                        opacity: 0.0,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeOutCubic,
                          style: _isFused ? fusedStyle : rollerStyle,
                          child: Text(
                            _isFused ? "piens" : "what you think,", 
                          ),
                        ),
                      ),
                      
                      // The scrolling text column
                      Positioned.fill(
                        child: ClipRect(
                          child: OverflowBox(
                            alignment: Alignment.topLeft,
                            maxHeight: double.infinity,
                            child: AnimatedSlide(
                              offset: Offset(0, -_currentIndex / _suffixes.length),
                              duration: const Duration(milliseconds: 550),
                              curve: Curves.easeInOutCubic,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _suffixes.asMap().entries.map((entry) {
                                  final int index = entry.key;
                                  final String text = entry.value;
                                  return SizedBox(
                                    height: itemHeight, // Force exact height for alignment
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: AnimatedDefaultTextStyle(
                                        duration: const Duration(milliseconds: 1000),
                                        curve: Curves.easeOutCubic,
                                        style: _isFused && index == _suffixes.length - 1 
                                            ? fusedStyle 
                                            : rollerStyle,
                                        child: Text(text, maxLines: 1),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final VoidCallback onJoinPressed;
  final VoidCallback onExplorePressed;

  const HeroSection({
    super.key,
    required this.onJoinPressed,
    required this.onExplorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
          child: Column(
            children: [
              // New Kinetic Text Roller
              const KineticTextRoller(),

              const SizedBox(height: 32),
              Text(
                '“A team that believes in offline connection,\nrather than online presence.”',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlowingBorderButton(
                    text: 'Join Us',
                    onTap: onJoinPressed,
                  ),
                  const SizedBox(width: 24),
                  HoverOutlinedButton(
                    text: 'Connect With Us',
                    onTap: onExplorePressed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HoverOutlinedButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const HoverOutlinedButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<HoverOutlinedButton> createState() => _HoverOutlinedButtonState();
}

class _HoverOutlinedButtonState extends State<HoverOutlinedButton> {
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
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovered ? AppColors.onSurface : AppColors.outlineVariant.withOpacity(0.5),
              width: 1.5,
            ),
            color: _isHovered ? AppColors.onSurface.withOpacity(0.05) : Colors.transparent,
          ),
          child: Text(
            widget.text,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}