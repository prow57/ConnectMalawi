import 'package:flutter/material.dart';
import '../models/dashboard_model.dart';
import '../functions/dashboard_functions.dart';
import '../../constants/theme_constants.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const NotificationItem({
    super.key,
    required this.notification,
    this.onTap,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: ThemeConstants.spacingM),
        color: Colors.red,
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(ThemeConstants.spacingM),
          decoration: BoxDecoration(
            color: notification.isRead
                ? Colors.white
                : ThemeConstants.primaryColor.withOpacity(0.05),
            border: Border(
              bottom: BorderSide(
                color: ThemeConstants.textSecondaryColor.withOpacity(0.1),
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ThemeConstants.spacingS),
                decoration: BoxDecoration(
                  color: ThemeConstants.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  DashboardFunctions.getNotificationTypeIcon(notification.type),
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: ThemeConstants.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: ThemeConstants.body1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: notification.isRead
                            ? ThemeConstants.textSecondaryColor
                            : ThemeConstants.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: ThemeConstants.body2.copyWith(
                        color: ThemeConstants.textSecondaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DashboardFunctions.getTimeAgo(notification.date),
                      style: ThemeConstants.caption.copyWith(
                        color: ThemeConstants.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (!notification.isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: ThemeConstants.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
} 