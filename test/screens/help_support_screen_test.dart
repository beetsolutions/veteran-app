import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/help_support_screen.dart';

void main() {
  testWidgets('HelpSupportScreen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HelpSupportScreen(),
      ),
    );

    // Verify the screen title
    expect(find.text('Help & Support'), findsOneWidget);

    // Verify the main header
    expect(find.text('We\'re Here to Help'), findsOneWidget);

    // Verify section headers
    expect(find.text('Frequently Asked Questions'), findsOneWidget);
    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.text('Resources'), findsOneWidget);
  });

  testWidgets('HelpSupportScreen displays FAQ items', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HelpSupportScreen(),
      ),
    );

    // Verify FAQ questions are displayed
    expect(find.text('How do I update my profile?'), findsOneWidget);
    expect(find.text('How does the hosting rotation work?'), findsOneWidget);
    expect(find.text('How do I make a payment?'), findsOneWidget);
    expect(find.text('How do I enable notifications?'), findsOneWidget);
  });

  testWidgets('HelpSupportScreen displays contact options', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HelpSupportScreen(),
      ),
    );

    // Verify contact options
    expect(find.text('Email Support'), findsOneWidget);
    expect(find.text('support@veteranapp.org'), findsOneWidget);
    expect(find.text('Phone Support'), findsOneWidget);
    expect(find.text('+1 (555) 123-4567'), findsOneWidget);
    expect(find.text('Live Chat'), findsOneWidget);
  });

  testWidgets('HelpSupportScreen displays resource items', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HelpSupportScreen(),
      ),
    );

    // Verify resource items
    expect(find.text('User Guide'), findsOneWidget);
    expect(find.text('Documentation'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
  });

  testWidgets('FAQ items can be expanded', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HelpSupportScreen(),
      ),
    );

    // Initially, the answer should not be visible
    expect(
      find.text(
        'Navigate to the More tab and select Profile. From there, you can edit your information and save changes.',
      ),
      findsNothing,
    );

    // Tap to expand the FAQ item
    await tester.tap(find.text('How do I update my profile?'));
    await tester.pumpAndSettle();

    // Now the answer should be visible
    expect(
      find.text(
        'Navigate to the More tab and select Profile. From there, you can edit your information and save changes.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('HelpSupportScreen displays all required icons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HelpSupportScreen(),
      ),
    );

    // Verify main icon
    expect(find.byIcon(Icons.help_center), findsOneWidget);

    // Verify contact icons
    expect(find.byIcon(Icons.email), findsOneWidget);
    expect(find.byIcon(Icons.phone), findsOneWidget);
    expect(find.byIcon(Icons.chat_bubble), findsOneWidget);

    // Verify resource icons
    expect(find.byIcon(Icons.book), findsOneWidget);
    expect(find.byIcon(Icons.article), findsOneWidget);
    expect(find.byIcon(Icons.policy), findsOneWidget);
  });
}
