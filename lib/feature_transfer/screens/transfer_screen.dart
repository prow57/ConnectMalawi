import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transfer_provider.dart';
import '../functions/transfer_functions.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_text_field.dart';
import '../../constants/theme_constants.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleTransfer() {
    if (_formKey.currentState?.validate() ?? false) {
      final amount = double.parse(_amountController.text);
      final fee = double.parse(TransferFunctions.getTransferFee(amount));
      final total = amount + fee;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Transfer'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Recipient: ${_phoneController.text}'),
              const SizedBox(height: ThemeConstants.spacingS),
              Text('Amount: ${TransferFunctions.formatCurrency(amount)}'),
              const SizedBox(height: ThemeConstants.spacingS),
              Text('Fee: ${TransferFunctions.formatCurrency(fee)}'),
              const SizedBox(height: ThemeConstants.spacingS),
              Text(
                'Total: ${TransferFunctions.formatCurrency(total)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<TransferProvider>().transfer(
                      recipientPhone: _phoneController.text,
                      amount: amount,
                      description: _descriptionController.text,
                    );
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Money'),
      ),
      body: Consumer<TransferProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${provider.error}',
                    style: ThemeConstants.body1.copyWith(
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: ThemeConstants.spacingM),
                  ElevatedButton(
                    onPressed: () {
                      // Clear error and retry
                      provider.transfer(
                        recipientPhone: _phoneController.text,
                        amount: double.parse(_amountController.text),
                        description: _descriptionController.text,
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(ThemeConstants.spacingM),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Balance Card
                  Container(
                    padding: const EdgeInsets.all(ThemeConstants.spacingL),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ThemeConstants.primaryColor,
                          ThemeConstants.primaryColor.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available Balance',
                          style: ThemeConstants.body2.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: ThemeConstants.spacingS),
                        Text(
                          TransferFunctions.formatCurrency(
                              provider.currentBalance),
                          style: ThemeConstants.heading1.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingL),

                  // Transfer Form
                  AppTextField(
                    controller: _phoneController,
                    label: 'Recipient Phone Number',
                    hint: '+265 XXXX XXXXX',
                    prefixIcon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter recipient phone number';
                      }
                      if (!TransferFunctions.isValidPhoneNumber(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: ThemeConstants.spacingM),

                  AppTextField(
                    controller: _amountController,
                    label: 'Amount',
                    hint: '0.00',
                    prefixIcon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      final amount = double.tryParse(value);
                      if (amount == null ||
                          !TransferFunctions.isValidAmount(amount)) {
                        return 'Please enter a valid amount';
                      }
                      if (amount > provider.currentBalance) {
                        return 'Insufficient balance';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: ThemeConstants.spacingM),

                  AppTextField(
                    controller: _descriptionController,
                    label: 'Description (Optional)',
                    hint: 'Enter transfer description',
                    prefixIcon: Icons.description,
                    maxLines: 2,
                  ),
                  const SizedBox(height: ThemeConstants.spacingL),

                  // Transfer Button
                  AppButton(
                    text: 'Transfer',
                    onPressed: _handleTransfer,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
