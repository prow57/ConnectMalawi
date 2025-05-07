import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nyasa_send/feature_auth/providers/auth_provider.dart';
import 'package:nyasa_send/feature_auth/services/auth_service.dart';
import 'core/navigation/app_router.dart';
import 'constants/route_constants.dart';
import 'constants/app_constants.dart';
import 'constants/theme_constants.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            authService: AuthService(),
            secureStorage: const FlutterSecureStorage(),
          ),
        ),
      ],
      child: MaterialApp(
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
                borderRadius:
                    BorderRadius.circular(ThemeConstants.borderRadiusM),
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
      ),
    );
  }
}
