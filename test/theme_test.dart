import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/main.dart';
import 'package:veteranapp/providers/theme_provider.dart';

void main() {
  group('ThemeProvider Tests', () {
    test('ThemeProvider initial state is dark mode', () {
      final themeProvider = ThemeProvider();
      expect(themeProvider.themeMode, ThemeMode.dark);
      expect(themeProvider.isDarkMode, true);
    });

    test('ThemeProvider toggleTheme switches between light and dark', () {
      final themeProvider = ThemeProvider();
      
      // Initially dark
      expect(themeProvider.themeMode, ThemeMode.dark);
      
      // Toggle to light
      themeProvider.toggleTheme();
      expect(themeProvider.themeMode, ThemeMode.light);
      expect(themeProvider.isDarkMode, false);
      
      // Toggle back to dark
      themeProvider.toggleTheme();
      expect(themeProvider.themeMode, ThemeMode.dark);
      expect(themeProvider.isDarkMode, true);
    });

    test('ThemeProvider setTheme sets the theme mode', () {
      final themeProvider = ThemeProvider();
      
      themeProvider.setTheme(ThemeMode.light);
      expect(themeProvider.themeMode, ThemeMode.light);
      
      themeProvider.setTheme(ThemeMode.dark);
      expect(themeProvider.themeMode, ThemeMode.dark);
    });

    test('ThemeProvider setDarkMode sets dark or light mode', () {
      final themeProvider = ThemeProvider();
      
      themeProvider.setDarkMode(false);
      expect(themeProvider.themeMode, ThemeMode.light);
      expect(themeProvider.isDarkMode, false);
      
      themeProvider.setDarkMode(true);
      expect(themeProvider.themeMode, ThemeMode.dark);
      expect(themeProvider.isDarkMode, true);
    });

    test('ThemeProvider notifies listeners on theme change', () {
      final themeProvider = ThemeProvider();
      var notified = false;
      
      themeProvider.addListener(() {
        notified = true;
      });
      
      themeProvider.toggleTheme();
      expect(notified, true);
    });
  });

  group('App Theme Integration Tests', () {
    testWidgets('VeteranApp uses theme provider correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const VeteranApp());
      
      // Verify the app is initialized with dark theme
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.themeMode, ThemeMode.dark);
    });

    testWidgets('VeteranApp has both light and dark themes defined', (WidgetTester tester) async {
      await tester.pumpWidget(const VeteranApp());
      
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, isNotNull);
      expect(materialApp.darkTheme, isNotNull);
      
      // Verify light theme has light brightness
      expect(materialApp.theme!.brightness, Brightness.light);
      
      // Verify dark theme has dark brightness
      expect(materialApp.darkTheme!.brightness, Brightness.dark);
    });
  });
}
