import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/app_color.dart';

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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text('THE INTELLECTUAL COMMONS // VOL. IV', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.onSurfaceVariant, letterSpacing: 1.5)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.displayLarge,
                  children: [
                    const TextSpan(text: 'Say it '),
                    TextSpan(
                      text: 'out loud.',
                      style: GoogleFonts.syne(
                        color: AppColors.secondary,
                        fontStyle: FontStyle.italic,
                        shadows: [Shadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 35)],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'A sanctuary for open minds, bold discourse, and creative intellects. Where unfiltered curiosity meets thoughtful dialogue across coffee, candlelit salons, and open manuscripts.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: onJoinPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                      textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Join the Movement'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: onExplorePressed,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.onSurface,
                      side: BorderSide(color: AppColors.outlineVariant.withOpacity(0.5)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Explore the Codex'),
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