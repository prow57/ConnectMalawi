import 'package:flutter/material.dart';
import '../models/dashboard_model.dart';
import '../services/dashboard_service.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardService _dashboardService;
  DashboardStats? _stats;
  List<RecentActivity> _recentActivities = [];
  bool _isLoading = false;
  String? _error;

  DashboardProvider(this._dashboardService);

  DashboardStats? get stats => _stats;
  List<RecentActivity> get recentActivities => _recentActivities;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadDashboard() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final stats = await _dashboardService.getDashboardStats();
      final activities = await _dashboardService.getRecentActivities();

      _stats = stats;
      _recentActivities = activities;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshDashboard() async {
    await loadDashboard();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
