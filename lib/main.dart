import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const VeteranApp());
}

class VeteranApp extends StatefulWidget {
  const VeteranApp({super.key});

  @override
  State<VeteranApp> createState() => _VeteranAppState();
}

class _VeteranAppState extends State<VeteranApp> {
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeProvider,
      builder: (context, child) {
        return ThemeProviderWidget(
          themeProvider: _themeProvider,
          child: MaterialApp(
            title: 'Veteran App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: Brightness.light,
              primaryColor: Colors.blue,
              scaffoldBackgroundColor: Colors.grey[50],
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              cardTheme: CardTheme(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF1DB954),
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF121212),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              cardTheme: CardTheme(
                color: const Color(0xFF1E1E1E),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              useMaterial3: true,
            ),
            themeMode: _themeProvider.themeMode,
            home: const LoginScreen(),
          ),
        );
      },
    );
  }
}

// InheritedWidget to provide theme provider to the widget tree
class ThemeProviderWidget extends InheritedWidget {
  final ThemeProvider themeProvider;

  const ThemeProviderWidget({
    super.key,
    required this.themeProvider,
    required super.child,
  });

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProviderWidget>()?.themeProvider;
  }

  @override
  bool updateShouldNotify(ThemeProviderWidget oldWidget) {
    return themeProvider.themeMode != oldWidget.themeProvider.themeMode;
  }
}
