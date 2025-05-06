import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/theme_constants.dart';
import '../../utilities/formatters.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banks = [
      {
        'name': 'Standard Bank',
        'code': 'SB',
        'color': Colors.blue,
      },
      {
        'name': 'National Bank',
        'code': 'NB',
        'color': Colors.green,
      },
      {
        'name': 'FMB',
        'code': 'FMB',
        'color': Colors.orange,
      },
      {
        'name': 'NBS Bank',
        'code': 'NBS',
        'color': Colors.red,
      },
      {
        'name': 'CDH Bank',
        'code': 'CDH',
        'color': Colors.purple,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Bank'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(ThemeConstants.spacingL),
        itemCount: banks.length,
        itemBuilder: (context, index) {
          final bank = banks[index];
          return Container(
            margin: const EdgeInsets.only(bottom: ThemeConstants.spacingM),
            decoration: BoxDecoration(
              color: ThemeConstants.surfaceColor,
              borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
              boxShadow: ThemeConstants.cardShadow,
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(ThemeConstants.spacingS),
                decoration: BoxDecoration(
                  color: bank['color'] as Color,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  bank['code'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                bank['name'] as String,
                style: ThemeConstants.body1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context, bank['name']);
              },
            ),
          );
        },
      ),
    );
  }
}
