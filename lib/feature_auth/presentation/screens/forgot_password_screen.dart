import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  bool _usePhone = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your phone number or email to reset your password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              // Toggle between phone and email
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text('Phone'),
                    selected: _usePhone,
                    onSelected: (selected) {
                      setState(() {
                        _usePhone = selected;
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  ChoiceChip(
                    label: const Text('Email'),
                    selected: !_usePhone,
                    onSelected: (selected) {
                      setState(() {
                        _usePhone = !selected;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Phone/Email field
              if (_usePhone)
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                    prefixText: '+265 ',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                )
              else
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 24),
              // Send OTP button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final authProvider = context.read<AuthProvider>();
                    try {
                      await authProvider.sendOTP(
                        _usePhone
                            ? _phoneController.text
                            : _emailController.text,
                      );
                      if (mounted) {
                        Navigator.pushNamed(
                          context,
                          '/verify-otp',
                          arguments: {
                            'phone': _usePhone ? _phoneController.text : null,
                            'email': !_usePhone ? _emailController.text : null,
                            'isPasswordReset': true,
                          },
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    }
                  }
                },
                child: const Text('Send OTP'),
              ),
              const SizedBox(height: 16),
              // Back to login link
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
