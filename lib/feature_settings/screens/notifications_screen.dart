import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> _notificationTypes = [
    {
      'title': 'Push Notifications',
      'description': 'Receive notifications on your device',
      'icon': Icons.notifications,
      'key': 'push',
    },
    {
      'title': 'Email Notifications',
      'description': 'Receive notifications via email',
      'icon': Icons.email,
      'key': 'email',
    },
    {
      'title': 'SMS Notifications',
      'description': 'Receive notifications via SMS',
      'icon': Icons.sms,
      'key': 'sms',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.notifications_active,
                            color: Theme.of(context).primaryColor,
                          ),
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
                      const SizedBox(height: 8),
                      const Text(
                        'Manage how you receive notifications from the app.',
                        style: TextStyle(
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ..._notificationTypes
                    .map((type) => _buildNotificationTile(type)),
                const SizedBox(height: 16),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Notification Preferences',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPreferenceItem(
                        'Quiet Hours',
                        'Set specific hours when you don\'t want to receive notifications',
                        Icons.access_time,
                        onTap: () {
                          // TODO: Implement quiet hours settings
                        },
                      ),
                      const Divider(),
                      _buildPreferenceItem(
                        'Sound & Vibration',
                        'Customize notification sounds and vibration patterns',
                        Icons.volume_up,
                        onTap: () {
                          // TODO: Implement sound & vibration settings
                        },
                      ),
                      const Divider(),
                      _buildPreferenceItem(
                        'Priority Notifications',
                        'Choose which notifications are most important',
                        Icons.priority_high,
                        onTap: () {
                          // TODO: Implement priority notifications settings
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationTile(Map<String, dynamic> type) {
    final bool isEnabled = _getNotificationState(type['key']);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isEnabled
            ? Theme.of(context).primaryColor.withOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              isEnabled ? Theme.of(context).primaryColor : Colors.grey.shade300,
        ),
      ),
      child: SwitchListTile(
        title: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            fontWeight: isEnabled ? FontWeight.bold : FontWeight.normal,
            color: isEnabled ? Theme.of(context).primaryColor : Colors.black,
          ),
          child: Text(type['title']),
        ),
        subtitle: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: isEnabled
                ? Theme.of(context).primaryColor.withOpacity(0.7)
                : Colors.grey,
          ),
          child: Text(type['description']),
        ),
        secondary: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isEnabled
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            type['icon'],
            color: isEnabled ? Theme.of(context).primaryColor : Colors.grey,
          ),
        ),
        value: isEnabled,
        activeColor: Theme.of(context).primaryColor,
        onChanged: _isLoading
            ? null
            : (value) => _updateNotificationState(type['key'], value),
      ),
    );
  }

  Widget _buildPreferenceItem(String title, String subtitle, IconData icon,
      {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(width: 16),
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
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  bool _getNotificationState(String key) {
    switch (key) {
      case 'push':
        return _pushNotifications;
      case 'email':
        return _emailNotifications;
      case 'sms':
        return _smsNotifications;
      default:
        return false;
    }
  }

  Future<void> _updateNotificationState(String key, bool value) async {
    setState(() {
      _isLoading = true;
      switch (key) {
        case 'push':
          _pushNotifications = value;
          break;
        case 'email':
          _emailNotifications = value;
          break;
        case 'sms':
          _smsNotifications = value;
          break;
      }
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${key.toUpperCase()} notifications ${value ? 'enabled' : 'disabled'}'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      );
    }
  }
}
