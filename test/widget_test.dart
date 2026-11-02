import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ridemaxxing_client/main.dart';
import 'package:ridemaxxing_client/widgets/ride_bottom_navigation.dart';

void main() {
  testWidgets('bottom navigation switches between home and profile', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(437, 752);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);

    final logo = await rootBundle.load('assets/images/Route66.png');
    expect(logo.lengthInBytes, greaterThan(0));

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Where To?'), findsOneWidget);
    final bottomNavigation = find.byType(RideBottomNavigation);
    expect(
      find.descendant(of: bottomNavigation, matching: find.text('Home')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: bottomNavigation, matching: find.text('Trip')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: bottomNavigation, matching: find.text('Settings')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: bottomNavigation, matching: find.text('profile')),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('profile'));
    await tester.pumpAndSettle();

    expect(find.text('Walter W.'), findsOneWidget);
    expect(find.text('Trip'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(RideBottomNavigation),
        matching: find.text('Home'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(RideBottomNavigation),
        matching: find.text('profile'),
      ),
      findsOneWidget,
    );
    expect(find.text('Saved places'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Where To?'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
