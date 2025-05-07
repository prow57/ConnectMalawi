import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final Map<String, bool> _notificationSettings = {
    'Transaction Notifications': true,
    'Security Alerts': true,
    'Account Updates': true,
    'Promotional Messages': false,
    'Market Updates': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 24),
            _buildSectionHeader('Push Notifications'),
            ..._notificationSettings.entries.map(
              (entry) => _buildNotificationSwitch(
                entry.key,
                entry.value,
                (value) {
                  setState(() {
                    _notificationSettings[entry.key] = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Email Notifications'),
            _buildEmailSettingsCard(),
            const SizedBox(height: 24),
            _buildSectionHeader('SMS Notifications'),
            _buildSMSSettingsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.notifications,
                    color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Notification Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Manage how you receive notifications about your account activity, security alerts, and updates.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildNotificationSwitch(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: SwitchListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
        secondary: Icon(
          _getNotificationIcon(title),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String title) {
    switch (title) {
      case 'Transaction Notifications':
        return Icons.payments;
      case 'Security Alerts':
        return Icons.security;
      case 'Account Updates':
        return Icons.account_circle;
      case 'Promotional Messages':
        return Icons.local_offer;
      case 'Market Updates':
        return Icons.trending_up;
      default:
        return Icons.notifications;
    }
  }

  Widget _buildEmailSettingsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.email, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'Email Preferences',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildEmailSettingItem(
              'Transaction Receipts',
              'Receive email receipts for all transactions',
            ),
            _buildEmailSettingItem(
              'Security Updates',
              'Get notified about security-related changes',
            ),
            _buildEmailSettingItem(
              'Account Statements',
              'Receive monthly account statements',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailSettingItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: true,
            onChanged: (value) {
              // TODO: Implement email setting toggle
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSMSSettingsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.sms, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                const Text(
                  'SMS Preferences',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSMSSettingItem(
              'Transaction Alerts',
              'Receive SMS for all transactions',
            ),
            _buildSMSSettingItem(
              'Security Codes',
              'Get security codes via SMS',
            ),
            _buildSMSSettingItem(
              'Account Updates',
              'Receive important account updates',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSMSSettingItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: true,
            onChanged: (value) {
              // TODO: Implement SMS setting toggle
            },
          ),
        ],
      ),
    );
  }
}
