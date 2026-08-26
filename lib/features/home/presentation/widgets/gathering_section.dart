import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../theme/app_color.dart';

class GatheringsSection extends StatelessWidget {
  const GatheringsSection({super.key});

  // --- GOOGLE MAPS TRIGGER ---
  Future<void> _openGoogleMaps() async {
    final Uri mapsUrl = Uri.parse(
        'https://www.google.com/maps/dir//Caffe+404,+G-11,+Aagam+Emporio,+University+Rd,+beside+GNine+Hotel,+Vesu,+Surat,+Gujarat+395007/@22.2887936,73.3642752,6897m/data=!3m1!1e3!4m8!4m7!1m0!1m5!1m1!1s0x3be04d86b604ef6d:0xe609b50805e8d092!2m2!1d72.7765729!2d21.1522332?entry=ttu&g_ep=EgoyMDI2MDgyMy4wIKXMDSoASAFQAw%3D%3D');

    if (await canLaunchUrl(mapsUrl)) {
      await launchUrl(mapsUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch maps.');
    }
  }

  // --- WHATSAPP TRIGGER ---
  Future<void> _openWhatsApp() async {
    final Uri waUrl = Uri.parse('https://chat.whatsapp.com/ESg5RG2cQ6a4LYsnqwYcfq');

    if (await canLaunchUrl(waUrl)) {
      await launchUrl(waUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch WhatsApp.');
    }
  }

  // --- RESPONSIVE INFO ROW ---
  Widget _buildInfoRow(IconData icon, String text, bool isMobile, {Widget? trailing}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 16 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(isMobile ? 10 : 12),
            decoration: BoxDecoration(
              color: AppColors.golden.withOpacity(0.08),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.golden.withOpacity(0.2), width: 1),
            ),
            child: Icon(icon, color: AppColors.golden, size: isMobile ? 18 : 22),
          ),
          SizedBox(width: isMobile ? 12 : 20),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.outfit(
                color: AppColors.platinum.withOpacity(0.9),
                fontSize: isMobile ? 15 : 17,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3,
              ),
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: isMobile ? 8 : 12),
            trailing,
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- RESPONSIVE CHECK ---
    // If the screen is less than 600px wide, we treat it as a mobile device.
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      // Reduce outer padding on mobile
      padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 80, horizontal: isMobile ? 16 : 20),
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(
              // Reduce inner glass padding on mobile
              padding: EdgeInsets.symmetric(vertical: isMobile ? 40 : 80, horizontal: isMobile ? 16 : 24),
              decoration: BoxDecoration(
                color: AppColors.platinum.withOpacity(0.03),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColors.platinum.withOpacity(0.08), width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    'UPCOMING GATHERINGS',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.golden,
                      fontSize: isMobile ? 14 : 16, // Smaller title on mobile
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4.0,
                    ),
                  ),
                  SizedBox(height: isMobile ? 32 : 56),

                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 550),
                    // Drastically reduce card padding on mobile to give text room to breathe
                    padding: EdgeInsets.all(isMobile ? 24 : 48),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A0A0A).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: AppColors.golden.withOpacity(0.2), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.golden.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.golden.withOpacity(0.3), width: 1),
                          ),
                          child: Text(
                            'MEETUP #01',
                            style: GoogleFonts.spaceGrotesk(
                              color: AppColors.golden,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        Text(
                          "Surat's First Ever\nGenZ Brainstorming Event",
                          style: GoogleFonts.outfit(
                            color: AppColors.platinum,
                            // Scale down header font slightly for mobile
                            fontSize: isMobile ? 26 : 32,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 32),

                        Divider(color: AppColors.platinum.withOpacity(0.1), thickness: 1),

                        const SizedBox(height: 32),

                        // Pass isMobile to the helper so it scales icons and text automatically
                        _buildInfoRow(Icons.calendar_today_rounded, 'Sunday, 6th September, 2026', isMobile),
                        _buildInfoRow(Icons.access_time_rounded, '4:30 PM - 6:30 PM', isMobile),

                        _buildInfoRow(
                          Icons.location_on_rounded,
                          'Cafe 404, Vesu',
                          isMobile,
                          trailing: ElevatedButton.icon(
                            icon: Icon(Icons.near_me_rounded, size: isMobile ? 14 : 16),
                            label: Text(
                              'MAP',
                              style: GoogleFonts.spaceGrotesk(
                                fontWeight: FontWeight.w700,
                                fontSize: isMobile ? 11 : 13, // Smaller map button font
                                letterSpacing: 1.0,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.golden.withOpacity(0.15),
                              foregroundColor: AppColors.golden,
                              elevation: 0,
                              // Tighter button padding on mobile
                              padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 16, vertical: isMobile ? 8 : 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: _openGoogleMaps,
                          ),
                        ),

                        SizedBox(height: isMobile ? 16 : 24),

                        // --- PRIMARY BUTTON: WHATSAPP ---
                        SizedBox(
                          width: double.infinity,
                          height: isMobile ? 54 : 60, // Slightly shorter button on mobile
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.forum_rounded, size: 20),
                            label: Text(
                              'JOIN WHATSAPP',
                              style: GoogleFonts.spaceGrotesk(
                                fontWeight: FontWeight.w700,
                                fontSize: isMobile ? 13 : 15,
                                letterSpacing: 1.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.golden,
                              foregroundColor: Colors.black,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _openWhatsApp,
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