import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Nyasa Send';
  static const String apiBaseUrl = 'https://api.nyasasend.com';

  // Routes
  static const String routeWelcome = '/welcome';
  static const String routeOnboarding = '/onboarding';
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeVerifyOTP = '/verify-otp';
  static const String routeForgotPassword = '/forgot-password';
  static const String routeResetPassword = '/reset-password';
  static const String routeHome = '/home';
  static const String routeSendMoney = '/send-money';
  static const String routeRequestMoney = '/request-money';
  static const String routeAddBank = '/add-bank';
  static const String routeTransactions = '/transactions';
  static const String routeNotifications = '/notifications';
  static const String routeRecipients = '/recipients';
  static const String routeAccounts = '/accounts';

  // Storage keys
  static const String storageTokenKey = 'auth_token';
  static const String storageUserKey = 'user_data';
  static const String storageBiometricKey = 'biometric_enabled';

  // Validation
  static const int minPasswordLength = 6;
  static const int otpLength = 6;

  // Timeouts
  static const int otpResendTimeout = 60; // seconds

  // Animations
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Curve pageTransitionCurve = Curves.easeInOut;
}
