import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String? _selectedFromAccount;
  String? _selectedToAccount;

  final List<Map<String, dynamic>> _accounts = [
    {'id': '1', 'name': 'Standard Bank', 'balance': 50000.0},
    {'id': '2', 'name': 'Airtel Money', 'balance': 25000.0},
  ];

  final List<Map<String, dynamic>> _recentRecipients = [
    {'id': '1', 'name': 'John Doe', 'account': '0999123456'},
    {'id': '2', 'name': 'Jane Smth', 'account': '0888123456'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAmountInput(),
              const SizedBox(height: 24),
              _buildAccountSelection(),
              const SizedBox(height: 24),
              _buildRecipientsSection(),
              const SizedBox(height: 24),
              _buildNoteInput(),
              const SizedBox(height: 32),
              _buildSendButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInput() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Amount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: 'MWK ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: '0.00',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSelection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'From Account',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedFromAccount,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: _accounts.map((account) {
                return DropdownMenuItem<String>(
                  value: account['id'] as String,
                  child: Text('${account['name']} - MWK ${account['balance']}'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedFromAccount = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select an account';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recipients',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                // Navigate to add recipient screen
              },
              icon: const Icon(Icons.add),
              label: const Text('Add New'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _recentRecipients.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final recipient = _recentRecipients[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Text(
                    recipient['name'][0],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(recipient['name']),
                subtitle: Text(recipient['account']),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  setState(() {
                    _selectedToAccount = recipient['id'];
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNoteInput() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Note (Optional)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _noteController,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Add a note to this transfer',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Handle transfer
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Send Money',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
 