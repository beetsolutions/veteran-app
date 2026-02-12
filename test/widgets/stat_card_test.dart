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
              iconColor: Colors.deepPurple,
            ),
          ),
        ),
      );

      expect(find.text('Total Members'), findsOneWidget);
      expect(find.text('150'), findsOneWidget);
      expect(find.byIcon(Icons.people), findsOneWidget);
    });

    testWidgets('StatCard applies correct styles for mobile', (WidgetTester tester) async {
      // Set mobile screen size
      await tester.binding.setSurfaceSize(const Size(400, 800));
      
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
      expect(titleText.style?.fontSize, 14); // Mobile font size
      expect(titleText.style?.color, Colors.grey);

      final valueText = tester.widget<Text>(find.text('\$25,000'));
      expect(valueText.style?.fontSize, 28); // Mobile font size
      expect(valueText.style?.fontWeight, FontWeight.bold);
      
      // Reset to avoid affecting other tests
      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('StatCard applies responsive styles for tablet', (WidgetTester tester) async {
      // Set tablet screen size
      await tester.binding.setSurfaceSize(const Size(768, 1024));
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: 'Total Members',
              value: '150',
              icon: Icons.people,
              iconColor: Colors.deepPurple,
            ),
          ),
        ),
      );

      final titleText = tester.widget<Text>(find.text('Total Members'));
      expect(titleText.style?.fontSize, 15); // Tablet font size

      final valueText = tester.widget<Text>(find.text('150'));
      expect(valueText.style?.fontSize, 32); // Tablet font size
      
      // Reset to avoid affecting other tests
      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('StatCard applies responsive styles for desktop', (WidgetTester tester) async {
      // Set desktop screen size
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatCard(
              title: 'Events This Month',
              value: '12',
              icon: Icons.event,
              iconColor: Colors.orange,
            ),
          ),
        ),
      );

      final titleText = tester.widget<Text>(find.text('Events This Month'));
      expect(titleText.style?.fontSize, 16); // Desktop font size

      final valueText = tester.widget<Text>(find.text('12'));
      expect(valueText.style?.fontSize, 36); // Desktop font size
      
      // Reset to avoid affecting other tests
      addTearDown(() => tester.binding.setSurfaceSize(null));
    });
  });
}
