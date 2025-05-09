import 'package:flutter/material.dart';
import '../models/dashboard_model.dart';
import '../../constants/theme_constants.dart';

class QuickActionItem extends StatelessWidget {
  final QuickActionModel action;
  final VoidCallback? onTap;

  const QuickActionItem({
    super.key,
    required this.action,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(ThemeConstants.spacingM),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(ThemeConstants.spacingM),
              decoration: BoxDecoration(
                color: ThemeConstants.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                action.icon,
                width: 32,
                height: 32,
              ),
            ),
            const SizedBox(height: ThemeConstants.spacingS),
            Text(
              action.title,
              style: ThemeConstants.body2.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 