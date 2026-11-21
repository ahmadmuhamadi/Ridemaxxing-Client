import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

String? validateEmail(String? value) {
  final email = value?.trim() ?? '';
  return email.contains('@') && email.contains('.')
      ? null
      : 'Enter a valid email address.';
}

String? validatePassword(String? value) =>
    (value?.length ?? 0) >= 6 ? null : 'Use at least 6 characters.';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffix,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: colors.primary),
        suffixIcon: suffix,
        filled: true,
        fillColor: colors.bg,
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
      ),
    );
  }
}

class AuthErrorMessage extends StatelessWidget {
  const AuthErrorMessage(this.message, {super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        message!,
        style: TextStyle(
          fontFamily: 'WorkSans',
          color: context.colors.danger,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    required this.label,
    required this.isBusy,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool isBusy;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: 54,
      child: FilledButton(
        onPressed: isBusy ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        child: isBusy
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colors.onPrimary,
                ),
              )
            : Text(label),
      ),
    );
  }
}

class AuthModeSwitch extends StatelessWidget {
  const AuthModeSwitch({
    required this.label,
    required this.isBusy,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool isBusy;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: isBusy ? null : onPressed,
    child: Text(
      label,
      style: TextStyle(
        fontFamily: 'WorkSans',
        fontWeight: FontWeight.w700,
        color: context.colors.ink,
      ),
    ),
  );
}
