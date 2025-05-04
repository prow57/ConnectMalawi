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

  // Storage keys
  static const String storageTokenKey = 'auth_token';
  static const String storageUserKey = 'user_data';
  static const String storageBiometricKey = 'biometric_enabled';

  // Validation
  static const int minPasswordLength = 6;
  static const int otpLength = 6;

  // Timeouts
  static const int otpResendTimeout = 60; // seconds
}
