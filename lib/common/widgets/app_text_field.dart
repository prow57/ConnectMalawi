import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/theme_constants.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      maxLength: maxLength,
      enabled: enabled,
      focusNode: focusNode,
      onTap: onTap,
      readOnly: readOnly,
      style: ThemeConstants.body1,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: ThemeConstants.spacingM,
              vertical: ThemeConstants.spacingM,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
          borderSide: const BorderSide(
            color: ThemeConstants.textSecondaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
          borderSide: const BorderSide(
            color: ThemeConstants.textSecondaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
          borderSide: const BorderSide(
            color: ThemeConstants.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
          borderSide: const BorderSide(
            color: ThemeConstants.errorColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.borderRadiusM),
          borderSide: const BorderSide(
            color: ThemeConstants.errorColor,
          ),
        ),
        filled: true,
        fillColor: enabled
            ? ThemeConstants.surfaceColor
            : ThemeConstants.backgroundColor,
      ),
    );
  }
}
