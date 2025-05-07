import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Last Updated
          Center(
            child: Text(
              'Last Updated: March 15, 2024',
              style: theme.textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 24),

          // Introduction
          _buildSection(
            context,
            title: 'Introduction',
            content:
                'Welcome to Nyasa-Send. By using our service, you agree to these terms. Please read them carefully. Nyasa-Send is a digital money transfer platform that enables you to send and receive money between different banks and mobile money accounts in Malawi.',
          ),

          // Acceptance of Terms
          _buildSection(
            context,
            title: 'Acceptance of Terms',
            content:
                'By accessing or using Nyasa-Send, you agree to be bound by these Terms of Service and all applicable laws and regulations. If you do not agree with any of these terms, you are prohibited from using or accessing this service.',
          ),

          // Account Registration
          _buildSection(
            context,
            title: 'Account Registration',
            content:
                'To use Nyasa-Send, you must register for an account. You agree to provide accurate, current, and complete information during registration and to update such information to keep it accurate, current, and complete. You are responsible for maintaining the confidentiality of your account credentials.',
          ),

          // Financial Services
          _buildSection(
            context,
            title: 'Financial Services',
            content:
                'Nyasa-Send provides money transfer services between different banks and mobile money accounts. You acknowledge that:\n\n'
                '• All transfers are subject to applicable fees and charges\n'
                '• Transfer times may vary depending on the receiving institution\n'
                '• We reserve the right to limit transfer amounts based on risk assessment\n'
                '• You are responsible for ensuring the accuracy of recipient details\n'
                '• We may require additional verification for certain transactions',
          ),

          // Fees and Charges
          _buildSection(
            context,
            title: 'Fees and Charges',
            content:
                'You agree to pay all applicable fees and charges for using Nyasa-Send services. Fees may vary based on:\n\n'
                '• The type of transfer\n'
                '• The amount being transferred\n'
                '• The receiving institution\n'
                '• The transfer speed selected\n\n'
                'All fees will be clearly displayed before you confirm any transaction.',
          ),

          // Security
          _buildSection(
            context,
            title: 'Security',
            content:
                'You are responsible for maintaining the security of your account and for all activities that occur under your account. You must:\n\n'
                '• Keep your login credentials secure\n'
                '• Notify us immediately of any unauthorized access\n'
                '• Use appropriate security measures on your device\n'
                '• Not share your account with others',
          ),

          // Privacy
          _buildSection(
            context,
            title: 'Privacy',
            content:
                'Your use of Nyasa-Send is also governed by our Privacy Policy. We collect and process your personal and financial information in accordance with applicable data protection laws and our Privacy Policy.',
          ),

          // Transaction Limits
          _buildSection(
            context,
            title: 'Transaction Limits',
            content:
                'We may impose limits on the amount and frequency of transactions. These limits may be based on:\n\n'
                '• Your account verification level\n'
                '• Your transaction history\n'
                '• Regulatory requirements\n'
                '• Risk assessment factors',
          ),

          // Dispute Resolution
          _buildSection(
            context,
            title: 'Dispute Resolution',
            content:
                'If you have any issues with a transaction, you must notify us within 24 hours. We will investigate and attempt to resolve the issue in accordance with our dispute resolution procedures and applicable laws.',
          ),

          // Contact Information
          _buildSection(
            context,
            title: 'Contact Information',
            content:
                'If you have any questions about these Terms, please contact us at:\n\n'
                'Email: support@nyasa-send.com\n'
                'Phone: +265 123 456 789\n'
                'Address: P.O. Box 123, Lilongwe, Malawi',
          ),

          const SizedBox(height: 32),
          // Accept Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('I Accept'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
