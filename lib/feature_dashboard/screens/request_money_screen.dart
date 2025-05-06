import 'package:flutter/material.dart';
import '../../constants/theme_constants.dart';
import '../../utilities/formatters.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_text_field.dart';
import '../../constants/app_constants.dart';

class RequestMoneyScreen extends StatefulWidget {
  const RequestMoneyScreen({super.key});

  @override
  State<RequestMoneyScreen> createState() => _RequestMoneyScreenState();
}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedRecipient = 'John Doe';

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
        title: const Text('Request Money'),
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
                'Request From',
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
                prefixIcon: const Text(
                  'MK',
                  style: TextStyle(
                    color: ThemeConstants.textSecondaryColor,
                  ),
                ),
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
              // Note Input
              AppTextField(
                label: 'Note (Optional)',
                controller: _noteController,
                maxLines: 3,
              ),
              const SizedBox(height: ThemeConstants.spacingXL),
              // Request Details
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
                    _buildRequestDetail(
                      'Request Amount',
                      Formatters.formatCurrency(500.00),
                    ),
                    const Divider(),
                    _buildRequestDetail(
                      'Status',
                      'Pending',
                      isStatus: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: ThemeConstants.spacingXL),
              // Request Button
              AppButton(
                text: 'Send Request',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Process request
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

  Widget _buildRequestDetail(
    String label,
    String value, {
    bool isStatus = false,
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
              fontWeight: isStatus ? FontWeight.bold : FontWeight.normal,
              color: isStatus ? ThemeConstants.primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }
}
