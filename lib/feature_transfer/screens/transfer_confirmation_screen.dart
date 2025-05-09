import 'package:flutter/material.dart';
import 'package:nyasa_send/feature_transfer/widgets/pin_input_dialog.dart';

class TransferConfirmationScreen extends StatelessWidget {
  final String recipientName;
  final String recipientAccount;
  final double amount;
  final String note;
  final String sourceAccount;
  final String transferType;

  const TransferConfirmationScreen({
    super.key,
    required this.recipientName,
    required this.recipientAccount,
    required this.amount,
    required this.note,
    required this.sourceAccount,
    required this.transferType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fee = _calculateFee(amount, transferType);
    final total = amount + fee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Transfer'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount Card
            Card(
              elevation: 4,
              shadowColor: theme.primaryColor.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'Amount to Send',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'MWK ${amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Transfer Details Card
            Card(
              elevation: 2,
              shadowColor: Colors.grey.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: theme.primaryColor),
                        const SizedBox(width: 8),
                        const Text(
                          'Transfer Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildDetailRow(
                      'Recipient',
                      recipientName,
                      icon: Icons.person_outline,
                    ),
                    _buildDetailRow(
                      'Account',
                      recipientAccount,
                      icon: Icons.account_balance_wallet_outlined,
                    ),
                    _buildDetailRow(
                      'From Account',
                      sourceAccount,
                      icon: Icons.account_balance_outlined,
                    ),
                    _buildDetailRow(
                      'Transfer Type',
                      transferType,
                      icon: Icons.speed_outlined,
                    ),
                    if (note.isNotEmpty)
                      _buildDetailRow(
                        'Note',
                        note,
                        icon: Icons.note_outlined,
                      ),
                    const Divider(height: 32),
                    _buildDetailRow(
                      'Fee',
                      'MWK ${fee.toStringAsFixed(2)}',
                      icon: Icons.payments_outlined,
                    ),
                    _buildDetailRow(
                      'Total',
                      'MWK ${total.toStringAsFixed(2)}',
                      isTotal: true,
                      icon: Icons.account_balance_outlined,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showPinDialog(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Confirm Transfer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isTotal = false, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 20,
              color: isTotal ? Colors.black : Colors.grey[600],
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : null,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

  double _calculateFee(double amount, String transferType) {
    switch (transferType) {
      case 'Instant':
        return amount * 0.02; // 2% fee
      case 'Standard (1-2 hours)':
        return amount * 0.015; // 1.5% fee
      case 'Economy (24 hours)':
        return amount * 0.01; // 1% fee
      default:
        return 0;
    }
  }

  void _showPinDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PinInputDialog(
        onPinEntered: (pin) {
          Navigator.pop(context); // Close PIN dialog
          _processTransfer(context);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  void _processTransfer(BuildContext context) {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate transfer processing
    Future.delayed(const Duration(seconds: 2), () {
      // Close loading indicator
      Navigator.pop(context);

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              const SizedBox(width: 8),
              const Text('Transfer Successful'),
            ],
          ),
          content: const Text('Your money has been sent successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                // Close dialog and navigate back to dashboard
                Navigator.pop(context);
                Navigator.pop(context, true); // Return true to indicate success
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}
 