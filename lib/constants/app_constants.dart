import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Nyasa Send';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Mobile money transfer for Malawi';

  // API
  static const String apiBaseUrl = 'https://api.nyasasend.com/v1';
  static const int apiTimeout = 30000; // 30 seconds

  // Routes
  static const String routeLogin = '/login';
  static const String routeRegister = '/register';
  static const String routeWelcome = '/welcome';
  static const String routeOnboarding = '/onboarding';
  static const String routeHome = '/home';
  static const String routeSendMoney = '/send-money';
  static const String routeRequestMoney = '/request-money';
  static const String routeAddBank = '/add-bank';
  static const String routeRecipients = '/recipients';
  static const String routeAccounts = '/accounts';
  static const String routeTransactions = '/transactions';
  static const String routeNotifications = '/notifications';

  // Animation
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Curve pageTransitionCurve = Curves.easeInOut;

  // Storage Keys
  static const String keyAuthToken = 'auth_token';
  static const String keyUserData = 'user_data';
  static const String keyOnboardingComplete = 'onboarding_complete';

  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 32;
  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 13;
  static const int otpLength = 6;
  static const int minAccountNumberLength = 10;
  static const int maxAccountNumberLength = 16;

  // Limits
  static const double minTransactionAmount = 100.0;
  static const double maxTransactionAmount = 1000000.0;
  static const double transactionFeePercentage = 0.01; // 1%
}
