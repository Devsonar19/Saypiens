import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/hero_main_section.dart';
import '../widgets/gathering_section.dart';
import '../widgets/socials_section.dart';
import '../widgets/footer_section.dart';

class DotGridPainter extends CustomPainter {
  final Color color;
  final double spacing;
  final double radius;

  DotGridPainter({
    required this.color,
    this.spacing = 32.0,
    this.radius = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _meetupsKey = GlobalKey();
  final GlobalKey _socialsKey = GlobalKey();

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
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: CustomPaint(
                painter: DotGridPainter(
                  color: AppColors.tertiaryFixed,
                  spacing: 32.0,
                ),
              ),
            ),
          ),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
              SliverToBoxAdapter(child: HeroSection(
                onJoinPressed: () {},
                onExplorePressed: () => _scrollTo(_socialsKey),
              )),
              SliverToBoxAdapter(child: SizedBox(key: _meetupsKey, height: 100)),
              const SliverToBoxAdapter(child: GatheringsSection()),
              SliverToBoxAdapter(child: SizedBox(key: _socialsKey, height: 100)),
              const SliverToBoxAdapter(child: SocialsSection()),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
              const SliverToBoxAdapter(child: FooterSection()),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopNavBar(
              onMeetupsTap: () => _scrollTo(_meetupsKey),
              onSocialsTap: () => _scrollTo(_socialsKey),
            ),
          ),
        ],
      ),
    );
  }
}