import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/theme_constants.dart';
import '../../utilities/formatters.dart';
import '../../common/widgets/app_button.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nyasa Send'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.pushNamed(context, AppConstants.routeNotifications);
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: ThemeConstants.errorColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ThemeConstants.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Tiles
            Text(
              'My Accounts',
              style: ThemeConstants.heading3,
            ),
            const SizedBox(height: ThemeConstants.spacingM),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    margin:
                        const EdgeInsets.only(right: ThemeConstants.spacingM),
                    padding: const EdgeInsets.all(ThemeConstants.spacingM),
                    decoration: BoxDecoration(
                      color: ThemeConstants.surfaceColor,
                      borderRadius: BorderRadius.circular(
                        ThemeConstants.borderRadiusM,
                      ),
                      boxShadow: ThemeConstants.cardShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account ${index + 1}',
                          style: ThemeConstants.body1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: ThemeConstants.spacingXS),
                        Text(
                          Formatters.maskAccountNumber('1234567890'),
                          style: ThemeConstants.body2,
                        ),
                        const Spacer(),
                        Text(
                          Formatters.formatCurrency(1000.00),
                          style: ThemeConstants.heading3,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: ThemeConstants.spacingXL),
            // Quick Actions
            Text(
              'Quick Actions',
              style: ThemeConstants.heading3,
            ),
            const SizedBox(height: ThemeConstants.spacingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickAction(
                  context,
                  icon: Icons.send,
                  label: 'Send Money',
                  onTap: () {
                    Navigator.pushNamed(context, AppConstants.routeSendMoney);
                  },
                ),
                _buildQuickAction(
                  context,
                  icon: Icons.request_quote,
                  label: 'Request Money',
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppConstants.routeRequestMoney);
                  },
                ),
                _buildQuickAction(
                  context,
                  icon: Icons.add_business,
                  label: 'Add Bank',
                  onTap: () {
                    Navigator.pushNamed(context, AppConstants.routeAddBank);
                  },
                ),
              ],
            ),
            const SizedBox(height: ThemeConstants.spacingXL),
            // Recent Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: ThemeConstants.heading3,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, AppConstants.routeTransactions);
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: ThemeConstants.spacingM),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.only(bottom: ThemeConstants.spacingM),
                  padding: const EdgeInsets.all(ThemeConstants.spacingM),
                  decoration: BoxDecoration(
                    color: ThemeConstants.surfaceColor,
                    borderRadius: BorderRadius.circular(
                      ThemeConstants.borderRadiusM,
                    ),
                    boxShadow: ThemeConstants.cardShadow,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(ThemeConstants.spacingS),
                        decoration: BoxDecoration(
                          color: ThemeConstants.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_upward,
                          color: ThemeConstants.primaryColor,
                        ),
                      ),
                      const SizedBox(width: ThemeConstants.spacingM),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: ThemeConstants.body1.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Today, 10:30 AM',
                              style: ThemeConstants.body2,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        Formatters.formatCurrency(500.00),
                        style: ThemeConstants.body1.copyWith(
                          color: ThemeConstants.successColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(ThemeConstants.spacingM),
            decoration: BoxDecoration(
              color: ThemeConstants.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: ThemeConstants.primaryColor,
              size: 32,
            ),
          ),
          const SizedBox(height: ThemeConstants.spacingS),
          Text(
            label,
            style: ThemeConstants.body2,
          ),
        ],
      ),
    );
  }
}
