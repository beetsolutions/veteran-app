# Responsive Container Implementation

## Overview

This implementation adds responsive container support to the VeteranApp, enabling adaptive layouts for mobile, tablet, and desktop devices.

## Components

### ResponsiveContainer Widget

A reusable container widget that automatically adapts padding and max-width based on screen size.

**Location**: `lib/widgets/responsive_container.dart`

**Breakpoints**:
- **Mobile**: < 600px - Full width with standard padding
- **Tablet**: 600-1200px - Constrained width with increased padding
- **Desktop**: > 1200px - Max width (default 1200px) with center alignment

### Usage

#### Basic Usage

```dart
import '../widgets/responsive_container.dart';

// Use default padding for all screen sizes
ResponsiveContainer(
  child: YourWidget(),
)
```

#### Custom Padding

```dart
// Customize padding for each breakpoint
ResponsiveContainer(
  mobilePadding: EdgeInsets.all(16.0),
  tabletPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
  desktopPadding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0),
  child: YourWidget(),
)
```

#### Custom Max Width

```dart
// Set a custom max width for larger screens (e.g., for forms)
ResponsiveContainer(
  maxWidth: 500,
  child: LoginForm(),
)
```

#### No Padding

```dart
// Use EdgeInsets.zero for screens that need full control
ResponsiveContainer(
  mobilePadding: EdgeInsets.zero,
  tabletPadding: EdgeInsets.zero,
  desktopPadding: EdgeInsets.zero,
  child: CustomLayoutWidget(),
)
```

## Helper Functions

### Screen Size Detection

```dart
// Check device type
if (isMobile(context)) {
  // Mobile-specific logic
}

if (isTablet(context)) {
  // Tablet-specific logic
}

if (isDesktop(context)) {
  // Desktop-specific logic
}
```

### Dynamic Padding

```dart
// Get responsive padding based on screen size
final padding = getResponsivePadding(
  context,
  mobile: EdgeInsets.all(16.0),
  tablet: EdgeInsets.all(32.0),
  desktop: EdgeInsets.all(48.0),
);
```

## Screens Updated

The following screens have been updated to use the responsive container:

1. **LoginScreen** - Form constrained to 500px max width
2. **ProfileScreen** - Full-width header with responsive content padding
3. **HomeTab** - Responsive padding for statistics and content cards
4. **MembersTab** - Centered list with responsive max-width
5. **MoreTab** - Menu items centered on larger screens
6. **ActivityStatisticsScreen** - Statistics grid with responsive spacing
7. **SettingsScreen** - Settings list centered on larger screens

## Testing

Unit tests are located at `test/widgets/responsive_container_test.dart` and cover:

- Mobile, tablet, and desktop padding behavior
- Custom padding overrides
- Max width constraints
- Helper functions (isMobile, isTablet, isDesktop, getResponsivePadding)

## Benefits

1. **Consistent Layout**: All screens now follow the same responsive patterns
2. **Improved Readability**: Content is constrained on large screens for better readability
3. **Better UX**: Appropriate padding and spacing for each device type
4. **Easy to Use**: Simple API that can be applied to any screen
5. **Maintainable**: Centralized responsive logic in one reusable widget

## Future Enhancements

Potential improvements for future iterations:

- Add landscape-specific breakpoints
- Support for custom breakpoint values per screen
- Add orientation-aware responsive behavior
- Create responsive grid layouts for card-based content
