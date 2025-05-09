import 'package:flutter/material.dart';
import '../models/transfer_model.dart';
import '../functions/transfer_functions.dart';
import '../../constants/theme_constants.dart';

class TransferItem extends StatelessWidget {
  final TransferModel transfer;
  final VoidCallback? onTap;

  const TransferItem({
    super.key,
    required this.transfer,
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
                TransferFunctions.getTransferStatusIcon(transfer.status),
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
                    transfer.recipientName,
                    style: ThemeConstants.body1.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    TransferFunctions.formatPhoneNumber(
                        transfer.recipientPhone),
                    style: ThemeConstants.body2.copyWith(
                      color: ThemeConstants.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transfer.description,
                    style: ThemeConstants.caption.copyWith(
                      color: ThemeConstants.textSecondaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '-${TransferFunctions.formatCurrency(transfer.amount)}',
                  style: ThemeConstants.body1.copyWith(
                    color: Colors.red,
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
                      TransferFunctions.getTransferStatusColor(
                        transfer.status,
                      ).replaceAll('#', '0xFF'),
                    )).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    transfer.status.toUpperCase(),
                    style: ThemeConstants.caption.copyWith(
                      color: Color(int.parse(
                        TransferFunctions.getTransferStatusColor(
                          transfer.status,
                        ).replaceAll('#', '0xFF'),
                      )),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  TransferFunctions.getTimeAgo(transfer.createdAt),
                  style: ThemeConstants.caption.copyWith(
                    color: ThemeConstants.textSecondaryColor,
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
