import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/responsive_layout.dart';
import 'join_dialog.dart';

class TopNavBar extends StatelessWidget {
  final VoidCallback onGatheringsTap;
  final VoidCallback onSocialsTap;

  const TopNavBar({
    super.key,
    required this.onGatheringsTap,
    required this.onSocialsTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 40, // Tighter padding on mobile
            vertical: 20,
          ),
          color: Colors.black.withOpacity(0.4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saypiens',
                style: GoogleFonts.playfairDisplay(
                  color: AppColors.golden,
                  fontSize: isMobile ? 32 : 42, // Scale logo down slightly
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),

              if (!isMobile) ...[
                // Desktop: Show full links
                Row(
                  children: [
                    TextButton(
                      onPressed: onGatheringsTap,
                      child: const Text('Gatherings', style: TextStyle(color: AppColors.textPrimary)),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: onSocialsTap,
                      child: const Text('Socials', style: TextStyle(color: AppColors.textPrimary)),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.golden,
                    foregroundColor: AppColors.background,
                  ),
                  onPressed: () => _showJoinDialog(context),
                  child: const Text('Become a Saypien', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ] else ...[
                // Mobile: Show a Popup Menu
                PopupMenuButton<String>(
                  icon: const Icon(Icons.menu, color: AppColors.golden, size: 32),
                  color: Colors.black.withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.golden.withOpacity(0.3)),
                  ),
                  onSelected: (value) {
                    if (value == 'gatherings') onGatheringsTap();
                    if (value == 'socials') onSocialsTap();
                    if (value == 'join') _showJoinDialog(context);
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'gatherings',
                      child: Text('Gatherings', style: TextStyle(color: AppColors.textPrimary)),
                    ),
                    const PopupMenuItem(
                      value: 'socials',
                      child: Text('Socials', style: TextStyle(color: AppColors.textPrimary)),
                    ),
                    const PopupMenuItem(
                      value: 'join',
                      child: Text('Become a Saypien', style: TextStyle(color: AppColors.golden, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showJoinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const JoinSaypienDialog(),
    );
  }
}