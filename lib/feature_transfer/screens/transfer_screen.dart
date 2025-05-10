import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/transfer_provider.dart';
import '../../../constants/theme_constants.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _recipientController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _handleTransfer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await context.read<TransferProvider>().transfer(
            amount: double.parse(_amountController.text),
            recipientPhone: _recipientController.text,
            description: _descriptionController.text,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transfer successful!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ThemeConstants.spacingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Amount Section
                Text(
                  'Amount',
                  style: ThemeConstants.heading3.copyWith(
                    color: ThemeConstants.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: ThemeConstants.spacingS),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  decoration: InputDecoration(
                    prefixText: 'MK ',
                    hintText: '0.00',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.attach_money),
                      onPressed: () {
                        // TODO: Show currency selector
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    final amount = double.tryParse(value);
                    if (amount == null || amount <= 0) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: ThemeConstants.spacingL),

                // Recipient Section
                Text(
                  'Recipient',
                  style: ThemeConstants.heading3.copyWith(
                    color: ThemeConstants.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: ThemeConstants.spacingS),
                TextFormField(
                  controller: _recipientController,
                  decoration: InputDecoration(
                    hintText: 'Enter phone number or email',
                    prefixIcon: const Icon(Icons.person_outline),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.contacts),
                      onPressed: () {
                        // TODO: Show contacts picker
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter recipient details';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: ThemeConstants.spacingL),

                // Description Section
                Text(
                  'Description (Optional)',
                  style: ThemeConstants.heading3.copyWith(
                    color: ThemeConstants.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: ThemeConstants.spacingS),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Add a note about this transfer',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: ThemeConstants.spacingXL),

                // Transfer Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleTransfer,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Send Money',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: ThemeConstants.spacingM),

                // Quick Amount Buttons
                Text(
                  'Quick Amount',
                  style: ThemeConstants.heading3.copyWith(
                    color: ThemeConstants.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: ThemeConstants.spacingS),
                Wrap(
                  spacing: ThemeConstants.spacingS,
                  runSpacing: ThemeConstants.spacingS,
                  children: [
                    _buildQuickAmountButton('1,000'),
                    _buildQuickAmountButton('5,000'),
                    _buildQuickAmountButton('10,000'),
                    _buildQuickAmountButton('20,000'),
                    _buildQuickAmountButton('50,000'),
                    _buildQuickAmountButton('100,000'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAmountButton(String amount) {
    return OutlinedButton(
      onPressed: () {
        _amountController.text = amount.replaceAll(',', '');
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ThemeConstants.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
        ),
      ),
      child: Text(
        'MK $amount',
        style: const TextStyle(
          color: ThemeConstants.primaryColor,
        ),
      ),
    );
  }
}
