import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/app_color.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
              decoration: BoxDecoration(
                color: AppColors.platinum.withOpacity(0.02),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColors.platinum.withOpacity(0.1), width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    'About Us',
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.golden,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'A team that believes in offline connection,\nrather than online presence.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.platinum.withOpacity(0.9),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.1,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Column(
                      children: [
                        Text(
                          "We noticed something: real friendships don't happen in feeds. They happen when you show up. When you listen without distraction. When you're actually present with the people in front of you. So we built this community around that simple idea.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: AppColors.platinum.withOpacity(0.7),
                            fontSize: 18,
                            height: 1.8,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "We host regular gatherings where genuine connection is the only agenda. No performance. No algorithm. Just humans choosing each other, consistently.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: AppColors.platinum.withOpacity(0.7),
                            fontSize: 18,
                            height: 1.8,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 64),

                        // Golden Blockquote Container
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
                          decoration: BoxDecoration(
                            color: AppColors.golden.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.golden.withOpacity(0.2), width: 1),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.format_quote_rounded, color: AppColors.golden.withOpacity(0.5), size: 40),
                              const SizedBox(height: 24),
                              Text(
                                '"We were bestowed upon the past, but we are accountable for the future"',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.playfairDisplay(
                                  color: AppColors.golden,
                                  fontSize: 26,
                                  fontStyle: FontStyle.italic,
                                  height: 1.4,
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
            ),
          ),
        ),
      ),
    );
  }
}