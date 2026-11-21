import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'auth_form_components.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.isBusy,
    required this.error,
    required this.onTogglePassword,
    required this.onSubmit,
    required this.onResetPassword,
    required this.onSwitchToRegistration,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool isBusy;
  final String? error;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;
  final VoidCallback onResetPassword;
  final VoidCallback onSwitchToRegistration;

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Welcome back',
          style: TextStyle(
            fontFamily: 'Overpass',
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: context.colors.ink,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Sign in to pick up where you left off.',
          style: TextStyle(
            fontFamily: 'WorkSans',
            fontSize: 15,
            color: context.colors.muted,
          ),
        ),
        const SizedBox(height: 22),
        AuthTextField(
          controller: emailController,
          label: 'Email',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
        ),
        const SizedBox(height: 14),
        AuthTextField(
          controller: passwordController,
          label: 'Password',
          icon: Icons.lock_outline,
          obscureText: obscurePassword,
          suffix: IconButton(
            tooltip: obscurePassword ? 'Show password' : 'Hide password',
            onPressed: onTogglePassword,
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: context.colors.muted,
            ),
          ),
          validator: validatePassword,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: isBusy ? null : onResetPassword,
            child: const Text('Forgot password?'),
          ),
        ),
        AuthErrorMessage(error),
        const SizedBox(height: 18),
        AuthSubmitButton(label: 'Sign in', isBusy: isBusy, onPressed: onSubmit),
        const SizedBox(height: 12),
        AuthModeSwitch(
          label: 'New here? Create an account',
          isBusy: isBusy,
          onPressed: onSwitchToRegistration,
        ),
      ],
    ),
  );
}
