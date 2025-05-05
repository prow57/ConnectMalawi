import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/theme_constants.dart';
import '../../utilities/formatters.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_text_field.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({super.key});

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedBank;
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();

  @override
  void dispose() {
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bank Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ThemeConstants.spacingL),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBankTile(),
              const SizedBox(height: ThemeConstants.spacingL),
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
              const SizedBox(height: ThemeConstants.spacingM),
              AppTextField(
                controller: _accountNameController,
                label: 'Account Name',
                hint: 'Enter account name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: ThemeConstants.spacingXL),
              if (_selectedBank != null &&
                  _accountNumberController.text.isNotEmpty &&
                  _accountNameController.text.isNotEmpty)
                _buildAccountDetail(),
              const SizedBox(height: ThemeConstants.spacingXL),
              AppButton(
                text: 'Add Account',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Process account addition
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBankTile() {
    return ListTile(
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
    );
  }

  Widget _buildAccountDetail() {
    return Container(
      padding: const EdgeInsets.all(ThemeConstants.spacingM),
      decoration: BoxDecoration(
        color: ThemeConstants.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
        boxShadow: ThemeConstants.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Details',
            style: ThemeConstants.heading3,
          ),
          const SizedBox(height: ThemeConstants.spacingM),
          ListTile(
            title: const Text('Bank'),
            subtitle: Text(
              _selectedBank!,
              style: ThemeConstants.body2,
            ),
          ),
          ListTile(
            title: const Text('Account Number'),
            subtitle: Text(
              Formatters.maskAccountNumber(_accountNumberController.text),
              style: ThemeConstants.body2,
            ),
          ),
          ListTile(
            title: const Text('Account Name'),
            subtitle: Text(
              _accountNameController.text,
              style: ThemeConstants.body2,
            ),
          ),
        ],
      ),
    );
  }
}
