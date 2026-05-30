import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/app_color.dart';
import '../../../../utils/responsive_layout.dart';
import 'join_dialog.dart';

class TopNavBar extends StatefulWidget {
  final VoidCallback onGatheringsTap;
  final VoidCallback onSocialsTap;
  final VoidCallback onAboutTap;

  const TopNavBar({
    super.key,
    required this.onGatheringsTap,
    required this.onSocialsTap,
    required this.onAboutTap,
  });

  @override
  State<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  bool _isGatheringsHovered = false;
  bool _isAboutHovered = false;
  bool _isSocialsHovered = false;


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
                      onPressed: widget.onGatheringsTap,
                      onHover: (hovering) {
                        setState(() => _isGatheringsHovered = hovering);
                      },
                      child: Text(
                        'Gatherings',
                        style: TextStyle(
                          color: _isGatheringsHovered ? AppColors.golden : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: widget.onAboutTap,
                      onHover: (hovering) {
                        setState(() => _isAboutHovered = hovering);
                      },
                      child: Text(
                        'About',
                        style: TextStyle(
                          color: _isAboutHovered ? AppColors.golden : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: widget.onSocialsTap,
                      onHover: (hovering) {
                        setState(() => _isSocialsHovered = hovering);
                      },
                      child: Text(
                        'Socials',
                        style: TextStyle(
                          color: _isSocialsHovered ? AppColors.golden : AppColors.textPrimary,
                        ),
                      ),
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
                    if (value == 'gatherings') widget.onGatheringsTap();
                    if (value == 'about') widget.onAboutTap();
                    if (value == 'socials') widget.onSocialsTap();
                    if (value == 'join') _showJoinDialog(context);
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: 'gatherings',
                      child: Text('Gatherings', style: TextStyle(color: AppColors.textPrimary)),
                    ),
                    const PopupMenuItem(
                      value: 'about',
                      child: Text('About', style: TextStyle(color: AppColors.textPrimary)),
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