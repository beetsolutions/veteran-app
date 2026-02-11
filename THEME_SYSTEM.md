# Theme System Documentation

## Overview
The Veteran App now supports both **dark** and **light** themes that users can switch between via the Settings screen.

## How It Works

### Theme Provider
The app uses a custom `ThemeProvider` class that extends Flutter's `ChangeNotifier` to manage theme state:

- **Location**: `lib/providers/theme_provider.dart`
- **Default**: Dark mode
- **Methods**:
  - `toggleTheme()` - Switches between light and dark
  - `setTheme(ThemeMode)` - Sets a specific theme mode
  - `setDarkMode(bool)` - Convenience method for boolean toggle
  - `isDarkMode` - Getter to check current theme

### App Integration
The theme is integrated into the app through:

1. **main.dart**: Uses `AnimatedBuilder` to listen to theme changes and rebuild the MaterialApp with the new theme
2. **ThemeProviderWidget**: An `InheritedWidget` that provides the theme provider to the entire widget tree
3. **Settings Screen**: Connected to the theme provider via the dark mode toggle switch

### Theme Definitions

#### Light Theme
- Primary color: Blue
- Background: Light grey (`Colors.grey[50]`)
- Cards: White with elevation
- AppBar: Blue with white text

#### Dark Theme
- Primary color: Spotify green (`#1DB954`)
- Background: Black
- Cards: Dark grey (`#1E1E1E`) with elevation
- AppBar: Dark grey (`#121212`) with white text

## How to Use

### For Users
1. Navigate to **Settings** (accessible from the More tab)
2. Toggle the **Dark Mode** switch
3. The app will immediately update to reflect the chosen theme

### For Developers

#### Accessing Theme in Widgets
```dart
// Get current theme brightness
final isDark = Theme.of(context).brightness == Brightness.dark;

// Get theme colors
final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
final primaryColor = Theme.of(context).primaryColor;
```

#### Accessing Theme Provider
```dart
import 'package:veteranapp/main.dart';

// In a widget's build method
final themeProvider = ThemeProviderWidget.of(context);

// Check if dark mode
if (themeProvider?.isDarkMode ?? true) {
  // Dark mode specific code
}

// Toggle theme
themeProvider?.toggleTheme();
```

#### Best Practices
1. **Use theme colors instead of hardcoded colors** wherever possible:
   - Use `Theme.of(context).textTheme.bodyLarge?.color` for text colors
   - Use `Theme.of(context).primaryColor` for accent colors
   - Use `Theme.of(context).scaffoldBackgroundColor` for backgrounds

2. **Conditional styling** when necessary:
   ```dart
   final isDark = Theme.of(context).brightness == Brightness.dark;
   final color = isDark ? Colors.white : Colors.black87;
   ```

3. **Test both themes** when creating new screens or widgets

## Testing

The theme system includes comprehensive tests:

- **test/theme_test.dart**: Unit tests for ThemeProvider
- **test/theme_integration_test.dart**: Integration test for theme switching
- **test/settings_screen_test.dart**: Tests for the settings toggle

Run tests with:
```bash
flutter test
```

## Future Enhancements

Potential improvements for the theme system:

1. **Persist theme preference**: Save user's theme choice to local storage
2. **System theme detection**: Follow the device's system theme by default
3. **Multiple themes**: Add more color schemes (e.g., blue, green, purple)
4. **Custom themes**: Allow users to create custom color schemes
5. **Theme preview**: Show preview of theme before applying

## Files Modified

- `lib/main.dart` - Theme provider integration
- `lib/providers/theme_provider.dart` - Theme state management (new)
- `lib/screens/settings_screen.dart` - Theme toggle functionality
- `lib/screens/login_screen.dart` - Adapted to support both themes
- `test/theme_test.dart` - Theme unit tests (new)
- `test/theme_integration_test.dart` - Theme integration tests (new)
- `test/settings_screen_test.dart` - Updated for theme integration
