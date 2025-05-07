import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduledTransfersScreen extends StatefulWidget {
  const ScheduledTransfersScreen({super.key});

  @override
  State<ScheduledTransfersScreen> createState() =>
      _ScheduledTransfersScreenState();
}

class _ScheduledTransfersScreenState extends State<ScheduledTransfersScreen> {
  final List<Map<String, dynamic>> _scheduledTransfers = [
    {
      'id': '1',
      'recipient': 'John Doe',
      'amount': 5000.0,
      'frequency': 'Weekly',
      'nextDate': DateTime.now().add(const Duration(days: 2)),
      'status': 'active',
      'fromAccount': 'Standard Bank',
      'note': 'Rent payment',
    },
    {
      'id': '2',
      'recipient': 'Jane Smith',
      'amount': 10000.0,
      'frequency': 'Monthly',
      'nextDate': DateTime.now().add(const Duration(days: 15)),
      'status': 'active',
      'fromAccount': 'Airtel Money',
      'note': 'Salary payment',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduled Transfers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showNewScheduledTransfer,
          ),
        ],
      ),
      body: _scheduledTransfers.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _scheduledTransfers.length,
              itemBuilder: (context, index) {
                final transfer = _scheduledTransfers[index];
                return _buildScheduledTransferCard(transfer);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.schedule,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Scheduled Transfers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Schedule your transfers to automate your payments',
            style: TextStyle(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showNewScheduledTransfer,
            icon: const Icon(Icons.add),
            label: const Text('Schedule Transfer'),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledTransferCard(Map<String, dynamic> transfer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transfer['recipient'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        transfer['note'],
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: transfer['status'] == 'active'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    transfer['status'].toUpperCase(),
                    style: TextStyle(
                      color: transfer['status'] == 'active'
                          ? Colors.green
                          : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Amount',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'MWK ${transfer['amount'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Next Transfer',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(transfer['nextDate']),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Frequency',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      transfer['frequency'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'From: ${transfer['fromAccount']}',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _editScheduledTransfer(transfer),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _showDeleteConfirmationDialog(transfer),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showNewScheduledTransfer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const NewScheduledTransferSheet(),
        );
      },
    );
  }

  void _editScheduledTransfer(Map<String, dynamic> transfer) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: NewScheduledTransferSheet(transfer: transfer),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(Map<String, dynamic> transfer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Scheduled Transfer'),
          content: Text(
            'Are you sure you want to delete the scheduled transfer to ${transfer['recipient']}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _scheduledTransfers.removeWhere(
                    (t) => t['id'] == transfer['id'],
                  );
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

class NewScheduledTransferSheet extends StatefulWidget {
  final Map<String, dynamic>? transfer;

  const NewScheduledTransferSheet({super.key, this.transfer});

  @override
  State<NewScheduledTransferSheet> createState() =>
      _NewScheduledTransferSheetState();
}

class _NewScheduledTransferSheetState extends State<NewScheduledTransferSheet> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedFrequency = 'Weekly';
  String _selectedAccount = 'Standard Bank';
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));

  final List<String> _frequencies = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
  ];

  final List<String> _accounts = [
    'Standard Bank',
    'Airtel Money',
    'TNM Mpamba',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.transfer != null) {
      _recipientController.text = widget.transfer!['recipient'];
      _amountController.text = widget.transfer!['amount'].toString();
      _noteController.text = widget.transfer!['note'];
      _selectedFrequency = widget.transfer!['frequency'];
      _selectedAccount = widget.transfer!['fromAccount'];
      _selectedDate = widget.transfer!['nextDate'];
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.transfer == null
                  ? 'New Scheduled Transfer'
                  : 'Edit Scheduled Transfer',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _recipientController,
              decoration: const InputDecoration(
                labelText: 'Recipient',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter recipient name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                prefixText: 'MWK ',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter amount';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid amount';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedFrequency,
              decoration: const InputDecoration(
                labelText: 'Frequency',
                border: OutlineInputBorder(),
              ),
              items: _frequencies.map((frequency) {
                return DropdownMenuItem(
                  value: frequency,
                  child: Text(frequency),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedFrequency = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedAccount,
              decoration: const InputDecoration(
                labelText: 'From Account',
                border: OutlineInputBorder(),
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
                    _selectedAccount = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Note (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  widget.transfer == null
                      ? 'Schedule Transfer'
                      : 'Update Transfer',
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement form submission
      Navigator.pop(context);
    }
  }
}
