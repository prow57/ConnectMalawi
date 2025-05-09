class AuthFunctions {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    // Remove any non-digit characters
    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    return digitsOnly.length >= 9;
  }

  static bool isValidPassword(String password) {
    // Password must be at least 6 characters long
    return password.length >= 6;
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

  static String getInitials(String name) {
    if (name.isEmpty) return '';

    final nameParts = name.split(' ');
    if (nameParts.length == 1) {
      return nameParts[0].substring(0, 1).toUpperCase();
    }

    return '${nameParts[0].substring(0, 1)}${nameParts[1].substring(0, 1)}'
        .toUpperCase();
  }

  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
