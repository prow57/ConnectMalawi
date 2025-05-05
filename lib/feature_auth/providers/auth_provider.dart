import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../constants/app_constants.dart';
import '../../utilities/api_response.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  final FlutterSecureStorage _secureStorage;
  bool _isLoading = false;
  String? _error;
  String? _token;

  AuthProvider({
    required AuthService authService,
    required FlutterSecureStorage secureStorage,
  })  : _authService = authService,
        _secureStorage = secureStorage;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get token => _token;
  bool get isAuthenticated => _token != null;

  Future<void> login({
    required String identifier,
    required String password,
    bool isPhone = false,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _authService.login(
      identifier: identifier,
      password: password,
      isPhone: isPhone,
    );

    _isLoading = false;
    if (response.hasError) {
      _error = response.message;
    } else {
      _token = response.data;
      await _secureStorage.write(
          key: AppConstants.storageTokenKey, value: _token);
    }
    notifyListeners();
  }

  Future<void> register({
    required String name,
    required String identifier,
    required String password,
    bool isPhone = false,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _authService.register(
      name: name,
      identifier: identifier,
      password: password,
      isPhone: isPhone,
    );

    _isLoading = false;
    if (response.hasError) {
      _error = response.message;
    }
    notifyListeners();
  }

  Future<void> sendOTP({
    required String identifier,
    bool isPhone = false,
    bool isPasswordReset = false,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _authService.sendOTP(
      identifier: identifier,
      isPhone: isPhone,
      isPasswordReset: isPasswordReset,
    );

    _isLoading = false;
    if (response.hasError) {
      _error = response.message;
    }
    notifyListeners();
  }

  Future<void> verifyOTP({
    required String identifier,
    required String otp,
    bool isPhone = false,
    bool isPasswordReset = false,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _authService.verifyOTP(
      identifier: identifier,
      otp: otp,
      isPhone: isPhone,
      isPasswordReset: isPasswordReset,
    );

    _isLoading = false;
    if (response.hasError) {
      _error = response.message;
    }
    notifyListeners();
  }

  Future<void> resetPassword(String s, {
    required String identifier,
    required String otp,
    required String newPassword,
    bool isPhone = false,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final response = await _authService.resetPassword(
      identifier: identifier,
      otp: otp,
      newPassword: newPassword,
      isPhone: isPhone,
    );

    _isLoading = false;
    if (response.hasError) {
      _error = response.message;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    await _secureStorage.delete(key: AppConstants.storageTokenKey);
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    _token = await _secureStorage.read(key: AppConstants.storageTokenKey);
    notifyListeners();
  }

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }

  verifyPasswordResetOTP(String s, String otp) {}
}
