import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../constants/app_constants.dart';
import '../../utilities/api_response.dart';

class AuthService {
  final String baseUrl;
  final http.Client _client;

  AuthService({required this.baseUrl}) : _client = http.Client();

  Future<ApiResponse<String>> login({
    required String identifier,
    required String password,
    bool isPhone = false,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/login'),
        body: {
          'identifier': identifier,
          'password': password,
          'is_phone': isPhone.toString(),
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return ApiResponse.success(data['token']);
      }
      return ApiResponse.error(data['message'] ?? 'Login failed');
    } catch (e) {
      return ApiResponse.error(e.toString());
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
        body: {
          'name': name,
          'identifier': identifier,
          'password': password,
          'is_phone': isPhone.toString(),
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 201) {
        return ApiResponse.success(data['token']);
      }
      return ApiResponse.error(data['message'] ?? 'Registration failed');
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
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
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/send-otp'),
        body: {
          'identifier': identifier,
          'is_phone': isPhone.toString(),
          'is_password_reset': isPasswordReset.toString(),
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return ApiResponse.success(null);
      }
      return ApiResponse.error(data['message'] ?? 'Failed to send OTP');
    } catch (e) {
      return ApiResponse.error(e.toString());
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
        body: {
          'identifier': identifier,
          'otp': otp,
          'is_phone': isPhone.toString(),
          'is_password_reset': isPasswordReset.toString(),
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return ApiResponse.success(data['token']);
      }
      return ApiResponse.error(data['message'] ?? 'Failed to verify OTP');
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<void>> resetPassword({
    required String identifier,
    required String otp,
    required String newPassword,
    bool isPhone = false,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/reset-password'),
        body: {
          'identifier': identifier,
          'otp': otp,
          'new_password': newPassword,
          'is_phone': isPhone.toString(),
        },
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        return ApiResponse.success(null);
      }
      return ApiResponse.error(data['message'] ?? 'Failed to reset password');
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  void dispose() {
    _client.close();
  }
}
