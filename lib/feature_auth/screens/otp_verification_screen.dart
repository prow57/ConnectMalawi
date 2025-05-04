import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String name;
  final String? phone;
  final String? email;
  final String? password;
  final bool isPasswordReset;

  const OTPVerificationScreen({
    super.key,
    required this.name,
    this.phone,
    this.email,
    this.password,
    this.isPasswordReset = false,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );
  int _resendTimer = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _resendTimer = 60;
      _canResend = false;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _resendTimer--;
        });
        if (_resendTimer > 0) {
          _startResendTimer();
        } else {
          setState(() {
            _canResend = true;
          });
        }
      }
    });
  }

  void _handleOTPInput(int index, String value) {
    if (value.length == 1) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _verifyOTP();
      }
    }
  }

  Future<void> _verifyOTP() async {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length != 6) return;

    final authProvider = context.read<AuthProvider>();
    try {
      if (widget.isPasswordReset) {
        await authProvider.verifyPasswordResetOTP(
          widget.phone ?? widget.email!,
          otp,
        );
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            '/reset-password',
            arguments: {
              'phone': widget.phone,
              'email': widget.email,
              'otp': otp,
            },
          );
        }
      } else {
        await authProvider.verifyRegistrationOTP(
          widget.phone ?? widget.email!,
          otp,
        );
        await authProvider.register(
          widget.name,
          widget.phone ?? widget.email!,
          widget.password!,
        );
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter the 6-digit code sent to ${widget.phone ?? widget.email}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 32),
              // OTP input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 40,
                    child: TextFormField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => _handleOTPInput(index, value),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Resend OTP button
              TextButton(
                onPressed: _canResend
                    ? () async {
                        final authProvider = context.read<AuthProvider>();
                        try {
                          await authProvider.sendOTP(
                            widget.phone ?? widget.email!,
                          );
                          _startResendTimer();
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        }
                      }
                    : null,
                child: Text(
                  _canResend
                      ? 'Resend OTP'
                      : 'Resend OTP in $_resendTimer seconds',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 