import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': '1',
      'amount': 5000.0,
      'fromAccount': 'Standard Bank',
      'toAccount': 'John Doe',
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'status': 'completed',
      'type': 'sent',
      'note': 'Lunch payment',
    },
    {
      'id': '2',
      'amount': 10000.0,
      'fromAccount': 'Jane Smith',
      'toAccount': 'Airtel Money',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'status': 'completed',
      'type': 'received',
      'note': 'Project payment',
    },
    {
      'id': '3',
      'amount': 7500.0,
      'fromAccount': 'Airtel Money',
      'toAccount': 'Mike Johnson',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'status': 'pending',
      'type': 'sent',
      'note': 'Rent payment',
    },
  ];

  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                return _buildTransactionCard(transaction);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('All', 'all'),
          _buildFilterChip('Sent', 'sent'),
          _buildFilterChip('Received', 'received'),
          _buildFilterChip('Pending', 'pending'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = value;
          });
        },
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final isSent = transaction['type'] == 'sent';
    final color = isSent ? Colors.red : Colors.green;
    final statusColor = transaction['status'] == 'pending'
        ? Colors.orange
        : transaction['status'] == 'completed'
            ? Colors.green
            : Colors.red;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to transaction details
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.1),
                    child: Icon(
                      isSent ? Icons.arrow_upward : Icons.arrow_downward,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSent
                              ? 'To: ${transaction['toAccount']}'
                              : 'From: ${transaction['fromAccount']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          transaction['note'],
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${isSent ? '-' : '+'} MWK ${transaction['amount'].toStringAsFixed(2)}',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          transaction['status'].toUpperCase(),
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDate(transaction['date']),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Transaction ID: ${transaction['id']}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filter Transactions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Date Range'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Show date range picker
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_balance),
                title: const Text('Account'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Show account filter
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text('Amount Range'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Show amount range picker
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
