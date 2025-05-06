import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToReplacement(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigateToAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }

  void goToHome() {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      AppConstants.routeHome,
      (route) => false,
    );
  }

  void goToLogin() {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
      AppConstants.routeLogin,
      (route) => false,
    );
  }
}
