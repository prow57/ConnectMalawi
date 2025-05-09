import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/theme_constants.dart';
import '../../common/widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ThemeConstants.primaryColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.account_balance_wallet,
        size: 80,
        color: ThemeConstants.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ThemeConstants.spacingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildLogo(),
              const SizedBox(height: ThemeConstants.spacingXL),
              Text(
                'Welcome to ${AppConstants.appName}',
                style: ThemeConstants.heading1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingM),
              Text(
                'Your trusted partner for seamless money transfers. Send, receive, and manage your money with ease.',
                style: ThemeConstants.body1.copyWith(
                  color: ThemeConstants.textSecondaryColor,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingL),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFeatureChip(Icons.swap_horiz, 'Fast Transfers'),
                  const SizedBox(width: ThemeConstants.spacingM),
                  _buildFeatureChip(Icons.security, 'Secure'),
                  const SizedBox(width: ThemeConstants.spacingM),
                  _buildFeatureChip(Icons.support_agent, '24/7 Support'),
                ],
              ),
              const Spacer(),
              AppButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.pushNamed(context, AppConstants.routeOnboarding);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConstants.spacingM,
        vertical: ThemeConstants.spacingS,
      ),
      decoration: BoxDecoration(
        color: ThemeConstants.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: ThemeConstants.primaryColor,
          ),
          const SizedBox(width: ThemeConstants.spacingXS),
          Text(
            label,
            style: TextStyle(
              color: ThemeConstants.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
