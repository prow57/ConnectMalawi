import 'package:flutter/material.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  final List<Account> _accounts = [
    Account(
      id: 'ACC001',
      name: 'Standard Bank',
      balance: 250000.0,
      accountNumber: '1234567890',
      type: AccountType.bank,
    ),
    Account(
      id: 'ACC002',
      name: 'Airtel Money',
      balance: 75000.0,
      accountNumber: '0987654321',
      type: AccountType.mobileMoney,
    ),
    Account(
      id: 'ACC003',
      name: 'TNM Mpamba',
      balance: 50000.0,
      accountNumber: '5678901234',
      type: AccountType.mobileMoney,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Accounts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddAccountDialog(context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Total Balance Card
          _buildTotalBalanceCard(),
          const SizedBox(height: 24),

          // Accounts List
          const Text(
            'Connected Accounts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _accounts.length,
            itemBuilder: (context, index) {
              final account = _accounts[index];
              return _buildAccountCard(account);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTotalBalanceCard() {
    final totalBalance =
        _accounts.fold<double>(0, (sum, account) => sum + account.balance);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Total Balance',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'MWK ${totalBalance.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountCard(Account account) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            account.type == AccountType.bank
                ? Icons.account_balance
                : Icons.phone_android,
            color: Colors.white,
          ),
        ),
        title: Text(
          account.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          account.accountNumber,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'MWK ${account.balance.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              'Available Balance',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () {
          _showAccountDetails(context, account);
        },
      ),
    );
  }

  void _showAddAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.account_balance),
                title: const Text('Add Bank Account'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/accounts/bank-setup');
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone_android),
                title: const Text('Add Mobile Money'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/accounts/mobile-setup');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAccountDetails(BuildContext context, Account account) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Account Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              _buildDetailRow('Account Name', account.name),
              _buildDetailRow('Account Number', account.accountNumber),
              _buildDetailRow(
                  'Account Type', account.type.toString().split('.').last),
              _buildDetailRow(
                  'Balance', 'MWK ${account.balance.toStringAsFixed(2)}'),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Implement view transactions
                        Navigator.pop(context);
                      },
                      child: const Text('View Transactions'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement transfer money
                        Navigator.pop(context);
                      },
                      child: const Text('Transfer Money'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

enum AccountType {
  bank,
  mobileMoney,
}

class Account {
  final String id;
  final String name;
  final double balance;
  final String accountNumber;
  final AccountType type;

  Account({
    required this.id,
    required this.name,
    required this.balance,
    required this.accountNumber,
    required this.type,
  });
}
 