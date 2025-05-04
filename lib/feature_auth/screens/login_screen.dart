import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _useBiometric = false;
  bool _usePhone = true;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    // TODO: Implement biometric availability check
    setState(() {
      _useBiometric = true; // This should be set based on actual device capability
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              const SizedBox(height: 16),
              // Password field
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              // Forgot Password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 16),
              // Biometric toggle
              if (_useBiometric)
                Row(
                  children: [
                    Checkbox(
                      value: _useBiometric,
                      onChanged: (value) {
                        setState(() {
                          _useBiometric = value ?? false;
                        });
                      },
                    ),
                    const Text('Use Biometric Authentication'),
                  ],
                ),
              const SizedBox(height: 24),
              // Login button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final authProvider = context.read<AuthProvider>();
                    try {
                      await authProvider.login(
                        _usePhone ? _phoneController.text : _emailController.text,
                        _passwordController.text,
                        useBiometric: _useBiometric,
                      );
                      if (mounted) {
                        Navigator.pushReplacementNamed(context, '/home');
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
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),
              // Register link
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
