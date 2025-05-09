import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/theme_constants.dart';
import '../../common/widgets/app_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'Seamless Money Transfers',
      description:
          'Send and receive money instantly across multiple banks with our secure and fast payment system',
      icon: Icons.swap_horiz,
    ),
    OnboardingItem(
      title: 'Bank Anywhere, Anytime',
      description:
          'Access your money and make transactions 24/7 with our user-friendly mobile banking platform',
      icon: Icons.phone_android,
    ),
    OnboardingItem(
      title: 'Secure & Protected',
      description:
          'Your security is our priority. Enjoy peace of mind with our advanced encryption and fraud protection',
      icon: Icons.shield,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeConstants.primaryColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.account_balance_wallet,
        size: 40,
        color: ThemeConstants.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(ThemeConstants.spacingL),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLogo(),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppConstants.routeLogin);
                    },
                    child: const Text('Skip'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Padding(
                    padding: const EdgeInsets.all(ThemeConstants.spacingL),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: ThemeConstants.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item.icon,
                            size: 80,
                            color: ThemeConstants.primaryColor,
                          ),
                        ),
                        const SizedBox(height: ThemeConstants.spacingXL),
                        Text(
                          item.title,
                          style: ThemeConstants.heading2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: ThemeConstants.spacingM),
                        Text(
                          item.description,
                          style: ThemeConstants.body1.copyWith(
                            color: ThemeConstants.textSecondaryColor,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(
                    horizontal: ThemeConstants.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? ThemeConstants.primaryColor
                        : ThemeConstants.textSecondaryColor.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: ThemeConstants.spacingL),
            Padding(
              padding: const EdgeInsets.all(ThemeConstants.spacingL),
              child: AppButton(
                text:
                    _currentPage == _items.length - 1 ? 'Get Started' : 'Next',
                onPressed: () {
                  if (_currentPage == _items.length - 1) {
                    Navigator.pushReplacementNamed(
                      context,
                      AppConstants.routeLogin,
                    );
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}
