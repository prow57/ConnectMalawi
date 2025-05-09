import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/auth_model.dart';
import '../../utilities/api_response.dart';

class AuthService {
  final http.Client _client;
  final String? baseUrl;
  final SharedPreferences _prefs;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  AuthService({
    required this.baseUrl,
    required SharedPreferences prefs,
  })  : _client = http.Client(),
        _prefs = prefs;

  // Mock user data for testing
  final Map<String, String> _mockUsers = {
    'test@example.com': 'password123',
    'user@example.com': 'password123',
  };

  Future<AuthResponse> login(LoginRequest request) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock successful login
      final mockResponse = AuthResponse(
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        user: User(
          id: '1',
          name: 'Demo User',
          email: request.phone,
          phone: request.phone,
          createdAt: DateTime.now(),
        ),
      );

      await _saveToken(mockResponse.token);
      return mockResponse;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock successful registration
      final mockResponse = AuthResponse(
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        user: User(
          id: '1',
          name: request.name,
          email: request.email,
          phone: request.phone,
          createdAt: DateTime.now(),
        ),
      );

      await _saveToken(mockResponse.token);
      return mockResponse;
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  Future<void> logout() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      await _clearToken();
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  Future<AuthResponse> checkAuth() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock successful auth check
      return AuthResponse(
        token: token,
        user: User(
          id: '1',
          name: 'Demo User',
          email: 'demo@example.com',
          phone: '+1234567890',
          createdAt: DateTime.now(),
        ),
      );
    } catch (e) {
      throw Exception('Failed to check auth: $e');
    }
  }

  Future<void> _saveToken(String token) async {
    await _prefs.setString('auth_token', token);
  }

  Future<String?> _getToken() async {
    return _prefs.getString('auth_token');
  }

  Future<void> _clearToken() async {
    await _prefs.remove('auth_token');
  }

  Future<UserModel> getCurrentUser(String token) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/auth/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else {
        throw Exception('Failed to get user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<ApiResponse<void>> sendOTP({
    required String identifier,
    bool isPhone = false,
    bool isPasswordReset = false,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.success(null);
  }

  Future<ApiResponse<void>> verifyOTP({
    required String identifier,
    required String otp,
    bool isPhone = false,
    bool isPasswordReset = false,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.success(null);
  }

  Future<ApiResponse<void>> resetPassword({
    required String identifier,
    required String otp,
    required String newPassword,
    bool isPhone = false,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return ApiResponse.success(null);
  }

  Future<void> saveUser(UserModel user) async {
    await _storage.write(key: _userKey, value: user.toJson().toString());
  }

  Future<UserModel?> getUser() async {
    final userData = await _storage.read(key: _userKey);
    if (userData != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(
        Map<String, dynamic>.from(userData as Map),
      ));
    }
    return null;
  }

  void dispose() {
    _client.close();
  }
}
