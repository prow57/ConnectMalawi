import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utilities/api_response.dart';
import '../../constants/app_constants.dart';

class AuthService {
  final String baseUrl;
  final http.Client _client = http.Client();

  AuthService({required this.baseUrl});

  Future<ApiResponse<String>> login({
    required String identifier,
    required String password,
    bool isPhone = false,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          if (isPhone) 'phone' else 'email': identifier,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse.success(
          data['token'],
          message: 'Login successful',
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          'Login failed: ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Login failed: $e');
    }
  }

  Future<ApiResponse<String>> register({
    required String name,
    required String identifier,
    required String password,
    bool isPhone = false,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          if (isPhone) 'phone' else 'email': identifier,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return ApiResponse.success(
          'Registration successful',
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          'Registration failed: ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Registration failed: $e');
    }
  }

  Future<ApiResponse<String>> sendOTP({
    required String identifier,
    bool isPhone = false,
    bool isPasswordReset = false,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          if (isPhone) 'phone' else 'email': identifier,
          'isPasswordReset': isPasswordReset,
        }),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(
          'OTP sent successfully',
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          'Failed to send OTP: ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Failed to send OTP: $e');
    }
  }

  Future<ApiResponse<String>> verifyOTP({
    required String identifier,
    required String otp,
    bool isPhone = false,
    bool isPasswordReset = false,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          if (isPhone) 'phone' else 'email': identifier,
          'otp': otp,
          'isPasswordReset': isPasswordReset,
        }),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(
          'OTP verified successfully',
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          'OTP verification failed: ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('OTP verification failed: $e');
    }
  }

  Future<ApiResponse<String>> resetPassword({
    required String identifier,
    required String otp,
    required String newPassword,
    bool isPhone = false,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          if (isPhone) 'phone' else 'email': identifier,
          'otp': otp,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return ApiResponse.success(
          'Password reset successful',
          statusCode: response.statusCode,
        );
      } else {
        return ApiResponse.error(
          'Password reset failed: ${response.body}',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse.error('Password reset failed: $e');
    }
  }

  void dispose() {
    _client.close();
  }
} 