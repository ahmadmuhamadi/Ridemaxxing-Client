import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridemaxxing_client/pages/results_page.dart';
import 'package:ridemaxxing_client/theme/app_theme.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  Future<void> pump(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        theme: appTheme(Brightness.light),
        home: const ResultsPage(
          from: 'Maple Ave',
          to: 'Downtown',
          time: TimeOfDay(hour: 8, minute: 0),
          seats: 1,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapChip(WidgetTester tester, String label) async {
    await tester.ensureVisible(find.text(label));
    await tester.pumpAndSettle();
    await tester.tap(find.text(label));
    await tester.pumpAndSettle();
  }

  testWidgets('shows header and ride count', (tester) async {
    await pump(tester);
    expect(find.text('Maple Ave to Downtown'), findsOneWidget);
    expect(find.text('5 rides heading your way'), findsOneWidget);
  });

  testWidgets('filters combine, empty state clears them', (tester) async {
    await pump(tester);
    await tapChip(tester, 'Pets OK');
    expect(find.text('2 rides heading your way'), findsOneWidget);

    await tapChip(tester, 'Women drivers');
    expect(find.text('No rides match'), findsOneWidget);

    await tester.tap(find.text('Clear filters'));
    await tester.pumpAndSettle();
    expect(find.text('5 rides heading your way'), findsOneWidget);
  });

  testWidgets('cheapest sort puts the lowest price first', (tester) async {
    await pump(tester);
    await tapChip(tester, 'Cheapest');
    final first = tester.getTopLeft(find.text('\$4')).dy;
    final other = tester.getTopLeft(find.text('\$6')).dy;
    expect(first, lessThan(other));
  });

  testWidgets('tapping a card opens ride details', (tester) async {
    await pump(tester);
    await tester.tap(find.text('Maple Ave and 5th to City Hall'));
    await tester.pumpAndSettle();
    expect(find.text('Ride details'), findsOneWidget);
  });
}
