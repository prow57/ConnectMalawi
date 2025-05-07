import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _profileVisibility = true;
  bool _showOnlineStatus = true;
  bool _showLastSeen = true;
  bool _showReadReceipts = true;
  bool _allowTagging = true;
  bool _showActivityStatus = true;
  String _profileViewing = 'Everyone';
  String _messageRequests = 'Everyone';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Privacy
          _buildSectionHeader(context, 'Profile Privacy'),
          _buildSettingTile(
            context,
            title: 'Profile Visibility',
            subtitle: 'Control who can see your profile',
            trailing: Switch(
              value: _profileVisibility,
              onChanged: (value) {
                setState(() {
                  _profileVisibility = value;
                });
              },
            ),
          ),
          _buildSettingTile(
            context,
            title: 'Who can view your profile',
            subtitle: _profileViewing,
            onTap: () {
              _showProfileViewingDialog(context);
            },
          ),
          const Divider(),

          // Activity Status
          _buildSectionHeader(context, 'Activity Status'),
          _buildSettingTile(
            context,
            title: 'Show Online Status',
            subtitle: 'Let others see when you\'re active',
            trailing: Switch(
              value: _showOnlineStatus,
              onChanged: (value) {
                setState(() {
                  _showOnlineStatus = value;
                });
              },
            ),
          ),
          _buildSettingTile(
            context,
            title: 'Show Last Seen',
            subtitle: 'Let others see when you were last active',
            trailing: Switch(
              value: _showLastSeen,
              onChanged: (value) {
                setState(() {
                  _showLastSeen = value;
                });
              },
            ),
          ),
          _buildSettingTile(
            context,
            title: 'Show Activity Status',
            subtitle: 'Let others see what you\'re doing',
            trailing: Switch(
              value: _showActivityStatus,
              onChanged: (value) {
                setState(() {
                  _showActivityStatus = value;
                });
              },
            ),
          ),
          const Divider(),

          // Messaging Privacy
          _buildSectionHeader(context, 'Messaging Privacy'),
          _buildSettingTile(
            context,
            title: 'Message Requests',
            subtitle: 'Control who can send you messages',
            onTap: () {
              _showMessageRequestsDialog(context);
            },
          ),
          _buildSettingTile(
            context,
            title: 'Read Receipts',
            subtitle: 'Let others see when you\'ve read their messages',
            trailing: Switch(
              value: _showReadReceipts,
              onChanged: (value) {
                setState(() {
                  _showReadReceipts = value;
                });
              },
            ),
          ),
          const Divider(),

          // Content Privacy
          _buildSectionHeader(context, 'Content Privacy'),
          _buildSettingTile(
            context,
            title: 'Allow Tagging',
            subtitle: 'Let others tag you in posts and comments',
            trailing: Switch(
              value: _allowTagging,
              onChanged: (value) {
                setState(() {
                  _allowTagging = value;
                });
              },
            ),
          ),
          const Divider(),

          // Data & Privacy
          _buildSectionHeader(context, 'Data & Privacy'),
          _buildSettingTile(
            context,
            title: 'Download Your Data',
            subtitle: 'Get a copy of your data',
            onTap: () {
              // TODO: Implement data download
            },
          ),
          _buildSettingTile(
            context,
            title: 'Delete Account',
            subtitle: 'Permanently delete your account and data',
            textColor: Colors.red,
            onTap: () {
              _showDeleteAccountDialog(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      subtitle: Text(subtitle),
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _showProfileViewingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Who can view your profile?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPrivacyOption(
                context,
                'Everyone',
                'Anyone can view your profile',
                _profileViewing == 'Everyone',
                () {
                  setState(() {
                    _profileViewing = 'Everyone';
                  });
                  Navigator.pop(context);
                },
              ),
              _buildPrivacyOption(
                context,
                'Connections',
                'Only your connections can view your profile',
                _profileViewing == 'Connections',
                () {
                  setState(() {
                    _profileViewing = 'Connections';
                  });
                  Navigator.pop(context);
                },
              ),
              _buildPrivacyOption(
                context,
                'Custom',
                'Choose who can view your profile',
                _profileViewing == 'Custom',
                () {
                  setState(() {
                    _profileViewing = 'Custom';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMessageRequestsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Who can send you messages?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPrivacyOption(
                context,
                'Everyone',
                'Anyone can send you messages',
                _messageRequests == 'Everyone',
                () {
                  setState(() {
                    _messageRequests = 'Everyone';
                  });
                  Navigator.pop(context);
                },
              ),
              _buildPrivacyOption(
                context,
                'Connections',
                'Only your connections can send you messages',
                _messageRequests == 'Connections',
                () {
                  setState(() {
                    _messageRequests = 'Connections';
                  });
                  Navigator.pop(context);
                },
              ),
              _buildPrivacyOption(
                context,
                'None',
                'No one can send you messages',
                _messageRequests == 'None',
                () {
                  setState(() {
                    _messageRequests = 'None';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPrivacyOption(
    BuildContext context,
    String title,
    String subtitle,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: isSelected
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: onTap,
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement account deletion
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
} 