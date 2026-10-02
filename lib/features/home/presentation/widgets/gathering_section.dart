import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';

class GatheringsSection extends StatelessWidget {
  const GatheringsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceContainerLowest,
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('EPISODE-1 // SAY IT!', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.primary, letterSpacing: 2)),
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
                          color: AppColors.surfaceContainerHigh,
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
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
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
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Text('Recap & Highlights', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.secondary)),
              ),
              Text('180 Mins Uncut Dialogue', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const SizedBox(height: 24),
          Text('The Motive // Dialectical Queries', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.primary, letterSpacing: 1.5)),
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
        color: AppColors.surfaceContainerLowest.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.2)),
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
    );
  }
}