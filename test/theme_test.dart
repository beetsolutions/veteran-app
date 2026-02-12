import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/main.dart';
import 'package:veteranapp/providers/theme_provider.dart';

void main() {
  group('ThemeProvider Tests', () {
    test('ThemeProvider initial state is system mode', () {
      final themeProvider = ThemeProvider();
      expect(themeProvider.themeMode, ThemeMode.system);
      // When in system mode, isDarkMode will return false since it only checks for explicit dark mode
      expect(themeProvider.isDarkMode, false);
    });

    test('ThemeProvider toggleTheme switches between light and dark', () {
      final themeProvider = ThemeProvider();
      
      // Initially system mode
      expect(themeProvider.themeMode, ThemeMode.system);
      
      // Toggle to light (from system)
      themeProvider.toggleTheme();
      expect(themeProvider.themeMode, ThemeMode.light);
      expect(themeProvider.isDarkMode, false);
      
      // Toggle to dark
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
      
      // Verify the app is initialized with system theme mode
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.themeMode, ThemeMode.system);
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
