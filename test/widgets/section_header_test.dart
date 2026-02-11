import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/widgets/section_header.dart';

void main() {
  group('SectionHeader Widget Tests', () {
    testWidgets('SectionHeader displays title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(title: 'Latest News'),
          ),
        ),
      );

      expect(find.text('Latest News'), findsOneWidget);
    });

    testWidgets('SectionHeader displays Show All button when callback provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'Officials',
              onShowAllPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Show All'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('SectionHeader does not display Show All button when callback is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(title: 'Title Only'),
          ),
        ),
      );

      expect(find.text('Show All'), findsNothing);
      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('SectionHeader calls callback when Show All is pressed', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              title: 'Test',
              onShowAllPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show All'));
      expect(pressed, true);
    });
  });
}
