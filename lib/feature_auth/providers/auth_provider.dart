import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../data/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;
  final FlutterSecureStorage _secureStorage;
  bool _isLoading = false;
  String? _error;

  AuthProvider({
    required AuthService authService,
    required FlutterSecureStorage secureStorage,
  })  : _authService = authService,
        _secureStorage = secureStorage;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> login(String identifier, String password, {bool useBiometric = false}) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final token = await _authService.login(identifier, password);
      await _secureStorage.write(key: 'auth_token', value: token);
      
      if (useBiometric) {
        await _secureStorage.write(key: 'use_biometric', value: 'true');
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> register(String name, String identifier, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final token = await _authService.register(name, identifier, password);
      await _secureStorage.write(key: 'auth_token', value: token);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> sendOTP(String identifier) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.sendOTP(identifier);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> verifyRegistrationOTP(String identifier, String otp) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.verifyRegistrationOTP(identifier, otp);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> verifyPasswordResetOTP(String identifier, String otp) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.verifyPasswordResetOTP(identifier, otp);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> resetPassword(String identifier, String otp, String newPassword) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _authService.resetPassword(identifier, otp, newPassword);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _secureStorage.delete(key: 'auth_token');
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.read(key: 'auth_token');
    return token != null;
  }

  Future<bool> shouldUseBiometric() async {
    final useBiometric = await _secureStorage.read(key: 'use_biometric');
    return useBiometric == 'true';
  }
}
