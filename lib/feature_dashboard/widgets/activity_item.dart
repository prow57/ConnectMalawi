import 'package:flutter/material.dart';
import '../models/dashboard_model.dart';
import '../../constants/theme_constants.dart';

class ActivityItem extends StatelessWidget {
  final RecentActivity activity;

  const ActivityItem({
    super.key,
    required this.activity,
  });

  Color _getActivityColor() {
    switch (activity.type) {
      case 'transfer':
        return ThemeConstants.primaryColor;
      case 'deposit':
        return ThemeConstants.successColor;
      case 'withdrawal':
        return ThemeConstants.errorColor;
      default:
        return ThemeConstants.textSecondaryColor;
    }
  }

  IconData _getActivityIcon() {
    switch (activity.type) {
      case 'transfer':
        return Icons.swap_horiz;
      case 'deposit':
        return Icons.arrow_downward;
      case 'withdrawal':
        return Icons.arrow_upward;
      default:
        return Icons.info;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getActivityColor();
    final icon = _getActivityIcon();

    return Container(
      padding: const EdgeInsets.all(ThemeConstants.spacingM),
      decoration: BoxDecoration(
        color: ThemeConstants.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
        boxShadow: ThemeConstants.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(ThemeConstants.spacingS),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusS),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: ThemeConstants.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: ThemeConstants.body1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity.description,
                  style: ThemeConstants.body2.copyWith(
                    color: ThemeConstants.textSecondaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'MK ${activity.amount.toStringAsFixed(2)}',
                style: ThemeConstants.body1.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDate(activity.date),
                style: ThemeConstants.caption.copyWith(
                  color: ThemeConstants.textSecondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
