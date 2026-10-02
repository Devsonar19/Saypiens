import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';

class TopNavBar extends StatelessWidget {
  final VoidCallback onMeetupsTap;
  final VoidCallback onSocialsTap;

  const TopNavBar({
    super.key,
    required this.onMeetupsTap,
    required this.onSocialsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withOpacity(0.8),
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
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: onMeetupsTap,
                      child: Text('Meetups', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.onSurfaceVariant)),
                    ),
                    const SizedBox(width: 24),
                    TextButton(
                      onPressed: onSocialsTap,
                      child: Text('Socials', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.onSurfaceVariant)),
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
}