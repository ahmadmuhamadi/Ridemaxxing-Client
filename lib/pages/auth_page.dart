import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/login_form.dart';
import '../widgets/registration_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({required this.authService, super.key});

  final AuthService authService;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final _registrationFormKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _registering = false;
  bool _busy = false;
  bool _obscurePassword = true;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _switchMode(bool registering) {
    setState(() {
      _registering = registering;
      _error = null;
    });
  }

  Future<void> _submit() async {
    final formKey = _registering ? _registrationFormKey : _loginFormKey;
    if (!formKey.currentState!.validate()) return;

    await _performRequest(
      request: () => _registering
          ? widget.authService.register(
              name: _name.text,
              email: _email.text,
              password: _password.text,
            )
          : widget.authService.signIn(
              email: _email.text,
              password: _password.text,
            ),
      fallbackError: 'Could not complete your request. Please try again.',
    );
  }

  Future<void> _resetPassword() async {
    final email = _email.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      setState(() => _error = 'Enter your email address first.');
      return;
    }

    await _performRequest(
      request: () => widget.authService.sendPasswordReset(email),
      fallbackError: 'Could not send the reset email. Please try again.',
      onSuccess: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent.')),
      ),
    );
  }

  Future<void> _performRequest({
    required Future<void> Function() request,
    required String fallbackError,
    VoidCallback? onSuccess,
  }) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await request();
      if (mounted) onSuccess?.call();
    } on FirebaseAuthException catch (error) {
      if (mounted) setState(() => _error = _authMessage(error.code));
    } catch (_) {
      if (mounted) setState(() => _error = fallbackError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _authMessage(String code) => switch (code) {
    'invalid-email' => 'Enter a valid email address.',
    'user-not-found' ||
    'wrong-password' ||
    'invalid-credential' => 'Email or password is incorrect.',
    'email-already-in-use' => 'An account already uses this email.',
    'weak-password' => 'Choose a stronger password (at least 6 characters).',
    'network-request-failed' =>
      'Connection problem. Check your internet and retry.',
    _ => 'Authentication failed. Please try again.',
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 94,
                      height: 94,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: colors.gold, width: 2),
                      ),
                      child: Image.asset('assets/images/Route66.png'),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Ride\nmaxxing',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Rye',
                      fontSize: 28,
                      height: 1.1,
                      color: colors.ink,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: colors.edge, width: 1.5),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A211C19),
                          offset: Offset(0, 5),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: _registering
                        ? RegistrationForm(
                            formKey: _registrationFormKey,
                            nameController: _name,
                            emailController: _email,
                            passwordController: _password,
                            obscurePassword: _obscurePassword,
                            isBusy: _busy,
                            error: _error,
                            onTogglePassword: _togglePassword,
                            onSubmit: _submit,
                            onSwitchToLogin: () => _switchMode(false),
                          )
                        : LoginForm(
                            formKey: _loginFormKey,
                            emailController: _email,
                            passwordController: _password,
                            obscurePassword: _obscurePassword,
                            isBusy: _busy,
                            error: _error,
                            onTogglePassword: _togglePassword,
                            onSubmit: _submit,
                            onResetPassword: _resetPassword,
                            onSwitchToRegistration: () => _switchMode(true),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePassword() {
    setState(() => _obscurePassword = !_obscurePassword);
  }
}
