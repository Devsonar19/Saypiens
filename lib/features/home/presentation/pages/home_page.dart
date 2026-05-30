import 'package:flutter/material.dart';
import 'package:saypiens/features/home/presentation/widgets/about_us.dart';
import '../widgets/gathering_section.dart';
import '../widgets/hero_main_section.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/hero_main_section.dart';
import '../widgets/gathering_section.dart';
import '../widgets/socials_section.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Keys for smooth scrolling
  final GlobalKey _gatheringsKey = GlobalKey();
  final GlobalKey _socialsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E3F29), // Main background
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopNavBar(
              onGatheringsTap: () => _scrollTo(_gatheringsKey),
              onSocialsTap: () => _scrollTo(_socialsKey),
              onAboutTap: () => _scrollTo(_aboutKey),
            ),
            const HeroSection(),
            GatheringsSection(key: _gatheringsKey),
            SocialsSection(key: _socialsKey),
            StorySection(key: _aboutKey),
            const SizedBox(height: 100), // Bottom padding
          ],
        ),
      ),
    );
  }
}