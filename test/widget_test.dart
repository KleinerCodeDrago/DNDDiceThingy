import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:dnd_dice_thingy/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Dice Probability Calculator App', () {
    testWidgets('Default dice type is d20', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.text('d20'), findsOneWidget);
    });

    testWidgets('Can select different dice types', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('d20'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('d6').last);
      await tester.pumpAndSettle();

      expect(find.text('d6'), findsOneWidget);
    });

    testWidgets('Can enter custom dice type', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Non-standard Dice'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, '30');
      await tester.pumpAndSettle();

      expect(find.text('30'), findsOneWidget);
    });

    testWidgets('Can enter DC and modifier', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField).at(0), '15');
      await tester.enterText(find.byType(TextField).at(1), '2');
      await tester.pumpAndSettle();

      expect(find.text('15'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('Can toggle advantage and disadvantage',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.byType(SwitchListTile).at(0));
      await tester.pumpAndSettle();
      expect(find.text('Advantage'), findsOneWidget);

      await tester.tap(find.byType(SwitchListTile).at(1));
      await tester.pumpAndSettle();
      expect(find.text('Disadvantage'), findsOneWidget);
    });

    testWidgets('Calculates correct probability', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.enterText(find.byType(TextField).at(0), '15');
      await tester.enterText(find.byType(TextField).at(1), '2');
      await tester.pumpAndSettle();

      expect(find.text('80.00%'), findsOneWidget);
    });
  });
}
