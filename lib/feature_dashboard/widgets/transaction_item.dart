import 'package:flutter/material.dart';
import '../models/dashboard_model.dart';
import '../functions/dashboard_functions.dart';
import '../../constants/theme_constants.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;
  final VoidCallback? onTap;

  const TransactionItem({
    super.key,
    required this.transaction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(ThemeConstants.spacingM),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(ThemeConstants.spacingS),
              decoration: BoxDecoration(
                color: ThemeConstants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                DashboardFunctions.getTransactionTypeIcon(transaction.type),
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: ThemeConstants.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description,
                    style: ThemeConstants.body1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DashboardFunctions.getTimeAgo(transaction.date),
                    style: ThemeConstants.caption.copyWith(
                      color: ThemeConstants.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transaction.type == 'credit' ? '+' : '-'}${DashboardFunctions.formatCurrency(transaction.amount)}',
                  style: ThemeConstants.body1.copyWith(
                    color: transaction.type == 'credit'
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Color(int.parse(
                      DashboardFunctions.getTransactionStatusColor(
                        transaction.status,
                      ).replaceAll('#', '0xFF'),
                    )).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    transaction.status.toUpperCase(),
                    style: ThemeConstants.caption.copyWith(
                      color: Color(int.parse(
                        DashboardFunctions.getTransactionStatusColor(
                          transaction.status,
                        ).replaceAll('#', '0xFF'),
                      )),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
