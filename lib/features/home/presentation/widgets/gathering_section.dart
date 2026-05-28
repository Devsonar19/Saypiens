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
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      // Semi-transparent background to let the global image peek through
      color: Colors.black.withOpacity(0.4),
      alignment: Alignment.center,
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
          const SizedBox(height: 16),
          // The Empty State Card
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 600), // Keeps it from stretching too wide on desktop
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6), // Dark glass effect
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.golden.withOpacity(0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.golden.withOpacity(0.05),
                  blurRadius: 30,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.golden.withOpacity(0.7),
                  size: 48,
                ),
                const SizedBox(height: 24),
                Text(
                  'Stay Tuned',
                  style: GoogleFonts.playfairDisplay(
                    color: AppColors.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppConstants.noEventsMessage, // "No upcoming events at the moment. Stay tuned."
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.7),
                    fontSize: 16,
                    letterSpacing: 0.5,
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