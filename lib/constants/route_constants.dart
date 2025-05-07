class RouteConstants {
  // Auth Routes
  static const String welcome = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  // Dashboard Routes
  static const String transfer = '/transfer';
  static const String receive = '/receive';
  static const String transactions = '/transactions';
  static const String recipients = '/recipients';
  static const String accounts = '/accounts';
  static const String bankSetup = '/accounts/bank-setup';
  static const String mobileSetup = '/accounts/mobile-setup';
  static const String settings = '/settings';
  static const String kyc = '/verification/kyc';
  static const String notifications = '/notifications';
  static const String analytics = '/analytics';

  // Transaction Routes
  static const String transferConfirm = '/transfer/confirm';
  static const String transactionDetails = '/transactions/details';
  static const String accountDetails = '/accounts/details';
  static const String scan = '/scan';
  static const String scheduledTransfers = '/scheduled-transfers';

  // Settings Routes
  static const String profile = '/settings/profile';
  static const String changePassword = '/settings/change-password';
  static const String changePin = '/settings/change-pin';
  static const String securitySettings = '/settings/security';
  static const String securityLog = '/settings/security-log';
  static const String transferLimits = '/settings/transfer-limits';
  static const String language = '/settings/language';
  static const String appearance = '/settings/appearance';
  static const String terms = '/settings/terms';
  static const String privacy = '/settings/privacy';
  static const String about = '/settings/about';
  static const String help = '/settings/help';
  static const String feedback = '/settings/feedback';
}
