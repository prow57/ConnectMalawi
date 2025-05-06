import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/theme_constants.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_logo.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              const AppLogo(size: 150),
              const SizedBox(height: ThemeConstants.spacingXL),
              Text(
                'Welcome to ${AppConstants.appName}',
                style: ThemeConstants.heading1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingM),
              Text(
                'Send and receive money instantly with low fees and multi-bank support',
                style: ThemeConstants.body1.copyWith(
                  color: ThemeConstants.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
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
}
