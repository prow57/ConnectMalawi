import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final List<FAQ> _allFaqs = [
    FAQ(
      category: 'Money Transfers',
      question: 'How do I send money?',
      answer:
          'To send money, tap the "Send" button on the home screen, select a recipient, enter the amount, and confirm the transaction with your PIN.',
    ),
    FAQ(
      category: 'Money Transfers',
      question: 'What are the transfer fees?',
      answer:
          'Transfer fees vary based on the amount and type of transfer. Standard transfers have a 1% fee, while instant transfers have a 1.5% fee. All fees are clearly displayed before you confirm the transaction.',
    ),
    FAQ(
      category: 'Money Transfers',
      question: 'How long do transfers take?',
      answer:
          'Standard transfers typically complete within 1-2 business days. Instant transfers are usually completed within minutes. The exact time may vary depending on the receiving bank or mobile money provider.',
    ),
    FAQ(
      category: 'Accounts',
      question: 'How do I add a bank account?',
      answer:
          'Go to Settings > Bank Accounts > Add Account. Follow the steps to link your bank account securely. You\'ll need your bank account number and other details.',
    ),
    FAQ(
      category: 'Accounts',
      question: 'How do I add mobile money?',
      answer:
          'Go to Settings > Mobile Money > Add Account. Select your mobile money provider (Airtel Money, TNM Mpamba, etc.) and follow the verification process.',
    ),
    FAQ(
      category: 'Security',
      question: 'How do I change my PIN?',
      answer:
          'Navigate to Settings > Security > Change PIN. You\'ll need to enter your current PIN before setting a new one. Your new PIN must be 4-6 digits.',
    ),
    FAQ(
      category: 'Security',
      question: 'What if I forget my PIN?',
      answer:
          'If you forget your PIN, tap "Forgot PIN" on the PIN entry screen. You\'ll need to verify your identity through your registered phone number or email before setting a new PIN.',
    ),
    FAQ(
      category: 'Security',
      question: 'How do I enable biometric authentication?',
      answer:
          'Go to Settings > Security > Biometric Authentication. Follow the prompts to set up fingerprint or face ID authentication for your account.',
    ),
    FAQ(
      category: 'Fees & Limits',
      question: 'What are the transfer limits?',
      answer:
          'Transfer limits vary based on your account type and verification level. Basic accounts have lower limits, while fully verified accounts have higher limits. Check Settings > Transfer Limits for your specific limits.',
    ),
    FAQ(
      category: 'Fees & Limits',
      question: 'How do I increase my transfer limits?',
      answer:
          'To increase your limits, complete the full KYC verification process. Go to Settings > Verification > Complete KYC. You\'ll need to provide additional identification documents.',
    ),
    FAQ(
      category: 'Troubleshooting',
      question: 'What if my transfer fails?',
      answer:
          'If your transfer fails, check your internet connection and try again. If the issue persists, the money will be automatically refunded to your account within 24 hours. Contact support if you need immediate assistance.',
    ),
    FAQ(
      category: 'Troubleshooting',
      question: 'How do I report a problem?',
      answer:
          'You can report issues through the Help Center > Contact Support or by calling our customer service line. For urgent matters, please call our 24/7 support line.',
    ),
  ];

  List<FAQ> _filteredFaqs = [];
  bool _isSearching = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _filteredFaqs = _allFaqs;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _filterFAQs(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredFaqs = _allFaqs;
        _isSearching = false;
      } else {
        _filteredFaqs = _allFaqs
            .where((faq) =>
                faq.question.toLowerCase().contains(query.toLowerCase()) ||
                faq.answer.toLowerCase().contains(query.toLowerCase()) ||
                faq.category.toLowerCase().contains(query.toLowerCase()))
            .toList();
        _isSearching = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _animationController.reset();
              _animationController.forward();
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar with animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for help...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _isSearching
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _filterFAQs('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                  ),
                  onChanged: _filterFAQs,
                ),
              ),
            ),
          ),

          // Content with animation
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ListView(
                  children: [
                    // Quick Actions
                    _buildQuickActions(context),
                    const Divider(),

                    // FAQs Section
                    _buildSectionHeader(context, 'Frequently Asked Questions'),
                    ..._filteredFaqs.map((faq) => _buildFAQItem(
                          context,
                          question: faq.question,
                          answer: faq.answer,
                          category: faq.category,
                        )),
                    const Divider(),

                    // Contact Support
                    _buildSectionHeader(context, 'Contact Support'),
                    _buildContactItem(
                      context,
                      icon: Icons.phone,
                      title: 'Call Us',
                      subtitle: 'Available 24/7',
                      onTap: () => _launchUrl('tel:+265123456789'),
                    ),
                    _buildContactItem(
                      context,
                      icon: Icons.email,
                      title: 'Email Support',
                      subtitle: 'support@nyasasend.com',
                      onTap: () => _launchUrl('mailto:support@nyasasend.com'),
                    ),
                    _buildContactItem(
                      context,
                      icon: Icons.chat,
                      title: 'Live Chat',
                      subtitle: 'Chat with our support team',
                      onTap: () => _showLiveChat(context),
                    ),
                    const Divider(),

                    // Additional Resources
                    _buildSectionHeader(context, 'Additional Resources'),
                    _buildResourceItem(
                      context,
                      icon: Icons.book,
                      title: 'User Guide',
                      onTap: () => _showUserGuide(context),
                    ),
                    _buildResourceItem(
                      context,
                      icon: Icons.security,
                      title: 'Security Tips',
                      onTap: () => _showSecurityTips(context),
                    ),
                    _buildResourceItem(
                      context,
                      icon: Icons.privacy_tip,
                      title: 'Privacy Policy',
                      onTap: () => _showPrivacyPolicy(context),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  context,
                  icon: Icons.lock,
                  label: 'Reset PIN',
                  onTap: () {
                    Navigator.pushNamed(context, '/settings/change-pin');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionButton(
                  context,
                  icon: Icons.account_balance,
                  label: 'Add Account',
                  onTap: () {
                    Navigator.pushNamed(context, '/accounts/bank-setup');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionButton(
                  context,
                  icon: Icons.report_problem,
                  label: 'Report Issue',
                  onTap: () {
                    // TODO: Implement report issue
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Report issue coming soon!'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  context,
                  icon: Icons.account_balance_wallet,
                  label: 'Transfer Limits',
                  onTap: () {
                    Navigator.pushNamed(context, '/settings/transfer-limits');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionButton(
                  context,
                  icon: Icons.verified_user,
                  label: 'Verify Account',
                  onTap: () {
                    Navigator.pushNamed(context, '/settings/verify-account');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionButton(
                  context,
                  icon: Icons.notifications,
                  label: 'Notifications',
                  onTap: () {
                    Navigator.pushNamed(context, '/settings/notifications');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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

  Widget _buildFAQItem(
    BuildContext context, {
    required String question,
    required String answer,
    required String category,
  }) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        category,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 12,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                answer,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              if (category == 'Fees & Limits' &&
                  question.contains('transfer limits'))
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextButton.icon(
                    onPressed: () => _showTransferLimits(context),
                    icon: const Icon(Icons.info_outline),
                    label: const Text('View Current Limits'),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(
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

  Widget _buildResourceItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLiveChat(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Live Chat',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
            child: AlertDialog(
              title: const Text('Live Chat'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Our support team is ready to help you.'),
                  const SizedBox(height: 16),
                  _buildChatOption(
                    icon: Icons.chat,
                    title: 'Start New Chat',
                    subtitle: 'Chat with our support team',
                    onTap: () {
                      Navigator.pop(context);
                      _launchUrl('https://chat.nyasasend.com');
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildChatOption(
                    icon: Icons.history,
                    title: 'View Chat History',
                    subtitle: 'Access your previous conversations',
                    onTap: () {
                      Navigator.pop(context);
                      _launchUrl('https://chat.nyasasend.com/history');
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
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
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _showUserGuide(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'User Guide',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
            child: AlertDialog(
              title: const Text('User Guide'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGuideSection(
                      'Getting Started',
                      [
                        'Create your account',
                        'Verify your identity',
                        'Add your first account',
                      ],
                      Icons.rocket_launch,
                    ),
                    _buildGuideSection(
                      'Sending Money',
                      [
                        'Select a recipient',
                        'Enter amount',
                        'Add a note (optional)',
                        'Confirm with PIN',
                      ],
                      Icons.send,
                    ),
                    _buildGuideSection(
                      'Managing Accounts',
                      [
                        'Add bank accounts',
                        'Add mobile money',
                        'Set default accounts',
                      ],
                      Icons.account_balance,
                    ),
                    _buildGuideSection(
                      'Security Features',
                      [
                        'Set up biometric authentication',
                        'Enable transaction notifications',
                        'Review security settings',
                      ],
                      Icons.security,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _launchUrl('https://nyasasend.com/guide');
                  },
                  child: const Text('View Full Guide'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGuideSection(String title, List<String> items, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _showSecurityTips(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Security Tips',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
            child: AlertDialog(
              title: const Text('Security Tips'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSecurityTipCard(
                      'Keep your PIN secure',
                      'Never share your PIN with anyone, including family members or bank staff.',
                      Icons.lock,
                    ),
                    _buildSecurityTipCard(
                      'Enable biometric authentication',
                      'Use fingerprint or face ID for an extra layer of security.',
                      Icons.fingerprint,
                    ),
                    _buildSecurityTipCard(
                      'Monitor your account',
                      'Regularly check your transaction history for any unauthorized activity.',
                      Icons.history,
                    ),
                    _buildSecurityTipCard(
                      'Use secure networks',
                      'Avoid making transactions on public Wi-Fi networks.',
                      Icons.wifi_lock,
                    ),
                    _buildSecurityTipCard(
                      'Update your app',
                      'Always keep your app updated to the latest version for security patches.',
                      Icons.system_update,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _launchUrl('https://nyasasend.com/security');
                  },
                  child: const Text('Learn More'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSecurityTipCard(
      String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
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
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Privacy Policy',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
            child: AlertDialog(
              title: const Text('Privacy Policy'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your privacy is important to us. This policy explains how we collect, use, and protect your personal information.',
                    ),
                    const SizedBox(height: 16),
                    _buildPolicyCard(
                      'Information We Collect',
                      [
                        'Personal identification information',
                        'Financial information',
                        'Device information',
                        'Transaction history',
                      ],
                      Icons.collections,
                    ),
                    _buildPolicyCard(
                      'How We Use Your Information',
                      [
                        'Process your transactions',
                        'Verify your identity',
                        'Improve our services',
                        'Send you important updates',
                      ],
                      Icons.settings,
                    ),
                    _buildPolicyCard(
                      'Data Protection',
                      [
                        'Encryption of sensitive data',
                        'Secure servers',
                        'Regular security audits',
                        'Limited access to personal information',
                      ],
                      Icons.security,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _launchUrl('https://nyasasend.com/privacy');
                  },
                  child: const Text('View Full Policy'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPolicyCard(String title, List<String> items, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(left: 24, bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _showTransferLimits(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Transfer Limits',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
            child: AlertDialog(
              title: const Text('Transfer Limits'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLimitCard(
                      'Daily Limit',
                      'MK 500,000',
                      'Maximum amount you can send per day',
                      Icons.today,
                    ),
                    _buildLimitCard(
                      'Monthly Limit',
                      'MK 5,000,000',
                      'Maximum amount you can send per month',
                      Icons.calendar_month,
                    ),
                    _buildLimitCard(
                      'Single Transaction',
                      'MK 200,000',
                      'Maximum amount per transaction',
                      Icons.payments,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'To increase your limits, complete the full KYC verification process.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/settings/verify-account');
                  },
                  child: const Text('Verify Account'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLimitCard(
      String title, String limit, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
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
                  limit,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
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
        ],
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

class FAQ {
  final String category;
  final String question;
  final String answer;

  FAQ({
    required this.category,
    required this.question,
    required this.answer,
  });
}
