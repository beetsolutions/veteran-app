import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/widgets/stat_card.dart';

void main() {
  group('StatCard Widget Tests', () {
    testWidgets('StatCard displays title, value, and icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: 'Total Members',
              value: '150',
              icon: Icons.people,
              iconColor: Colors.blue,
            ),
          ),
        ),
      );

      expect(find.text('Total Members'), findsOneWidget);
      expect(find.text('150'), findsOneWidget);
      expect(find.byIcon(Icons.people), findsOneWidget);
    });

    testWidgets('StatCard applies correct styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: 'Account Balance',
              value: '\$25,000',
              icon: Icons.account_balance_wallet,
              iconColor: Colors.green,
            ),
          ),
        ),
      );

      final titleText = tester.widget<Text>(find.text('Account Balance'));
      expect(titleText.style?.fontSize, 14);
      expect(titleText.style?.color, Colors.grey);

      final valueText = tester.widget<Text>(find.text('\$25,000'));
      expect(valueText.style?.fontSize, 28);
      expect(valueText.style?.fontWeight, FontWeight.bold);
    });
  });
}
