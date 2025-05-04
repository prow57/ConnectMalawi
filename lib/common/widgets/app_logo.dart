import 'package:flutter/material.dart';
import '../../constants/theme_constants.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLogo({
    super.key,
    this.size = 120,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? ThemeConstants.primaryColor,
        shape: BoxShape.circle,
        boxShadow: ThemeConstants.cardShadow,
      ),
      child: Center(
        child: Text(
          'NS',
          style: ThemeConstants.heading1.copyWith(
            color: Colors.white,
            fontSize: size * 0.4,
          ),
        ),
      ),
    );
  }
}
