import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/app_constants.dart';
import '../widgets/about_us.dart';
import '../../../../theme/app_color.dart';
import '../widgets/top_nav_bar.dart';
import '../widgets/hero_main_section.dart';
import '../widgets/gathering_section.dart';
import '../widgets/socials_section.dart';
import '../widgets/footer_section.dart';

class InteractiveDotGridPainter extends CustomPainter {
  final Color color;
  final double spacing;
  final double baseRadius;
  final Offset mousePosition;
  final double breathingValue;

  InteractiveDotGridPainter({
    required this.color,
    this.spacing = 24.0,
    this.baseRadius = 0.8,
    required this.mousePosition,
    required this.breathingValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double globalOpacity = 0.15 + (0.10 * breathingValue); // breathes between 0.15 and 0.25
    final basePaint = Paint()..color = color.withOpacity(globalOpacity);

    const double interactionRadius = 160.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        final dotPos = Offset(x, y);
        final distance = (dotPos - mousePosition).distance;

        if (distance < interactionRadius) {
          final double intensity = 1.0 - (distance / interactionRadius);
          // Finer scale: up to ~2.3px
          final double currentRadius = baseRadius + (breathingValue * 0.3) + (intensity * 1.5);
          
          final paint = Paint()
             ..color = Color.lerp(
               color.withOpacity(globalOpacity), 
               color.withOpacity(0.9), 
               intensity
             )!;
          canvas.drawCircle(dotPos, currentRadius, paint);
        } else {
          final double currentRadius = baseRadius + (breathingValue * 0.3);
          canvas.drawCircle(dotPos, currentRadius, basePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant InteractiveDotGridPainter oldDelegate) {
    return oldDelegate.mousePosition != mousePosition || 
           oldDelegate.breathingValue != breathingValue;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _meetupsKey = GlobalKey();
  final GlobalKey _socialsKey = GlobalKey();
  
  bool _showBecomeSaypien = false;
  
  late AnimationController _breathingController;
  final ValueNotifier<Offset> _mousePosition = ValueNotifier(const Offset(-1000, -1000));

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  void _onScroll() {
    // The Hero section and About Us section roughly take up the first ~1200px.
    // We'll toggle the button when scrolled past 1000px.
    final bool shouldShow = _scrollController.offset > 1000;
    if (shouldShow != _showBecomeSaypien) {
      setState(() {
        _showBecomeSaypien = shouldShow;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _breathingController.dispose();
    _mousePosition.dispose();
    super.dispose();
  }

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

  Future<void> _launchWhatsApp() async {
    final Uri url = Uri.parse(AppConstants.whatsappCommunityUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: MouseRegion(
        onHover: (event) => _mousePosition.value = event.localPosition,
        onExit: (event) => _mousePosition.value = const Offset(-1000, -1000),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _breathingController,
                builder: (context, _) {
                  return ValueListenableBuilder<Offset>(
                    valueListenable: _mousePosition,
                    builder: (context, mousePos, _) {
                      return CustomPaint(
                        painter: InteractiveDotGridPainter(
                          color: AppColors.tertiaryFixed,
                          spacing: 24.0,
                          mousePosition: mousePos,
                          breathingValue: _breathingController.value,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
              SliverToBoxAdapter(child: HeroSection(
                onJoinPressed: _launchWhatsApp,
                onExplorePressed: () => _scrollTo(_socialsKey),
              )),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
              SliverToBoxAdapter(child: SizedBox(key: _aboutKey, child: const AboutUsSection())),
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
              onAboutTap: () => _scrollTo(_aboutKey),
              onMeetupsTap: () => _scrollTo(_meetupsKey),
              onSocialsTap: () => _scrollTo(_socialsKey),
              showBecomeSaypien: _showBecomeSaypien,
              onBecomeSaypienTap: _launchWhatsApp,
            ),
          ),
        ],
      ),
      ),
    );
  }
}