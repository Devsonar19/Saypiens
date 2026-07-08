import 'package:flutter/material.dart';
import '../widgets/about_us.dart';
import '../widgets/gathering_section.dart';
import '../widgets/hero_main_section.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/socials_section.dart';
import '../widgets/scroll_reveal.dart';
import '../../../../theme/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // The keys will now be attached to our invisible anchor points!
  final GlobalKey _gatheringsKey = GlobalKey();
  final GlobalKey _socialsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // THE FIX: We go back to the basic, native smooth scroll.
  // No math needed because the 100px offset is handled by the SizedBoxes in the layout!
  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutExpo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/main_bg.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Container(color: AppColors.black.withOpacity(0.7)),

          // 2. Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 100),

                // Hero Section
                const HeroSection(),

                // --- GATHERINGS ANCHOR ---
                SizedBox(key: _gatheringsKey, height: 1),
                const SizedBox(height: 100), // Acts as both layout gap and navbar clearance
                const ScrollReveal(child: GatheringsSection()),

                // --- SOCIALS ANCHOR ---
                SizedBox(key: _socialsKey, height: 1),
                const SizedBox(height: 100),
                const ScrollReveal(child: SocialsSection()),

                // --- ABOUT ANCHOR ---
                // THE FIX: Standardized this back to 1px anchor + 100px gap so it matches the others!
                SizedBox(key: _aboutKey, height: 1),
                const SizedBox(height: 100),
                const ScrollReveal(child: StorySection()),

                const SizedBox(height: 150), // Extra breathing room at the very bottom
              ],
            ),
          ),

          // 3. Sticky Top Nav Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopNavBar(
              scrollController: _scrollController,
              onGatheringsTap: () => _scrollTo(_gatheringsKey),
              onSocialsTap: () => _scrollTo(_socialsKey),
              onAboutTap: () => _scrollTo(_aboutKey),
            ),
          ),
        ],
      ),
    );
  }
}