import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/theme_constants.dart';
import '../../utilities/formatters.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _transactions = [
    {
      'type': 'send',
      'amount': 500.00,
      'recipient': 'John Doe',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'status': 'completed',
    },
    {
      'type': 'request',
      'amount': 1000.00,
      'recipient': 'Jane Smith',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'status': 'pending',
    },
    {
      'type': 'send',
      'amount': 750.00,
      'recipient': 'Mike Johnson',
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'status': 'completed',
    },
    {
      'type': 'request',
      'amount': 250.00,
      'recipient': 'Sarah Wilson',
      'date': DateTime.now().subtract(const Duration(days: 4)),
      'status': 'completed',
    },
    {
      'type': 'send',
      'amount': 1500.00,
      'recipient': 'David Brown',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'status': 'completed',
    },
  ];

  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('All Transactions'),
              ),
              const PopupMenuItem(
                value: 'send',
                child: Text('Sent Money'),
              ),
              const PopupMenuItem(
                value: 'request',
                child: Text('Requested Money'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(ThemeConstants.spacingL),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(ThemeConstants.spacingM),
                    decoration: BoxDecoration(
                      color: ThemeConstants.surfaceColor,
                      borderRadius: BorderRadius.circular(
                        ThemeConstants.borderRadiusM,
                      ),
                      boxShadow: ThemeConstants.cardShadow,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Total Sent',
                          style: ThemeConstants.body2,
                        ),
                        const SizedBox(height: ThemeConstants.spacingXS),
                        Text(
                          Formatters.formatCurrency(2750.00),
                          style: ThemeConstants.heading3.copyWith(
                            color: ThemeConstants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: ThemeConstants.spacingM),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(ThemeConstants.spacingM),
                    decoration: BoxDecoration(
                      color: ThemeConstants.surfaceColor,
                      borderRadius: BorderRadius.circular(
                        ThemeConstants.borderRadiusM,
                      ),
                      boxShadow: ThemeConstants.cardShadow,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Total Received',
                          style: ThemeConstants.body2,
                        ),
                        const SizedBox(height: ThemeConstants.spacingXS),
                        Text(
                          Formatters.formatCurrency(1250.00),
                          style: ThemeConstants.heading3.copyWith(
                            color: ThemeConstants.successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: ThemeConstants.spacingL,
              ),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                if (_selectedFilter != 'all' &&
                    transaction['type'] != _selectedFilter) {
                  return const SizedBox.shrink();
                }
                return Container(
                  margin:
                      const EdgeInsets.only(bottom: ThemeConstants.spacingM),
                  decoration: BoxDecoration(
                    color: ThemeConstants.surfaceColor,
                    borderRadius: BorderRadius.circular(
                      ThemeConstants.borderRadiusM,
                    ),
                    boxShadow: ThemeConstants.cardShadow,
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(ThemeConstants.spacingS),
                      decoration: BoxDecoration(
                        color: transaction['type'] == 'send'
                            ? ThemeConstants.primaryColor.withOpacity(0.1)
                            : ThemeConstants.successColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        transaction['type'] == 'send'
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: transaction['type'] == 'send'
                            ? ThemeConstants.primaryColor
                            : ThemeConstants.successColor,
                      ),
                    ),
                    title: Text(
                      transaction['recipient'] as String,
                      style: ThemeConstants.body1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      Formatters.formatDateTime(
                          transaction['date'] as DateTime),
                      style: ThemeConstants.body2,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          Formatters.formatCurrency(
                            transaction['amount'] as double,
                          ),
                          style: ThemeConstants.body1.copyWith(
                            color: transaction['type'] == 'send'
                                ? ThemeConstants.primaryColor
                                : ThemeConstants.successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          transaction['status'] as String,
                          style: ThemeConstants.body2.copyWith(
                            color: transaction['status'] == 'pending'
                                ? ThemeConstants.warningColor
                                : ThemeConstants.successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
