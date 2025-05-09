import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transfer_model.dart';
import '../../constants/app_constants.dart';
import '../../utilities/api_response.dart';

class TransferService {
  final http.Client _client;
  final String? baseUrl;

  TransferService({this.baseUrl}) : _client = http.Client();

  Future<TransferResponseModel> transfer(TransferRequestModel request) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/transfers'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TransferResponseModel.fromJson(data);
      } else {
        throw Exception('Failed to transfer: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to transfer: $e');
    }
  }

  Future<List<TransferModel>> getTransferHistory() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/transfers'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => TransferModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get transfer history: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to get transfer history: $e');
    }
  }

  Future<TransferModel> getTransferDetails(String transferId) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/transfers/$transferId'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TransferModel.fromJson(data);
      } else {
        throw Exception('Failed to get transfer details: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to get transfer details: $e');
    }
  }

  Future<void> cancelTransfer(String transferId) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/transfers/$transferId/cancel'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to cancel transfer: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to cancel transfer: $e');
    }
  }

  void dispose() {
    _client.close();
  }
} 