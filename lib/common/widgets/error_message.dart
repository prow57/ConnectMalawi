import 'package:flutter/material.dart';
import '../../constants/theme_constants.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;

  const ErrorMessage({
    super.key,
    required this.message,
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon ?? Icons.error_outline,
          color: ThemeConstants.errorColor,
          size: 48,
        ),
        const SizedBox(height: ThemeConstants.spacingM),
        Text(
          message,
          style: ThemeConstants.body1.copyWith(
            color: ThemeConstants.errorColor,
          ),
          textAlign: TextAlign.center,
        ),
        if (onRetry != null) ...[
          const SizedBox(height: ThemeConstants.spacingM),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeConstants.errorColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ],
    );
  }
} 