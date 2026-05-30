import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/app_color.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      color: Colors.black.withOpacity(0.8), // Darker overlay for contrast
      child: Column(
        children: [
          // Section Title
          Text(
            'About Us',
            style: GoogleFonts.playfairDisplay(
              color: AppColors.golden,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),

          // The Headline/Subtitle
          Text(
            'A team that believes in offline connection, rather than online presence.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.golden.withOpacity(0.8),
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 48),

          // The Content Container
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Text(
                  "We noticed something: real friendships don't happen in feeds. They happen when you show up. When you listen without distraction. When you're actually present with the people in front of you. So we built this community around that simple idea.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.9),
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "We host regular gatherings where genuine connection is the only agenda. No performance. No algorithm. Just humans choosing each other, consistently.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.9),
                    fontSize: 18,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 64),

                // The Golden Blockquote
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: AppColors.golden.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.golden.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.format_quote_rounded, color: AppColors.golden.withOpacity(0.5), size: 48),
                      const SizedBox(height: 16),
                      Text(
                        '"We were bestowed upon the past, but we are accountable for the future"',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lora(
                          color: AppColors.golden,
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}