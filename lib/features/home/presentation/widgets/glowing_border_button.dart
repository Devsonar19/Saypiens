import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';

class GlowingBorderButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  
  const GlowingBorderButton({
    super.key, 
    required this.text,
    required this.onTap,
  });

  @override
  State<GlowingBorderButton> createState() => _GlowingBorderButtonState();
}

class _GlowingBorderButtonState extends State<GlowingBorderButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                padding: const EdgeInsets.all(2), // border width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: SweepGradient(
                    center: FractionalOffset.center,
                    colors: const [
                      Color(0xFFB8860B),
                      Colors.transparent,
                      Colors.transparent,
                      Color(0xFFB8860B),
                    ],
                    stops: const [0.0, 0.25, 0.75, 1.0],
                    transform: GradientRotation(_controller.value * 2 * 3.1415926535),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFB8860B).withValues(alpha: _isHovered ? 0.6 : 0.3),
                      blurRadius: _isHovered ? 20 : 12,
                      spreadRadius: _isHovered ? 4 : 2,
                    )
                  ]
                ),
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest, // Inner background
                borderRadius: BorderRadius.circular(28),
              ),
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
