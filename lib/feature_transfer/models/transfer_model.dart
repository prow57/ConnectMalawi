class TransferModel {
  final String id;
  final String senderId;
  final String recipientId;
  final String recipientName;
  final String recipientPhone;
  final double amount;
  final String description;
  final String status; // 'pending', 'completed', 'failed'
  final DateTime createdAt;
  final DateTime? completedAt;

  TransferModel({
    required this.id,
    required this.senderId,
    required this.recipientId,
    required this.recipientName,
    required this.recipientPhone,
    required this.amount,
    required this.description,
    required this.status,
    required this.createdAt,
    this.completedAt,
  });

  factory TransferModel.fromJson(Map<String, dynamic> json) {
    return TransferModel(
      id: json['id'] as String,
      senderId: json['sender_id'] as String,
      recipientId: json['recipient_id'] as String,
      recipientName: json['recipient_name'] as String,
      recipientPhone: json['recipient_phone'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender_id': senderId,
      'recipient_id': recipientId,
      'recipient_name': recipientName,
      'recipient_phone': recipientPhone,
      'amount': amount,
      'description': description,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  TransferModel copyWith({
    String? id,
    String? senderId,
    String? recipientId,
    String? recipientName,
    String? recipientPhone,
    double? amount,
    String? description,
    String? status,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return TransferModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId,
      recipientName: recipientName ?? this.recipientName,
      recipientPhone: recipientPhone ?? this.recipientPhone,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

class TransferRequestModel {
  final String recipientPhone;
  final double amount;
  final String description;

  TransferRequestModel({
    required this.recipientPhone,
    required this.amount,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'recipient_phone': recipientPhone,
      'amount': amount,
      'description': description,
    };
  }
}

class TransferResponseModel {
  final TransferModel transfer;
  final double newBalance;
  final String message;

  TransferResponseModel({
    required this.transfer,
    required this.newBalance,
    required this.message,
  });

  factory TransferResponseModel.fromJson(Map<String, dynamic> json) {
    return TransferResponseModel(
      transfer: TransferModel.fromJson(json['transfer'] as Map<String, dynamic>),
      newBalance: (json['new_balance'] as num).toDouble(),
      message: json['message'] as String,
    );
  }
} 