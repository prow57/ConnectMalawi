import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'constants/app_constants.dart';
import 'constants/theme_constants.dart';
import 'feature_auth/screens/welcome_screen.dart';
import 'feature_auth/screens/onboarding_screen.dart';
import 'feature_auth/screens/login_screen.dart';
import 'feature_auth/screens/register_screen.dart';
import 'feature_auth/screens/otp_verification_screen.dart';
import 'feature_auth/screens/forgot_password_screen.dart';
import 'feature_auth/screens/reset_password_screen.dart';
import 'feature_dashboard/screens/home_dashboard_screen.dart';
import 'feature_auth/providers/auth_provider.dart';
import 'feature_auth/services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FlutterSecureStorage>(
          create: (_) => const FlutterSecureStorage(),
        ),
        Provider<AuthService>(
          create: (_) => AuthService(
            baseUrl: AppConstants.apiBaseUrl,
          ),
        ),
        ChangeNotifierProxyProvider2<AuthService, FlutterSecureStorage, AuthProvider>(
          create: (context) => AuthProvider(
            authService: context.read<AuthService>(),
            secureStorage: context.read<FlutterSecureStorage>(),
          ),
          update: (context, authService, secureStorage, previous) => AuthProvider(
            authService: authService,
            secureStorage: secureStorage,
          ),
        ),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        theme: ThemeData(
          primaryColor: ThemeConstants.primaryColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: ThemeConstants.primaryColor,
            primary: ThemeConstants.primaryColor,
            secondary: ThemeConstants.secondaryColor,
          ),
          scaffoldBackgroundColor: ThemeConstants.backgroundColor,
          useMaterial3: true,
          textTheme: const TextTheme(
            displayLarge: ThemeConstants.heading1,
            displayMedium: ThemeConstants.heading2,
            displaySmall: ThemeConstants.heading3,
            bodyLarge: ThemeConstants.body1,
            bodyMedium: ThemeConstants.body2,
          ),
        ),
        initialRoute: AppConstants.routeWelcome,
        routes: {
          AppConstants.routeWelcome: (context) => const WelcomeScreen(),
          AppConstants.routeOnboarding: (context) => const OnboardingScreen(),
          AppConstants.routeLogin: (context) => const LoginScreen(),
          AppConstants.routeRegister: (context) => const RegisterScreen(),
          AppConstants.routeVerifyOTP: (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return OTPVerificationScreen(
              name: args['name'] ?? '',
              phone: args['phone'],
              email: args['email'],
              password: args['password'],
              isPasswordReset: args['isPasswordReset'] ?? false,
            );
          },
          AppConstants.routeForgotPassword: (context) => const ForgotPasswordScreen(),
          AppConstants.routeResetPassword: (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return ResetPasswordScreen(
              phone: args['phone'],
              email: args['email'],
              otp: args['otp'],
            );
          },
          AppConstants.routeHome: (context) => const HomeDashboardScreen(),
        },
      ),
    );
  }
}
