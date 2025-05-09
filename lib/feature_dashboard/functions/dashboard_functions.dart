class DashboardFunctions {
  static String formatCurrency(double amount) {
    return 'MK ${amount.toStringAsFixed(2)}';
  }

  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  static String getTransactionTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'credit':
        return 'assets/icons/credit.png';
      case 'debit':
        return 'assets/icons/debit.png';
      default:
        return 'assets/icons/transaction.png';
    }
  }

  static String getTransactionStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return '#4CAF50'; // Green
      case 'pending':
        return '#FFC107'; // Yellow
      case 'failed':
        return '#F44336'; // Red
      default:
        return '#9E9E9E'; // Grey
    }
  }

  static String getNotificationTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'transaction':
        return 'assets/icons/transaction.png';
      case 'system':
        return 'assets/icons/system.png';
      case 'promo':
        return 'assets/icons/promo.png';
      default:
        return 'assets/icons/notification.png';
    }
  }

  static String getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return formatDate(date);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
