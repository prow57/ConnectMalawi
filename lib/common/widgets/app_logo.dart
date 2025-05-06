import 'package:flutter/material.dart';
import '../../constants/theme_constants.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({
    super.key,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: ThemeConstants.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.send,
          size: size * 0.6,
          color: Colors.white,
        ),
      ),
    );
  }
}
