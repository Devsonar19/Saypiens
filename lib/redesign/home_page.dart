import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme.dart';
import 'widgets.dart';

class SaypiensRedesignPage extends StatefulWidget {
  const SaypiensRedesignPage({super.key});

  @override
  State<SaypiensRedesignPage> createState() => _SaypiensRedesignPageState();
}

class _SaypiensRedesignPageState extends State<SaypiensRedesignPage> {
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
      backgroundColor: AppTheme.surface,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: CustomPaint(
                painter: DotGridPainter(
                  color: AppTheme.tertiaryFixed,
                  spacing: 32.0,
                ),
              ),
            ),
          ),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(child: const SizedBox(height: 100)),
              SliverToBoxAdapter(child: _buildHero(context)),
              SliverToBoxAdapter(child: SizedBox(key: _meetupsKey, height: 100)),
              SliverToBoxAdapter(child: _buildMeetupRecap(context)),
              SliverToBoxAdapter(child: SizedBox(key: _socialsKey, height: 100)),
              SliverToBoxAdapter(child: _buildSocials(context)),
              SliverToBoxAdapter(child: const SizedBox(height: 100)),
              SliverToBoxAdapter(child: _buildFooter(context)),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest.withOpacity(0.8),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/transparent_logo.png', height: 32),
                    const SizedBox(width: 16),
                    Text(
                      'Saypiens',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.onSurface,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => _scrollTo(_meetupsKey),
                      child: Text('Meetups', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppTheme.onSurfaceVariant)),
                    ),
                    const SizedBox(width: 24),
                    TextButton(
                      onPressed: () => _scrollTo(_socialsKey),
                      child: Text('Socials', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppTheme.onSurfaceVariant)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppTheme.primary, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text('THE INTELLECTUAL COMMONS // VOL. IV', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppTheme.onSurfaceVariant, letterSpacing: 1.5)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.displayLarge,
                  children: [
                    const TextSpan(text: 'Say it '),
                    TextSpan(
                      text: 'out loud.',
                      style: GoogleFonts.syne(
                        color: AppTheme.secondary,
                        fontStyle: FontStyle.italic,
                        shadows: [Shadow(color: AppTheme.primary.withOpacity(0.3), blurRadius: 35)],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'A sanctuary for open minds, bold discourse, and creative intellects. Where unfiltered curiosity meets thoughtful dialogue across coffee, candlelit salons, and open manuscripts.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: AppTheme.onPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                      textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Join the Movement'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () => _scrollTo(_socialsKey),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.onSurface,
                      side: BorderSide(color: AppTheme.outlineVariant.withOpacity(0.5)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Explore the Codex'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeetupRecap(BuildContext context) {
    return Container(
      color: AppTheme.surfaceContainerLowest,
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('EPISODE-1 // SAY IT!', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppTheme.primary, letterSpacing: 2)),
                const SizedBox(height: 8),
                Text('Salon Debrief & Atmosphere', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 48),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: _buildMeetupNotes(context),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                            image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuB1fffgQrjAel7UxNS3IxsHw2Oo5tE59b-YBAKiyNgkRTytScu5KLitIFzORdkdL-VbFkz6KyAtdjnEtSOctDfiYbytJ8uTpNG69vw6pVNpe5NzU26B337SLlZ5U4TpatFgwpzgs5fwYZuuIT_JbQaUtEmYO4hKCu36HmPB5wV9UzyNeExLH22Xb3HuLVuayZ7dP6LY86QcGbpaERoWGDPlvYDPoyR6NIeYC7KTUJCfSihHr2_9ZIU'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMeetupNotes(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
                ),
                child: Text('Recap & Highlights', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppTheme.secondary)),
              ),
              Text('180 Mins Uncut Dialogue', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 24),
          Text('The Motive // Dialectical Queries', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppTheme.primary, letterSpacing: 1.5)),
          const SizedBox(height: 16),
          _buildQuoteCard(context, '“What happens when civil discourse confronts taboo curiosities in an algorithmic echo-chamber?”'),
          const SizedBox(height: 8),
          _buildQuoteCard(context, '“Why are contemporary intellectual spaces shedding nuance in favor of instant ideological consensus?”'),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.2)),
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
    );
  }

  Widget _buildSocials(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text('THE NETWORKED SALON', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppTheme.primary, letterSpacing: 2)),
              const SizedBox(height: 8),
              Text('Connect With Us', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 16),
              Text('Select a platform to join our sanctuary of inquiry.', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 48),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  _buildSocialCard(context, 'X / Twitter', 'Real-time dialectic threads, philosophical aphorisms, live salon prompts, and global updates.'),
                  _buildSocialCard(context, 'r/Saypiens', 'Long-form member essays, philosophical peer review critiques, and scheduled AMAs.'),
                  _buildSocialCard(context, 'Discord', 'Intimate Discord channels categorized by epistemic domain: Ethics, Aesthetics, & Tech.'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialCard(BuildContext context, String title, String desc) {
    return Container(
      width: 350,
      height: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 24)),
          const SizedBox(height: 16),
          Text(desc, style: Theme.of(context).textTheme.bodySmall, maxLines: 3, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      color: AppTheme.tertiaryFixed,
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Saypiens™', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.onTertiaryFixed)),
                const SizedBox(height: 8),
                Text('EST. 2024', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppTheme.onTertiaryFixedVariant)),
                const SizedBox(height: 32),
                Text('© 2026 Saypiens Community. Handcrafted for deliberate thinkers.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.onTertiaryFixedVariant)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
