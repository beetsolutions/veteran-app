import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/main.dart';
import 'package:veteranapp/screens/settings_screen.dart';

void main() {
  testWidgets('Theme can be toggled from Settings screen', (WidgetTester tester) async {
    // Build the full app
    await tester.pumpWidget(const VeteranApp());
    
    // Navigate through login to access settings
    // First, enter credentials and login
    await tester.enterText(find.byType(TextFormField).first, 'testuser');
    await tester.enterText(find.byType(TextFormField).last, 'password');
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();
    
    // Navigate to More tab where Settings is located
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    
    // Find and tap on Settings
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    
    // Verify we're on the settings screen
    expect(find.text('Settings'), findsWidgets);
    expect(find.text('Dark Mode'), findsOneWidget);
    
    // Find the dark mode switch
    final darkModeSwitch = find.byWidgetPredicate(
      (widget) => widget is SwitchListTile && 
                  widget.title is Text && 
                  (widget.title as Text).data == 'Dark Mode',
    );
    
    expect(darkModeSwitch, findsOneWidget);
    
    // Get the initial MaterialApp theme mode (should be dark)
    MaterialApp materialApp = tester.widget(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
    
    // Tap the dark mode switch
    await tester.tap(darkModeSwitch);
    await tester.pumpAndSettle();
    
    // Verify theme changed to light
    materialApp = tester.widget(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.light);
    
    // Tap again to switch back to dark
    await tester.tap(darkModeSwitch);
    await tester.pumpAndSettle();
    
    // Verify theme changed back to dark
    materialApp = tester.widget(find.byType(MaterialApp));
    expect(materialApp.themeMode, ThemeMode.dark);
  });
}
