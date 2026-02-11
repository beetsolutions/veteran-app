import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/models/official.dart';
import 'package:veteranapp/widgets/official_card.dart';

void main() {
  group('OfficialCard Widget Tests', () {
    const testOfficial = Official(
      name: 'John Doe',
      role: 'President',
      service: 'Army',
    );

    testWidgets('OfficialCard displays official information', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OfficialCard(official: testOfficial),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('President • Army'), findsOneWidget);
      expect(find.text('J'), findsOneWidget); // Initial in avatar
    });

    testWidgets('OfficialCard calls onTap when tapped', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OfficialCard(
              official: testOfficial,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ListTile));
      expect(tapped, true);
    });

    testWidgets('OfficialCard displays chevron icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OfficialCard(official: testOfficial),
          ),
        ),
      );

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });
  });
}
