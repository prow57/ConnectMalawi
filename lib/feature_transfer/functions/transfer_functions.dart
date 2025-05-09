class TransferFunctions {
  static String formatCurrency(double amount) {
    return 'MK ${amount.toStringAsFixed(2)}';
  }

  static String formatPhoneNumber(String phone) {
    // Remove any non-digit characters
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    
    // Format as +265 XXXX XXXXX
    if (digitsOnly.length >= 9) {
      return '+265 ${digitsOnly.substring(0, 4)} ${digitsOnly.substring(4, 9)}';
    }
    return phone;
  }

  static String getTransferStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return '#4CAF50'; // Green
      case 'pending':
        return '#FFC107'; // Yellow
      case 'failed':
        return '#F44336'; // Red
      case 'cancelled':
        return '#9E9E9E'; // Grey
      default:
        return '#9E9E9E'; // Grey
    }
  }

  static String getTransferStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'assets/icons/check_circle.png';
      case 'pending':
        return 'assets/icons/pending.png';
      case 'failed':
        return 'assets/icons/error.png';
      case 'cancelled':
        return 'assets/icons/cancel.png';
      default:
        return 'assets/icons/transfer.png';
    }
  }

  static String getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 7) {
      return '${date.day}/${date.month}/${date.year}';
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

  static bool isValidPhoneNumber(String phone) {
    // Remove any non-digit characters
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length >= 9;
  }

  static bool isValidAmount(double amount) {
    return amount > 0;
  }

  static String getTransferFee(double amount) {
    // Example fee calculation: 1% of amount with minimum of MK 100
    final fee = amount * 0.01;
    return fee < 100 ? '100.00' : fee.toStringAsFixed(2);
  }

  static double calculateTotalAmount(double amount) {
    final fee = double.parse(getTransferFee(amount));
    return amount + fee;
  }
} 