import 'package:flutter/material.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  User? _user;
  String? _token;
  bool _isLoading = false;
  String? _error;

  AuthProvider(this._authService);

  User? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _token != null;

  Future<void> login({
    required String identifier,
    required String password,
    bool isPhone = true,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final request = LoginRequest(
        phone: identifier,
        password: password,
      );

      final response = await _authService.login(request);
      _user = response.user;
      _token = response.token;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register({
    required String name,
    required String identifier,
    required String password,
    bool isPhone = true,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final request = RegisterRequest(
        name: name,
        email: isPhone ? '' : identifier,
        phone: isPhone ? identifier : '',
        password: password,
      );

      final response = await _authService.register(request);
      _user = response.user;
      _token = response.token;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.logout();
      _user = null;
      _token = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkAuth() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _authService.checkAuth();
      _user = response.user;
      _token = response.token;
    } catch (e) {
      _error = e.toString();
      _user = null;
      _token = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> sendOTP({
    required String identifier,
    bool isPhone = false,
    bool isPasswordReset = false,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.sendOTP(
        identifier: identifier,
        isPhone: isPhone,
        isPasswordReset: isPasswordReset,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyPasswordResetOTP(String identifier, String otp) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.verifyOTP(
        identifier: identifier,
        otp: otp,
        isPasswordReset: true,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyOTP({
    required String identifier,
    required String otp,
    bool isPhone = false,
    bool isPasswordReset = false,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.verifyOTP(
        identifier: identifier,
        otp: otp,
        isPhone: isPhone,
        isPasswordReset: isPasswordReset,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetPassword({
    required String identifier,
    required String otp,
    required String newPassword,
    bool isPhone = false,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.resetPassword(
        identifier: identifier,
        otp: otp,
        newPassword: newPassword,
        isPhone: isPhone,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
