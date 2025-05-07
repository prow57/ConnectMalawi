import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'transfer_confirmation_screen.dart';

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
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (amount > 0) {
      setState(() {
        switch (_selectedSpeed) {
          case 'Instant':
            _fee = amount * 0.02;
            break;
          case 'Standard (1-2 hours)':
            _fee = amount * 0.015;
            break;
          case 'Economy (24 hours)':
            _fee = amount * 0.01;
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // From Account
            _buildSectionHeader(
                context, 'From Account', Icons.account_balance_outlined),
            Card(
              elevation: 2,
              shadowColor: Colors.grey.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButtonFormField<String>(
                  value: _selectedFromAccount,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.account_balance),
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
              ),
            ),
            const SizedBox(height: 24),

            // To Account
            _buildSectionHeader(
                context, 'To Account', Icons.account_balance_wallet_outlined),
            Card(
              elevation: 2,
              shadowColor: Colors.grey.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedToAccount,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.account_balance_wallet),
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
                    const Divider(),
                    TextFormField(
                      controller: _recipientController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Recipient Account Number',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter recipient account number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Amount
            _buildSectionHeader(context, 'Amount', Icons.attach_money_outlined),
            Card(
              elevation: 2,
              shadowColor: Colors.grey.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.attach_money),
                    hintText: 'Amount (MWK)',
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
              ),
            ),
            const SizedBox(height: 24),

            // Transfer Speed
            _buildSectionHeader(
                context, 'Transfer Speed', Icons.speed_outlined),
            Card(
              elevation: 2,
              shadowColor: Colors.grey.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButtonFormField<String>(
                  value: _selectedSpeed,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.speed),
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
              ),
            ),
            const SizedBox(height: 24),

            // Note
            _buildSectionHeader(
                context, 'Note (Optional)', Icons.note_outlined),
            Card(
              elevation: 2,
              shadowColor: Colors.grey.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.note),
                    hintText: 'Add a note',
                  ),
                  maxLines: 2,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Fee Summary
            _buildSectionHeader(context, 'Fee Summary', Icons.receipt_outlined),
            Card(
              elevation: 2,
              shadowColor: Colors.grey.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
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
            ),
            const SizedBox(height: 32),

            // Send Button
            ElevatedButton(
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransferConfirmationScreen(
                              recipientName: _recipientController.text,
                              recipientAccount: _selectedToAccount,
                              amount: double.parse(_amountController.text),
                              note: _noteController.text,
                              sourceAccount: _selectedFromAccount,
                              transferType: _selectedSpeed,
                            ),
                          ),
                        );

                        if (result == true && mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  const Icon(Icons.check_circle,
                                      color: Colors.white),
                                  const SizedBox(width: 8),
                                  const Text('Transfer successful!'),
                                ],
                              ),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
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
                elevation: 2,
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
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
              color: isTotal ? Colors.black : Colors.grey[600],
            ),
          ),
          Text(
            'MWK $value',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey[600],
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
