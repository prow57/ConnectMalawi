import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'feature_auth/presentation/screens/welcome_screen.dart';
import 'feature_auth/presentation/screens/onboarding_screen.dart';
import 'feature_auth/presentation/screens/login_screen.dart';
import 'feature_auth/presentation/screens/register_screen.dart';
import 'feature_auth/presentation/screens/otp_verification_screen.dart';
import 'feature_auth/presentation/screens/forgot_password_screen.dart';
import 'feature_auth/presentation/screens/reset_password_screen.dart';
import 'feature_auth/presentation/screens/home_dashboard_screen.dart';
import 'feature_auth/presentation/providers/auth_provider.dart';
import 'feature_auth/data/services/auth_service.dart';

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
            baseUrl: 'https://api.nyasasend.com', // Replace with your API URL
          ),
        ),
        ChangeNotifierProxyProvider2<AuthService, FlutterSecureStorage,
            AuthProvider>(
          create: (context) => AuthProvider(
            authService: context.read<AuthService>(),
            secureStorage: context.read<FlutterSecureStorage>(),
          ),
          update: (context, authService, secureStorage, previous) =>
              AuthProvider(
            authService: authService,
            secureStorage: secureStorage,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Nyasa Send',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: '/welcome',
        routes: {
          '/welcome': (context) => const WelcomeScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/verify-otp': (context) {
            final args = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return OTPVerificationScreen(
              name: args['name'] ?? '',
              phone: args['phone'],
              email: args['email'],
              password: args['password'],
              isPasswordReset: args['isPasswordReset'] ?? false,
            );
          },
          '/forgot-password': (context) => const ForgotPasswordScreen(),
          '/reset-password': (context) {
            final args = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;
            return ResetPasswordScreen(
              phone: args['phone'],
              email: args['email'],
              otp: args['otp'],
            );
          },
          '/home': (context) => const HomeDashboardScreen(),
        },
      ),
    );
  }
}
