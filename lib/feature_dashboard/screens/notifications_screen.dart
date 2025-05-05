import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/theme_constants.dart';
import '../../utilities/formatters.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _notifications = [
    {
      'type': 'transaction',
      'title': 'Money Received',
      'message': 'You have received MK 500.00 from John Doe',
      'date': DateTime.now().subtract(const Duration(minutes: 5)),
      'isRead': false,
    },
    {
      'type': 'request',
      'title': 'Money Request',
      'message': 'Jane Smith has requested MK 1000.00 from you',
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'isRead': false,
    },
    {
      'type': 'system',
      'title': 'System Update',
      'message': 'New features are available in the latest update',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'isRead': true,
    },
    {
      'type': 'transaction',
      'title': 'Money Sent',
      'message': 'You have sent MK 750.00 to Mike Johnson',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'isRead': true,
    },
    {
      'type': 'promotion',
      'title': 'Special Offer',
      'message': 'Get 50% off on your next transaction',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var notification in _notifications) {
                  notification['isRead'] = true;
                }
              });
            },
            child: const Text('Mark All as Read'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(ThemeConstants.spacingL),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: ThemeConstants.spacingM),
            decoration: BoxDecoration(
              color: ThemeConstants.surfaceColor,
              borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
              boxShadow: ThemeConstants.cardShadow,
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(ThemeConstants.spacingS),
                decoration: BoxDecoration(
                  color: _getNotificationColor(notification['type'] as String)
                      .withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getNotificationIcon(notification['type'] as String),
                  color: _getNotificationColor(notification['type'] as String),
                ),
              ),
              title: Text(
                notification['title'] as String,
                style: ThemeConstants.body1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: notification['isRead'] as bool
                      ? ThemeConstants.textSecondaryColor
                      : ThemeConstants.textPrimaryColor,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification['message'] as String,
                    style: ThemeConstants.body2.copyWith(
                      color: notification['isRead'] as bool
                          ? ThemeConstants.textSecondaryColor
                          : ThemeConstants.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingXS),
                  Text(
                    Formatters.formatDateTime(notification['date'] as DateTime),
                    style: ThemeConstants.body2.copyWith(
                      color: ThemeConstants.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              trailing: !(notification['isRead'] as bool)
                  ? Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: ThemeConstants.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
              onTap: () {
                setState(() {
                  notification['isRead'] = true;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'transaction':
        return ThemeConstants.primaryColor;
      case 'request':
        return ThemeConstants.successColor;
      case 'system':
        return ThemeConstants.errorColor;
      case 'promotion':
        return ThemeConstants.secondaryColor;
      default:
        return ThemeConstants.primaryColor;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'transaction':
        return Icons.attach_money;
      case 'request':
        return Icons.request_quote;
      case 'system':
        return Icons.system_update;
      case 'promotion':
        return Icons.local_offer;
      default:
        return Icons.notifications;
    }
  }
}
