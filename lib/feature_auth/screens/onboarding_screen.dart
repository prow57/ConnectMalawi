import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/theme_constants.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_logo.dart';

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
      title: 'Low Fees',
      description: 'Send money with minimal transaction fees across multiple banks',
      icon: Icons.attach_money,
    ),
    OnboardingItem(
      title: 'Multi-Bank Support',
      description: 'Connect and transfer money between different bank accounts',
      icon: Icons.account_balance,
    ),
    OnboardingItem(
      title: 'Secure Transactions',
      description: 'Your money is safe with our advanced security features',
      icon: Icons.security,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppConstants.routeLogin);
                },
                child: const Text('Skip'),
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
                        Icon(
                          item.icon,
                          size: 120,
                          color: ThemeConstants.primaryColor,
                        ),
                        const SizedBox(height: ThemeConstants.spacingXL),
                        Text(
                          item.title,
                          style: ThemeConstants.heading2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: ThemeConstants.spacingM),
                        Text(
                          item.description,
                          style: ThemeConstants.body1.copyWith(
                            color: ThemeConstants.textSecondaryColor,
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
                text: _currentPage == _items.length - 1 ? 'Get Started' : 'Next',
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
