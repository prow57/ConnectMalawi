import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'feature_auth/providers/auth_provider.dart';
import 'feature_auth/services/auth_service.dart';
import 'core/navigation/app_router.dart';
import 'constants/route_constants.dart';
import 'constants/app_constants.dart';
import 'constants/theme_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feature_dashboard/providers/dashboard_provider.dart';
import 'feature_dashboard/services/dashboard_service.dart';
import 'feature_transfer/providers/transfer_provider.dart';
import 'feature_transfer/services/transfer_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            AuthService(
              baseUrl: AppConstants.apiBaseUrl,
              prefs: prefs,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DashboardProvider(
            DashboardService(baseUrl: AppConstants.apiBaseUrl),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => TransferProvider(
            TransferService(baseUrl: AppConstants.apiBaseUrl),
          ),
        ),
      ],
      child: MyApp(prefs: prefs),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

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
      initialRoute: RouteConstants.welcome,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
