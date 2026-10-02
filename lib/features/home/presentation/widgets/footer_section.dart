import 'package:flutter/material.dart';
import '../../../../theme/app_color.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.tertiaryFixed,
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Saypiens™', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.onTertiaryFixed)),
                const SizedBox(height: 8),
                Text('EST. 2024', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.onTertiaryFixedVariant)),
                const SizedBox(height: 32),
                Text('© 2026 Saypiens Community. Handcrafted for deliberate thinkers.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onTertiaryFixedVariant)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
