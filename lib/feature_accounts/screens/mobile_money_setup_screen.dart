import 'package:flutter/material.dart';

class MobileMoneySetupScreen extends StatefulWidget {
  const MobileMoneySetupScreen({super.key});

  @override
  State<MobileMoneySetupScreen> createState() => _MobileMoneySetupScreenState();
}

class _MobileMoneySetupScreenState extends State<MobileMoneySetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _accountNameController = TextEditingController();
  String? _selectedProvider;

  final List<String> _providers = [
    'Airtel Money',
    'TNM Mpamba',
  ];

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Mobile Money'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Provider Selection
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Provider',
                  border: OutlineInputBorder(),
                ),
                value: _selectedProvider,
                items: _providers.map((provider) {
                  return DropdownMenuItem(
                    value: provider,
                    child: Text(provider),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProvider = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a provider';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone Number
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  hintText: 'Enter your mobile money number',
                  prefixText: '+265 ',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 9) {
                    return 'Phone number must be at least 9 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Account Name
              TextFormField(
                controller: _accountNameController,
                decoration: const InputDecoration(
                  labelText: 'Account Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter the name on the account',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the account name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Add Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement account verification and addition
      // For now, just show a success message and pop
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mobile money account added successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }
} 