import 'package:flutter/material.dart';
import 'package:nyasa_send/feature_settings/screens/transfer_limits_screen.dart';
import 'package:nyasa_send/feature_settings/screens/security_log_screen.dart';
import 'package:nyasa_send/feature_settings/screens/help_center_screen.dart';
import 'package:nyasa_send/feature_settings/screens/about_screen.dart';
import 'package:nyasa_send/constants/route_constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Account Settings
          _buildSectionHeader(context, 'Account'),
          _buildSettingsItem(
            context,
            icon: Icons.person,
            title: 'Profile',
            subtitle: 'Update your personal information',
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.profile);
            },
          ),
          _buildSettingsItem(
            context,
            icon: Icons.account_balance,
            title: 'Bank Accounts',
            subtitle: 'Manage your linked bank accounts',
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.accounts);
            },
          ),
          _buildSettingsItem(
            context,
            icon: Icons.phone_android,
            title: 'Mobile Money',
            subtitle: 'Manage your mobile money accounts',
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.mobileSetup);
            },
          ),
          const Divider(),

          // Security Settings
          _buildSectionHeader(context, 'Security'),
          _buildSettingsItem(
            context,
            icon: Icons.lock,
            title: 'Change PIN',
            subtitle: 'Update your transaction PIN',
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.changePin);
            },
          ),
          _buildSettingsItem(
            context,
            icon: Icons.fingerprint,
            title: 'Biometric Authentication',
            subtitle: 'Enable fingerprint or face ID',
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.securitySettings);
            },
          ),
          _buildSettingsItem(
            context,
            icon: Icons.history,
            title: 'Security Log',
            subtitle: 'View your account activity',
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.securityLog);
            },
          ),
          const Divider(),

          // Transfer Settings
          _buildSectionHeader(context, 'Transfers'),
          _buildSettingsItem(
            context,
            icon: Icons.account_balance_wallet,
            title: 'Transfer Limits',
            subtitle: 'Set your transaction limits',
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.transferLimits);
            },
          ),
          _buildSettingsItem(
            context,
            icon: Icons.favorite,
            title: 'Beneficiaries',
            subtitle: 'Manage your saved beneficiaries',
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.recipients);
            },
          ),
          const Divider(),

          // Preferences
          _buildSectionHeader(context, 'Preferences'),
          _buildSettingsItem(
            context,
            icon: Icons.language,
            title: 'Language',
            subtitle: 'English',
            onTap: () {
              // TODO: Implement language settings
            },
          ),
          _buildSettingsItem(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Manage your notification preferences',
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.notifications);
            },
          ),
          _buildSettingsItem(
            context,
            icon: Icons.dark_mode,
            title: 'Appearance',
            subtitle: 'Light',
            onTap: () {
              // TODO: Implement appearance settings
            },
          ),
          const Divider(),

          // Support & About
          _buildSectionHeader(context, 'Support & About'),
          _buildSettingsItem(
            context,
            icon: Icons.help,
            title: 'Help Center',
            subtitle: 'FAQs and support',
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.help);
            },
          ),
          _buildSettingsItem(
            context,
            icon: Icons.info,
            title: 'About',
            subtitle: 'App information and legal details',
            onTap: () {
              Navigator.pushNamed(context, RouteConstants.about);
            },
          ),
          const SizedBox(height: 16),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement logout logic
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(
                              context, RouteConstants.welcome);
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
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

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
