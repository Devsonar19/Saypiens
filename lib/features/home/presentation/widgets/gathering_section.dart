import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../theme/app_color.dart';
import '../../../../core/app_constants.dart';
import 'glowing_border_button.dart';

class GatheringsSection extends StatelessWidget {
  const GatheringsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;
    
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upcoming Meetup First
                const UpcomingMeetupCard(),
                
                const SizedBox(height: 120),
                
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.radio_button_checked, color: AppColors.primary, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              'EPISODE 1',
                              style: GoogleFonts.syne(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                letterSpacing: 3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'SAY IT!',
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Content Columns
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _buildLeftColumn(context)),
                      const SizedBox(width: 24),
                      Expanded(flex: 6, child: _buildRightColumn(context)),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLeftColumn(context),
                      const SizedBox(height: 24),
                      _buildRightColumn(context),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftColumn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Text(
                  'RECAP & HIGHLIGHTS',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.access_time, color: AppColors.primary, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    '180 Mins Uncut Dialogue',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Venue Box
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cafe 404, Vesu',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Surat, Gujarat • Open to all Saypiens',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        final Uri url = Uri.parse('https://maps.app.goo.gl/vk4sboc6B5h321Aq6');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary.withOpacity(0.15),
                        foregroundColor: AppColors.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const FaIcon(FontAwesomeIcons.locationDot, size: 16, color: Colors.redAccent),
                      label: Text(
                        'Open Maps',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Format: GD',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          Row(
            children: [
              Icon(Icons.psychology_outlined, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'The Agenda',
                style: GoogleFonts.syne(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          _buildQuoteCard('“What you try to get away from, gets back to you. Don\'t try to escape it. Face it.”'),
          const SizedBox(height: 12),
          _buildQuoteCard('“What\'s one thing nobody (parents, society, or school) taught you, but you think is crucial for Gen Z?”'),
          
          const SizedBox(height: 32),
          
          Row(
            children: [
              Icon(Icons.done_all, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'conclusion',
                style: GoogleFonts.syne(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildConsensusItem('Connect, Reflect, keep trying'),
          _buildConsensusItem('Stop comparing'),
          _buildConsensusItem('Express your emotions & Be kind :)'),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131B2A), // Slightly darker blue-slate
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Text(
        text,
        style: GoogleFonts.cormorantGaramond(
          fontSize: 20,
          fontStyle: FontStyle.italic,
          color: Colors.white.withOpacity(0.9),
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildConsensusItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: AppColors.primary, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AutoScrollingGallery(),
          // Bottom Stats row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.onSurfaceVariant),
                    const SizedBox(width: 12),
                    Text(
                      '6 September 2026',
                      style: GoogleFonts.plusJakartaSans(fontSize: 14, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
                Text(
                  '4:00 PM',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

class AutoScrollingGallery extends StatefulWidget {
  const AutoScrollingGallery({super.key});

  @override
  State<AutoScrollingGallery> createState() => _AutoScrollingGalleryState();
}

class _AutoScrollingGalleryState extends State<AutoScrollingGallery> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isHovering = false;
  
  final List<Map<String, String>> galleryItems = [
    {
      'image': 'assets/images/meetup1.jpg',
      'text': '"Connect with someone today, reflect on what their words stirred in you, and let that quiet moment remind you how much you\'ve already grown."'
    },
    {
      'image': 'assets/images/meetup2.jpg',
      'text': '"Progress isn\'t a race against anyone else\'s timeline, so stop comparing your chapter one to someone\'s chapter twenty and simply keep trying."'
    },
    {
      'image': 'assets/images/meetup3.jpg',
      'text': '"Your feelings are valid signals, not burdens, express your emotions honestly instead of carrying them silently."'
    },
    {
      'image': 'assets/images/meetup4.jpg',
      'text': '"Growth happens in the small, stubborn moments when you choose to keep trying even after setbacks leave you doubting yourself."'
    },
    {
      'image': 'assets/images/meetup5.jpg',
      'text': '"End every day the way you\'d want to be treated, with kindness toward others and a little grace toward yourself."'
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      if (!_isHovering) {
        _currentPage = (_currentPage + 1) % galleryItems.length;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _isHovering = true,
      onExit: (_) => _isHovering = false,
      child: SizedBox(
        height: 520, // Increased slightly to accommodate portraits better
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) => _currentPage = index,
          itemCount: galleryItems.length,
          itemBuilder: (context, index) {
            final item = galleryItems[index];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(item['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    item['text']!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class UpcomingMeetupCard extends StatefulWidget {
  const UpcomingMeetupCard({super.key});

  @override
  State<UpcomingMeetupCard> createState() => _UpcomingMeetupCardState();
}

class _UpcomingMeetupCardState extends State<UpcomingMeetupCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(1.5), // Glow border width
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: SweepGradient(
              center: FractionalOffset.center,
              colors: [
                AppColors.primary.withOpacity(0.1),
                AppColors.primary.withOpacity(0.8),
                AppColors.primary.withOpacity(0.1),
                AppColors.primary.withOpacity(0.8),
                AppColors.primary.withOpacity(0.1),
              ],
              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
              transform: GradientRotation(_controller.value * 2 * 3.14159),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ]
          ),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(15),
        ),
        child: isDesktop 
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildUpcomingInfo()),
                const SizedBox(width: 32),
                _buildKeepUpdatedButton(),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUpcomingInfo(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: _buildKeepUpdatedButton(),
                ),
              ],
            ),
      ),
    );
  }

  Widget _buildUpcomingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'EPISODE 2',
              style: GoogleFonts.syne(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Coming Soon...',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildKeepUpdatedButton() {
    return ElevatedButton(
      onPressed: () async {
        final Uri url = Uri.parse(AppConstants.whatsappCommunityUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2B3241), // Greyed out surface color
        foregroundColor: Colors.white.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(FontAwesomeIcons.whatsapp, size: 20, color: Colors.greenAccent),
          const SizedBox(width: 12),
          Text(
            'Keep Updated',
            style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}