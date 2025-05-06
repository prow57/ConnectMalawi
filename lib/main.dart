import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nyasa_send/feature_auth/screens/login_screen.dart';
import 'package:nyasa_send/feature_auth/screens/register_screen.dart';
import 'constants/app_constants.dart';
import 'constants/theme_constants.dart';
import 'feature_auth/screens/welcome_screen.dart';
import 'feature_auth/screens/onboarding_screen.dart';
import 'feature_dashboard/screens/home_dashboard_screen.dart';
import 'feature_dashboard/screens/send_money_screen.dart';
import 'feature_dashboard/screens/request_money_screen.dart';
import 'feature_dashboard/screens/add_bank_screen.dart';
import 'feature_dashboard/screens/recipients_screen.dart';
import 'feature_dashboard/screens/accounts_screen.dart';
import 'feature_dashboard/screens/transactions_screen.dart';
import 'feature_dashboard/screens/notifications_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ThemeConstants.primaryColor,
        scaffoldBackgroundColor: ThemeConstants.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: ThemeConstants.surfaceColor,
          foregroundColor: ThemeConstants.textPrimaryColor,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ThemeConstants.primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ThemeConstants.surfaceColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
            borderSide: const BorderSide(
              color: ThemeConstants.textSecondaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
            borderSide: const BorderSide(
              color: ThemeConstants.textSecondaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
            borderSide: const BorderSide(
              color: ThemeConstants.primaryColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
            borderSide: const BorderSide(
              color: ThemeConstants.errorColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
            borderSide: const BorderSide(
              color: ThemeConstants.errorColor,
            ),
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: AppConstants.routeWelcome,
      routes: {
        AppConstants.routeWelcome: (context) => const WelcomeScreen(),
        AppConstants.routeOnboarding: (context) => const OnboardingScreen(),
        AppConstants.routeHome: (context) => const HomeDashboardScreen(),
        AppConstants.routeSendMoney: (context) => const SendMoneyScreen(),
        AppConstants.routeRequestMoney: (context) => const RequestMoneyScreen(),
        AppConstants.routeAddBank: (context) => const AddBankScreen(),
        AppConstants.routeRecipients: (context) => const RecipientsScreen(),
        AppConstants.routeAccounts: (context) => const AccountsScreen(),
        AppConstants.routeTransactions: (context) => const TransactionsScreen(),
        AppConstants.routeNotifications: (context) =>
            const NotificationsScreen(),
        AppConstants.routeLogin: (context) => const LoginScreen(),
        AppConstants.routeRegister: (context) => const RegisterScreen(),
      },
    );
  }
}
