import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'pages/auth_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'theme/app_theme.dart';
import 'widgets/rider_tab_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var firebaseReady = false;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseReady = true;
  } catch (error) {
    debugPrint('Firebase initialization failed: $error');
  }
  runApp(MyApp(firebaseReady: firebaseReady));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.firebaseReady, super.key});

  final bool firebaseReady;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideMaxxing',
      debugShowCheckedModeBanner: false,
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
      home: firebaseReady ? const AuthRouter() : const FirebaseSetupPage(),
    );
  }
}

class AuthRouter extends StatelessWidget {
  const AuthRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return StreamBuilder(
      stream: auth.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.data == null) return AuthPage(authService: auth);
        return RiderTabs(authService: auth);
      },
    );
  }
}

class FirebaseSetupPage extends StatelessWidget {
  const FirebaseSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      backgroundColor: c.bg,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.cloud_off_outlined, size: 48, color: c.primary),
              const SizedBox(height: 16),
              Text(
                'Connect Firebase to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Overpass',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: c.ink,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Run flutterfire configure for your Firebase project, then restart the app. Enable Email/Password Authentication and create a Firestore database.',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'WorkSans', color: c.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RiderTabs extends StatefulWidget {
  const RiderTabs({required this.authService, super.key});

  final AuthService authService;

  @override
  State<RiderTabs> createState() => _RiderTabsState();
}

class _RiderTabsState extends State<RiderTabs> {
  int _tab = 0;

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(
          onBack: () => Navigator.pop(context),
          onSignOut: () async {
            Navigator.pop(context);
            await widget.authService.signOut();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: RiderTabBar(
        current: _tab,
        onTap: (i) {
          if (i == 0 || i == 3) setState(() => _tab = i);
        },
      ),
      body: IndexedStack(
        index: _tab == 3 ? 1 : 0,
        children: [
          const HomePage(),
          ProfilePage(onOpenSettings: _openSettings),
        ],
      ),
    );
  }
}
