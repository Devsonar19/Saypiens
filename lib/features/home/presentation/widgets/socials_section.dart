import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';

class SocialsSection extends StatelessWidget {
  const SocialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text('THE NETWORKED SALON', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.primary, letterSpacing: 2)),
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
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.4)),
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
}