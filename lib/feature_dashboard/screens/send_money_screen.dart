import 'package:flutter/material.dart';
import '../../constants/theme_constants.dart';
import '../../utilities/formatters.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_text_field.dart';
import '../../constants/app_constants.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedRecipient = 'John Doe';
  String _selectedAccount = 'Account 1';

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ThemeConstants.spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipient Selection
              Text(
                'Recipient',
                style: ThemeConstants.heading3,
              ),
              const SizedBox(height: ThemeConstants.spacingM),
              Container(
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
                    _buildRecipientTile(),
                  ],
                ),
              ),
              const SizedBox(height: ThemeConstants.spacingXL),
              // Amount Input
              Text(
                'Amount',
                style: ThemeConstants.heading3,
              ),
              const SizedBox(height: ThemeConstants.spacingM),
              AppTextField(
                label: 'Enter Amount',
                controller: _amountController,
                keyboardType: TextInputType.number,
                prefixText: 'MK ',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return 'Please enter a valid amount';
                  }
                  if (amount <= 0) {
                    return 'Amount must be greater than 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: ThemeConstants.spacingXL),
              // Account Selection
              Text(
                'From Account',
                style: ThemeConstants.heading3,
              ),
              const SizedBox(height: ThemeConstants.spacingM),
              Container(
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
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(ThemeConstants.spacingS),
                        decoration: BoxDecoration(
                          color: ThemeConstants.primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.account_balance,
                          color: ThemeConstants.primaryColor,
                        ),
                      ),
                      title: Text(
                        _selectedAccount,
                        style: ThemeConstants.body1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Balance: ${Formatters.formatCurrency(1000.00)}',
                        style: ThemeConstants.body2,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: Navigate to account selection screen
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ThemeConstants.spacingXL),
              // Note Input
              AppTextField(
                label: 'Note (Optional)',
                controller: _noteController,
                maxLines: 3,
              ),
              const SizedBox(height: ThemeConstants.spacingXL),
              // Transaction Details
              Container(
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
                    _buildTransactionDetail(
                      'Transfer Fee',
                      Formatters.formatCurrency(10.00),
                    ),
                    const Divider(),
                    _buildTransactionDetail(
                      'Total Amount',
                      Formatters.formatCurrency(510.00),
                      isTotal: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ThemeConstants.spacingXL),
              // Send Button
              AppButton(
                text: 'Send Money',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Process transaction
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipientTile() {
    return ListTile(
      title: const Text('Recipient'),
      subtitle: Text(
        _selectedRecipient ?? 'Select recipient',
        style: ThemeConstants.body2,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () async {
        final result = await Navigator.pushNamed(
          context,
          AppConstants.routeRecipients,
        );
        if (result != null) {
          setState(() {
            _selectedRecipient = result as String;
          });
        }
      },
    );
  }

  Widget _buildTransactionDetail(
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: ThemeConstants.spacingS,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: ThemeConstants.body1.copyWith(
              color: ThemeConstants.textSecondaryColor,
            ),
          ),
          Text(
            value,
            style: ThemeConstants.body1.copyWith(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? ThemeConstants.primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }
}
