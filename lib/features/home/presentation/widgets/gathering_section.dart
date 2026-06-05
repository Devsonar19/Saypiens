import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_constants.dart';
import '../../../../theme/app_color.dart';

class GatheringsSection extends StatelessWidget {
  const GatheringsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000), // Limits width on wide screens
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
              decoration: BoxDecoration(
                color: AppColors.platinum.withOpacity(0.02), // Main glass background
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColors.platinum.withOpacity(0.1), width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    'Upcoming Gatherings',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.golden,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // The Inner Event Card
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 600),
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3), // Darker inset for contrast
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.golden.withOpacity(0.15), width: 1),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.calendar_today_outlined, color: AppColors.golden.withOpacity(0.8), size: 48),
                        const SizedBox(height: 24),
                        Text(
                          'Stay Tuned',
                          style: GoogleFonts.playfairDisplay(
                            color: AppColors.platinum,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppConstants.noEventsMessage,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: AppColors.platinum.withOpacity(0.6),
                            fontSize: 16,
                            height: 1.6,
                            letterSpacing: 0.5,
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