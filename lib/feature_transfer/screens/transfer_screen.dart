import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _recipientController = TextEditingController();
  final _noteController = TextEditingController();

  String _selectedFromAccount = 'Standard Bank';
  String _selectedToAccount = 'Airtel Money';
  String _selectedSpeed = 'Instant';
  double _fee = 0.0;
  bool _isLoading = false;

  final List<String> _accounts = [
    'Standard Bank',
    'National Bank',
    'Airtel Money',
    'TNM Mpamba',
    'Ecobank',
  ];

  final List<String> _transferSpeeds = [
    'Instant',
    'Standard (1-2 hours)',
    'Economy (24 hours)',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _recipientController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _calculateFee() {
    // Simulated fee calculation based on amount and speed
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount > 0) {
      setState(() {
        switch (_selectedSpeed) {
          case 'Instant':
            _fee = amount * 0.02; // 2% fee
            break;
          case 'Standard (1-2 hours)':
            _fee = amount * 0.015; // 1.5% fee
            break;
          case 'Economy (24 hours)':
            _fee = amount * 0.01; // 1% fee
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // From Account
            _buildSectionHeader(context, 'From Account'),
            DropdownButtonFormField<String>(
              value: _selectedFromAccount,
              decoration: InputDecoration(
                labelText: 'Select Account',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.account_balance),
              ),
              items: _accounts.map((account) {
                return DropdownMenuItem(
                  value: account,
                  child: Text(account),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedFromAccount = value;
                  });
                }
              },
            ),
            const SizedBox(height: 24),

            // To Account
            _buildSectionHeader(context, 'To Account'),
            DropdownButtonFormField<String>(
              value: _selectedToAccount,
              decoration: InputDecoration(
                labelText: 'Select Recipient Account',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.account_balance_wallet),
              ),
              items: _accounts.map((account) {
                return DropdownMenuItem(
                  value: account,
                  child: Text(account),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedToAccount = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _recipientController,
              decoration: InputDecoration(
                labelText: 'Recipient Account Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter recipient account number';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Amount
            _buildSectionHeader(context, 'Amount'),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount (MWK)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (_) => _calculateFee(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter amount';
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Transfer Speed
            _buildSectionHeader(context, 'Transfer Speed'),
            DropdownButtonFormField<String>(
              value: _selectedSpeed,
              decoration: InputDecoration(
                labelText: 'Select Transfer Speed',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.speed),
              ),
              items: _transferSpeeds.map((speed) {
                return DropdownMenuItem(
                  value: speed,
                  child: Text(speed),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedSpeed = value;
                  });
                  _calculateFee();
                }
              },
            ),
            const SizedBox(height: 24),

            // Note
            _buildSectionHeader(context, 'Note (Optional)'),
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Add a note',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.note),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),

            // Fee Summary
            _buildSectionHeader(context, 'Fee Summary'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildFeeRow('Transfer Amount', _amountController.text),
                  _buildFeeRow('Transfer Fee', _fee.toStringAsFixed(2)),
                  const Divider(),
                  _buildFeeRow(
                    'Total Amount',
                    (double.tryParse(_amountController.text) ?? 0 + _fee)
                        .toStringAsFixed(2),
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Send Button
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        // Simulate transfer process
                        await Future.delayed(const Duration(seconds: 2));

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Transfer successful!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Send Money',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildFeeRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            'MWK $value',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
