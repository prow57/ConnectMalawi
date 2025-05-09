class DashboardStats {
  final double balance;
  final int totalTransfers;
  final int pendingTransfers;
  final double totalSpent;
  final double totalReceived;

  DashboardStats({
    required this.balance,
    required this.totalTransfers,
    required this.pendingTransfers,
    required this.totalSpent,
    required this.totalReceived,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      balance: (json['balance'] as num).toDouble(),
      totalTransfers: json['total_transfers'] as int,
      pendingTransfers: json['pending_transfers'] as int,
      totalSpent: (json['total_spent'] as num).toDouble(),
      totalReceived: (json['total_received'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'total_transfers': totalTransfers,
      'pending_transfers': pendingTransfers,
      'total_spent': totalSpent,
      'total_received': totalReceived,
    };
  }
}

class RecentActivity {
  final String id;
  final String type; // 'transfer', 'deposit', 'withdrawal'
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final String status;

  RecentActivity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.status,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status,
    };
  }
}

class DashboardModel {
  final DashboardStats stats;
  final List<RecentActivity> recentActivities;

  DashboardModel({
    required this.stats,
    required this.recentActivities,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      stats: DashboardStats.fromJson(json['stats'] as Map<String, dynamic>),
      recentActivities: (json['recent_activities'] as List)
          .map((e) => RecentActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stats': stats.toJson(),
      'recent_activities': recentActivities.map((e) => e.toJson()).toList(),
    };
  }
}

class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String message;
  final DateTime date;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.date,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      date: DateTime.parse(json['date'] as String),
      isRead: json['is_read'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'message': message,
      'date': date.toIso8601String(),
      'is_read': isRead,
    };
  }
}

class QuickActionModel {
  final String id;
  final String title;
  final String icon;
  final String route;

  QuickActionModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
  });

  factory QuickActionModel.fromJson(Map<String, dynamic> json) {
    return QuickActionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: json['icon'] as String,
      route: json['route'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'route': route,
    };
  }
}

class TransactionModel {
  final String id;
  final String type;
  final String description;
  final double amount;
  final DateTime date;
  final String status;

  TransactionModel({
    required this.id,
    required this.type,
    required this.description,
    required this.amount,
    required this.date,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'status': status,
    };
  }
}
