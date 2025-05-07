import 'package:flutter/material.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _twoFactorEnabled = false;
  bool _biometricEnabled = true;
  bool _transactionNotifications = true;
  bool _saveTransactionHistory = true;
  String _sessionTimeout = '5 minutes';
  final List<LoginSession> _activeSessions = [
    LoginSession(
      device: 'iPhone 13',
      location: 'Lilongwe, Malawi',
      lastActive: '2 minutes ago',
      isCurrent: true,
    ),
    LoginSession(
      device: 'MacBook Pro',
      location: 'Blantyre, Malawi',
      lastActive: '1 hour ago',
      isCurrent: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Authentication
          _buildSectionHeader(context, 'Authentication'),
          _buildSettingTile(
            context,
            title: 'Two-Factor Authentication',
            subtitle: 'Add an extra layer of security to your account',
            trailing: Switch(
              value: _twoFactorEnabled,
              onChanged: (value) {
                setState(() {
                  _twoFactorEnabled = value;
                });
                if (value) {
                  _showTwoFactorSetupDialog(context);
                }
              },
            ),
          ),
          _buildSettingTile(
            context,
            title: 'Biometric Authentication',
            subtitle: 'Use fingerprint or face ID to log in',
            trailing: Switch(
              value: _biometricEnabled,
              onChanged: (value) {
                setState(() {
                  _biometricEnabled = value;
                });
              },
            ),
          ),
          const Divider(),

          // Transaction Security
          _buildSectionHeader(context, 'Transaction Security'),
          _buildSettingTile(
            context,
            title: 'Transaction Notifications',
            subtitle: 'Get notified for all money transfers',
            trailing: Switch(
              value: _transactionNotifications,
              onChanged: (value) {
                setState(() {
                  _transactionNotifications = value;
                });
              },
            ),
          ),
          _buildSettingTile(
            context,
            title: 'Save Transaction History',
            subtitle: 'Keep track of your money transfers',
            trailing: Switch(
              value: _saveTransactionHistory,
              onChanged: (value) {
                setState(() {
                  _saveTransactionHistory = value;
                });
              },
            ),
          ),
          _buildSettingTile(
            context,
            title: 'Session Timeout',
            subtitle: _sessionTimeout,
            onTap: () {
              _showSessionTimeoutDialog(context);
            },
          ),
          const Divider(),

          // Active Sessions
          _buildSectionHeader(context, 'Active Sessions'),
          ..._activeSessions
              .map((session) => _buildSessionTile(context, session)),
          const Divider(),

          // PIN & Password
          // _buildSectionHeader(context, 'PIN & Password'),
          // _buildSettingTile(
          //   context,
          //   title: 'Change Transaction PIN',
          //   subtitle: 'Update your 4-digit PIN',
          //   onTap: () {
          //     Navigator.pushNamed(context, '/change-pin');
          //   },
          // ),
          // _buildSettingTile(
          //   context,
          //   title: 'Change Password',
          //   subtitle: 'Update your account password',
          //   onTap: () {
          //     Navigator.pushNamed(context, '/change-password');
          //   },
          // ),
          // const Divider(),

          // // Transaction Limits
          // _buildSectionHeader(context, 'Transaction Limits'),
          // _buildSettingTile(
          //   context,
          //   title: 'Daily Transfer Limit',
          //   subtitle: 'Set maximum daily transfer amount',
          //   onTap: () {
          //     Navigator.pushNamed(context, '/transfer-limits');
          //   },
          // ),
          // _buildSettingTile(
          //   context,
          //   title: 'Single Transfer Limit',
          //   subtitle: 'Set maximum single transfer amount',
          //   onTap: () {
          //     Navigator.pushNamed(context, '/transfer-limits');
          //   },
          // ),
          //const Divider(),

          // Security Log
          _buildSectionHeader(context, 'Security Log'),
          _buildSettingTile(
            context,
            title: 'View Security Log',
            subtitle: 'Check your account activity',
            onTap: () {
              Navigator.pushNamed(context, '/security-log');
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
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildSessionTile(BuildContext context, LoginSession session) {
    return ListTile(
      leading: Icon(
        session.isCurrent ? Icons.phone_android : Icons.computer,
        color: session.isCurrent ? Theme.of(context).primaryColor : null,
      ),
      title: Text(session.device),
      subtitle: Text('${session.location} • ${session.lastActive}'),
      trailing: session.isCurrent
          ? const Chip(
              label: Text('Current'),
              backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.white),
            )
          : TextButton(
              onPressed: () {
                _showLogoutDialog(context, session);
              },
              child: const Text('Logout'),
            ),
    );
  }

  void _showTwoFactorSetupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Up Two-Factor Authentication'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose your preferred method for two-factor authentication:',
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('SMS'),
                subtitle: const Text('Receive codes via text message'),
                onTap: () {
                  // TODO: Implement SMS setup
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: const Text('Receive codes via email'),
                onTap: () {
                  // TODO: Implement email setup
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text('Authenticator App'),
                subtitle: const Text('Use an authenticator app'),
                onTap: () {
                  // TODO: Implement authenticator app setup
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _twoFactorEnabled = false;
                });
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showSessionTimeoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Session Timeout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTimeoutOption(context, '5 minutes'),
              _buildTimeoutOption(context, '10 minutes'),
              _buildTimeoutOption(context, '15 minutes'),
              _buildTimeoutOption(context, '30 minutes'),
              _buildTimeoutOption(context, '1 hour'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeoutOption(BuildContext context, String duration) {
    return ListTile(
      title: Text(duration),
      trailing: _sessionTimeout == duration
          ? const Icon(Icons.check, color: Colors.green)
          : null,
      onTap: () {
        setState(() {
          _sessionTimeout = duration;
        });
        Navigator.pop(context);
      },
    );
  }

  void _showLogoutDialog(BuildContext context, LoginSession session) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout Session'),
          content: Text(
            'Are you sure you want to logout from ${session.device}?',
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
                setState(() {
                  _activeSessions.remove(session);
                });
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

class LoginSession {
  final String device;
  final String location;
  final String lastActive;
  final bool isCurrent;

  LoginSession({
    required this.device,
    required this.location,
    required this.lastActive,
    required this.isCurrent,
  });
}
