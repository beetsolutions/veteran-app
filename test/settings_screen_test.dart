import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/settings_screen.dart';

void main() {
  testWidgets('Settings screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(),
      ),
    );

    // Verify that the screen title is displayed
    expect(find.text('Settings'), findsOneWidget);
    
    // Verify section headers
    expect(find.text('General'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Privacy'), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
    
    // Verify settings items are displayed
    expect(find.text('Dark Mode'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Enable Notifications'), findsOneWidget);
    expect(find.text('Email Notifications'), findsOneWidget);
    expect(find.text('Push Notifications'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Terms of Service'), findsOneWidget);
    expect(find.text('Delete Account'), findsOneWidget);
  });

  testWidgets('Settings screen has correct icons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(),
      ),
    );

    // Verify that icons are displayed
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    expect(find.byIcon(Icons.language), findsOneWidget);
    expect(find.byIcon(Icons.notifications), findsOneWidget);
    expect(find.byIcon(Icons.email), findsOneWidget);
    expect(find.byIcon(Icons.mobile_friendly), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);
    expect(find.byIcon(Icons.description), findsOneWidget);
    expect(find.byIcon(Icons.delete_outline), findsOneWidget);
  });

  testWidgets('Dark Mode toggle works', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(),
      ),
    );

    // Find the dark mode switch
    final darkModeSwitch = find.byWidgetPredicate(
      (widget) => widget is SwitchListTile && widget.title is Text && (widget.title as Text).data == 'Dark Mode',
    );
    
    expect(darkModeSwitch, findsOneWidget);
    
    // Verify the initial value is dark mode (true)
    SwitchListTile switchWidget = tester.widget(darkModeSwitch);
    expect(switchWidget.value, true);
  });

  testWidgets('Language dialog appears when language item is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(),
      ),
    );

    // Tap on Language item
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();

    // Verify dialog appears
    expect(find.text('Select Language'), findsOneWidget);
    expect(find.text('English'), findsWidgets);
    expect(find.text('Spanish'), findsOneWidget);
    expect(find.text('French'), findsOneWidget);
    expect(find.text('German'), findsOneWidget);
  });

  testWidgets('Delete account dialog appears when delete account is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(),
      ),
    );

    // Tap on Delete Account item
    await tester.tap(find.text('Delete Account'));
    await tester.pumpAndSettle();

    // Verify dialog appears
    expect(find.text('Are you sure you want to delete your account? This action cannot be undone.'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  });

  testWidgets('Settings screen is scrollable', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsScreen(),
      ),
    );

    // Verify the screen has a ListView
    expect(find.byType(ListView), findsOneWidget);
  });
}
