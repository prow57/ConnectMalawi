import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dashboard_model.dart';
import '../../constants/app_constants.dart';
import '../../utilities/api_response.dart';

class DashboardService {
  final http.Client _client;
  final String? baseUrl;

  DashboardService({this.baseUrl}) : _client = http.Client();

  Future<DashboardModel> getDashboardData() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock dashboard data
      return DashboardModel(
        stats: DashboardStats(
          balance: 50000.0,
          totalTransfers: 150,
          pendingTransfers: 5,
          totalSpent: 25000.0,
          totalReceived: 75000.0,
        ),
        recentActivities: [
          RecentActivity(
            id: '1',
            type: 'transfer',
            title: 'Money Transfer',
            description: 'Sent money to John Doe',
            amount: 1000.0,
            date: DateTime.now().subtract(const Duration(hours: 1)),
            status: 'completed',
          ),
          RecentActivity(
            id: '2',
            type: 'transfer',
            title: 'Money Transfer',
            description: 'Received money from Jane Smith',
            amount: 2000.0,
            date: DateTime.now().subtract(const Duration(hours: 2)),
            status: 'completed',
          ),
        ],
      );
    } catch (e) {
      throw Exception('Failed to load dashboard data: $e');
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw Exception('Failed to mark notification as read: $e');
    }
  }

  Future<void> clearAllNotifications() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw Exception('Failed to clear notifications: $e');
    }
  }

  Future<DashboardStats> getDashboardStats() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock dashboard stats
      return DashboardStats(
        balance: 50000.0,
        totalTransfers: 150,
        pendingTransfers: 5,
        totalSpent: 25000.0,
        totalReceived: 75000.0,
      );
    } catch (e) {
      throw Exception('Failed to get dashboard stats: $e');
    }
  }

  Future<List<RecentActivity>> getRecentActivities() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock recent activities
      return [
        RecentActivity(
          id: '1',
          type: 'transfer',
          title: 'Money Transfer',
          description: 'Sent money to John Doe',
          amount: 1000.0,
          date: DateTime.now().subtract(const Duration(hours: 1)),
          status: 'completed',
        ),
        RecentActivity(
          id: '2',
          type: 'transfer',
          title: 'Money Transfer',
          description: 'Received money from Jane Smith',
          amount: 2000.0,
          date: DateTime.now().subtract(const Duration(hours: 2)),
          status: 'completed',
        ),
      ];
    } catch (e) {
      throw Exception('Failed to get recent activities: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
