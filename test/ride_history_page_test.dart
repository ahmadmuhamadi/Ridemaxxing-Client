import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridemaxxing_client/main.dart';
import 'package:ridemaxxing_client/pages/ride_history_page.dart';
import 'package:ridemaxxing_client/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  Future<void> pumpHistory(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme(Brightness.light),
        home: const RideHistoryPage(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows passenger trips newest first and expands details', (
    tester,
  ) async {
    await pumpHistory(tester);

    expect(find.text('My Trips'), findsOneWidget);
    expect(find.text('Maadi'), findsOneWidget);
    expect(find.text('Vehicle details'), findsNothing);

    final newest = tester.getTopLeft(find.text('Maadi')).dy;
    final older = tester.getTopLeft(find.text('New Cairo')).dy;
    expect(newest, lessThan(older));

    await tester.tap(find.text('Omar Hassan'));
    await tester.pumpAndSettle();

    expect(find.text('Vehicle details'), findsOneWidget);
    expect(find.text('ABC 4821'), findsOneWidget);
    expect(find.text('Visa •••• 2048'), findsOneWidget);
    expect(find.text('RM-28491'), findsOneWidget);
  });

  testWidgets('switches in place to driver rides and expands passengers', (
    tester,
  ) async {
    await pumpHistory(tester);

    await tester.tap(find.text('My Drives'));
    await tester.pumpAndSettle();

    expect(find.text('6th of October'), findsOneWidget);
    expect(find.text('3/4 Passengers'), findsNWidgets(2));
    expect(find.text('Passengers'), findsNothing);

    await tester.tap(find.text('6th of October'));
    await tester.pumpAndSettle();

    expect(find.text('Passengers'), findsOneWidget);
    expect(find.text('Salma Tarek'), findsOneWidget);
    expect(find.text('Youssef Ali'), findsOneWidget);
    expect(find.text('EGP 160'), findsOneWidget);
    expect(find.text('24.6 km'), findsOneWidget);
  });

  testWidgets('opens history from the Rides bottom navigation item', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Rides'));
    await tester.pumpAndSettle();

    expect(find.text('Ride history'), findsOneWidget);
    expect(find.text('My Trips'), findsOneWidget);
  });
}
