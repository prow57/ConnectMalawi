import 'package:flutter/material.dart';
import '../../constants/theme_constants.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ThemeConstants.spacingM),
      decoration: BoxDecoration(
        color: ThemeConstants.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
        boxShadow: ThemeConstants.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ThemeConstants.spacingS),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(ThemeConstants.borderRadiusS),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: ThemeConstants.spacingS),
              Text(
                title,
                style: ThemeConstants.body2.copyWith(
                  color: ThemeConstants.textSecondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: ThemeConstants.spacingM),
          Text(
            value,
            style: ThemeConstants.heading3.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
