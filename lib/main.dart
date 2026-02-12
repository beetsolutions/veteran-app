import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'providers/feature_flags_provider.dart';
import 'data/services/auth_service.dart';

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
  final UserProvider _userProvider = UserProvider();
  final FeatureFlagsProvider _featureFlagsProvider = FeatureFlagsProvider();
  final AuthService _authService = AuthService();
  bool _isCheckingAuth = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final isAuthenticated = await _authService.isAuthenticated();
    setState(() {
      _isAuthenticated = isAuthenticated;
      _isCheckingAuth = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _themeProvider),
        ChangeNotifierProvider.value(value: _userProvider),
        ChangeNotifierProvider.value(value: _featureFlagsProvider),
      ],
      child: AnimatedBuilder(
        animation: _themeProvider,
        builder: (context, child) {
          return ThemeProviderWidget(
            themeProvider: _themeProvider,
            child: MaterialApp(
              title: 'VeteranApp',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
                brightness: Brightness.light,
                primaryColor: Colors.deepPurple,
                scaffoldBackgroundColor: Colors.grey[50],
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
                cardTheme: CardThemeData(
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
                scaffoldBackgroundColor: Color(0xFF11111B),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF11111B),
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
                cardTheme: CardThemeData(
                  color: const Color(0xFF1E1E1E),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                useMaterial3: true,
              ),
              themeMode: _themeProvider.themeMode,
              home: _isCheckingAuth
                  ? const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : _isAuthenticated
                      ? const HomeScreen()
                      : const LoginScreen(),
            ),
          );
        },
      ),
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
