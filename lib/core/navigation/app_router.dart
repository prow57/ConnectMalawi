import 'package:flutter/material.dart';
import 'package:nyasa_send/feature_transfer/screens/qr_scan_screen.dart';
import 'package:nyasa_send/feature_transfer/screens/receive_screen.dart';
import 'package:nyasa_send/feature_transfer/screens/scheduled_transfers_screen.dart';
import 'package:nyasa_send/feature_transfer/screens/transaction_details_screen.dart';
import 'package:nyasa_send/feature_transfer/screens/transaction_history_screen.dart';
import 'package:nyasa_send/feature_transfer/screens/transfer_confirmation_screen.dart';
import 'package:nyasa_send/feature_transfer/screens/transfer_screen.dart';
import '../../constants/route_constants.dart';
import '../../feature_auth/screens/login_screen.dart';
import '../../feature_auth/screens/register_screen.dart';
import '../../feature_auth/screens/welcome_screen.dart';
import '../../feature_auth/screens/onboarding_screen.dart';
import '../../feature_dashboard/screens/dashboard_screen.dart';
import '../../feature_transfer/screens/recipients_screen.dart';
import '../../feature_analytics/screens/analytics_screen.dart';
import '../../feature_notifications/screens/notifications_screen.dart';
import '../../feature_verification/screens/kyc_screen.dart';
import '../../feature_accounts/screens/account_details_screen.dart';
import '../../feature_accounts/screens/accounts_screen.dart';
import '../../feature_accounts/screens/bank_account_setup_screen.dart';
import '../../feature_accounts/screens/mobile_money_setup_screen.dart';
import '../../feature_settings/screens/settings_screen.dart';
import '../../feature_settings/screens/security_settings_screen.dart';
import '../../feature_settings/screens/terms_screen.dart';
import '../../feature_settings/screens/privacy_settings_screen.dart';
import '../../feature_settings/screens/about_screen.dart';
import '../../feature_settings/screens/help_center_screen.dart';
import '../../feature_settings/screens/profile_screen.dart';
import '../../feature_settings/screens/change_password_screen.dart';
import '../../feature_settings/screens/change_pin_screen.dart';
import '../../feature_settings/screens/transfer_limits_screen.dart';
import '../../feature_settings/screens/language_screen.dart';
import '../../feature_settings/screens/appearance_screen.dart';
import '../../feature_settings/screens/security_log_screen.dart';
import '../../feature_settings/screens/feedback_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth Routes
      case RouteConstants.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case RouteConstants.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RouteConstants.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteConstants.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case RouteConstants.home:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      // Dashboard Routes
      case RouteConstants.transfer:
        return MaterialPageRoute(builder: (_) => const TransferScreen());
      case RouteConstants.receive:
        return MaterialPageRoute(builder: (_) => const ReceiveScreen());
      case RouteConstants.transactions:
        return MaterialPageRoute(
            builder: (_) => const TransactionHistoryScreen());
      case RouteConstants.recipients:
        return MaterialPageRoute(builder: (_) => const RecipientsScreen());
      case RouteConstants.accounts:
        return MaterialPageRoute(builder: (_) => const AccountsScreen());
      case RouteConstants.bankSetup:
        return MaterialPageRoute(
            builder: (_) => const BankAccountSetupScreen());
      case RouteConstants.mobileSetup:
        return MaterialPageRoute(
            builder: (_) => const MobileMoneySetupScreen());
      case RouteConstants.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case RouteConstants.kyc:
        return MaterialPageRoute(builder: (_) => const KycScreen());
      case RouteConstants.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case RouteConstants.analytics:
        return MaterialPageRoute(builder: (_) => const AnalyticsScreen());

      // Transaction Routes
      case RouteConstants.transferConfirm:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => TransferConfirmationScreen(
            recipientName: args['recipientName'],
            recipientAccount: args['recipientAccount'],
            amount: args['amount'],
            note: args['note'],
            sourceAccount: args['sourceAccount'],
            transferType: args['transferType'],
          ),
        );
      case RouteConstants.transactionDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => TransactionDetailsScreen(
            transaction: args['transaction'],
          ),
        );
      case RouteConstants.accountDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => AccountDetailsScreen(
            account: args['account'],
          ),
        );
      case RouteConstants.scan:
        return MaterialPageRoute(builder: (_) => const QRScanScreen());
      case RouteConstants.scheduledTransfers:
        return MaterialPageRoute(
            builder: (_) => const ScheduledTransfersScreen());

      // Settings Routes
      case RouteConstants.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case RouteConstants.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case RouteConstants.changePin:
        return MaterialPageRoute(builder: (_) => const ChangePinScreen());
      case RouteConstants.securitySettings:
        return MaterialPageRoute(
            builder: (_) => const SecuritySettingsScreen());
      case RouteConstants.securityLog:
        return MaterialPageRoute(builder: (_) => const SecurityLogScreen());
      case RouteConstants.transferLimits:
        return MaterialPageRoute(builder: (_) => const TransferLimitsScreen());
      case RouteConstants.language:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());
      case RouteConstants.appearance:
        return MaterialPageRoute(builder: (_) => const AppearanceScreen());
      case RouteConstants.terms:
        return MaterialPageRoute(builder: (_) => const TermsScreen());
      case RouteConstants.privacy:
        return MaterialPageRoute(builder: (_) => const PrivacySettingsScreen());
      case RouteConstants.about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
      case RouteConstants.help:
        return MaterialPageRoute(builder: (_) => const HelpCenterScreen());
      case RouteConstants.feedback:
        return MaterialPageRoute(builder: (_) => const FeedbackScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
