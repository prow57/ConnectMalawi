import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/theme_constants.dart';
import '../../utilities/formatters.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_text_field.dart';

class RecipientsScreen extends StatefulWidget {
  const RecipientsScreen({super.key});

  @override
  State<RecipientsScreen> createState() => _RecipientsScreenState();
}

class _RecipientsScreenState extends State<RecipientsScreen> {
  final _searchController = TextEditingController();
  final _recipients = [
    {
      'name': 'John Doe',
      'bank': 'Standard Bank',
      'accountNumber': '1234567890',
    },
    {
      'name': 'Jane Smith',
      'bank': 'National Bank',
      'accountNumber': '0987654321',
    },
    {
      'name': 'Mike Johnson',
      'bank': 'FMB',
      'accountNumber': '5678901234',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddRecipientBottomSheet(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(ThemeConstants.spacingL),
            child: AppTextField(
              controller: _searchController,
              label: 'Search Recipients',
              hint: 'Enter name or account number',
              prefixIcon: const Icon(Icons.search),
              onChanged: (value) {
                // TODO: Implement search
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: ThemeConstants.spacingL,
              ),
              itemCount: _recipients.length,
              itemBuilder: (context, index) {
                final recipient = _recipients[index];
                return Container(
                  margin:
                      const EdgeInsets.only(bottom: ThemeConstants.spacingM),
                  decoration: BoxDecoration(
                    color: ThemeConstants.surfaceColor,
                    borderRadius: BorderRadius.circular(
                      ThemeConstants.borderRadiusM,
                    ),
                    boxShadow: ThemeConstants.cardShadow,
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(ThemeConstants.spacingS),
                      decoration: BoxDecoration(
                        color: ThemeConstants.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: ThemeConstants.primaryColor,
                      ),
                    ),
                    title: Text(
                      recipient['name']!,
                      style: ThemeConstants.body1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${recipient['bank']} • ${Formatters.maskAccountNumber(recipient['accountNumber']!)}',
                      style: ThemeConstants.body2,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pop(context, recipient['name']);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddRecipientBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ThemeConstants.borderRadiusL),
        ),
      ),
      builder: (context) {
        return const AddRecipientBottomSheet();
      },
    );
  }
}

class AddRecipientBottomSheet extends StatefulWidget {
  const AddRecipientBottomSheet({super.key});

  @override
  State<AddRecipientBottomSheet> createState() =>
      _AddRecipientBottomSheetState();
}

class _AddRecipientBottomSheetState extends State<AddRecipientBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  String? _selectedBank;

  @override
  void dispose() {
    _nameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(ThemeConstants.spacingL),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Recipient',
                style: ThemeConstants.heading3,
              ),
              const SizedBox(height: ThemeConstants.spacingL),
              AppTextField(
                controller: _nameController,
                label: 'Recipient Name',
                hint: 'Enter recipient name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter recipient name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: ThemeConstants.spacingM),
              ListTile(
                title: const Text('Bank'),
                subtitle: Text(
                  _selectedBank ?? 'Select bank',
                  style: ThemeConstants.body2,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    AppConstants.routeAccounts,
                  );
                  if (result != null) {
                    setState(() {
                      _selectedBank = result as String;
                    });
                  }
                },
              ),
              const SizedBox(height: ThemeConstants.spacingM),
              AppTextField(
                controller: _accountNumberController,
                label: 'Account Number',
                hint: 'Enter account number',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account number';
                  }
                  if (value.length < 10) {
                    return 'Account number must be at least 10 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: ThemeConstants.spacingXL),
              AppButton(
                text: 'Add Recipient',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Process recipient addition
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
