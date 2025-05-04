import 'package:flutter/material.dart';
import '../../constants/theme_constants.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;
  final double size;
  final Color? color;

  const LoadingIndicator({
    super.key,
    this.message,
    this.size = 40,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: color ?? ThemeConstants.primaryColor,
            strokeWidth: 3,
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: ThemeConstants.spacingM),
          Text(
            message!,
            style: ThemeConstants.body1,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
} 