# Feature Flags Implementation

## Overview
This implementation adds feature flags to control the visibility of the Minutes and Constitution tabs in the veteran-app. Feature flags allow for dynamic control of tab visibility without code changes.

## Architecture

### Components

1. **FeatureFlags Model** (`lib/models/feature_flags.dart`)
   - Immutable model class containing boolean flags for each feature
   - Properties:
     - `showMinutesTab`: Controls Minutes tab visibility (default: true)
     - `showConstitutionTab`: Controls Constitution tab visibility (default: true)
   - Includes JSON serialization support for potential API integration

2. **FeatureFlagsProvider** (`lib/providers/feature_flags_provider.dart`)
   - Provider class for managing feature flag state
   - Methods:
     - `updateFeatureFlags(FeatureFlags)`: Update all flags at once
     - `toggleMinutesTab()`: Toggle minutes tab visibility
     - `toggleConstitutionTab()`: Toggle constitution tab visibility
     - `setMinutesTabVisible(bool)`: Set minutes tab visibility
     - `setConstitutionTabVisible(bool)`: Set constitution tab visibility

3. **HomeScreen Updates** (`lib/screens/home_screen.dart`)
   - Dynamically builds tab list based on feature flags
   - Ensures safe navigation when tabs are hidden
   - Always visible tabs: Home, Members, More
   - Conditional tabs: Constitution, Minutes

## Usage

### Setting Feature Flags

```dart
// Access the provider
final featureFlagsProvider = Provider.of<FeatureFlagsProvider>(context, listen: false);

// Toggle a tab
featureFlagsProvider.toggleMinutesTab();

// Set specific visibility
featureFlagsProvider.setConstitutionTabVisible(false);

// Update all flags at once
featureFlagsProvider.updateFeatureFlags(
  FeatureFlags(
    showMinutesTab: false,
    showConstitutionTab: true,
  ),
);
```

### Integrating with API

The FeatureFlags model includes JSON serialization, making it easy to fetch flags from an API:

```dart
// Example: Fetch from API
final response = await http.get(Uri.parse('https://api.example.com/feature-flags'));
final featureFlags = FeatureFlags.fromJson(json.decode(response.body));
featureFlagsProvider.updateFeatureFlags(featureFlags);
```

### Integrating with Settings Screen

You can add toggles to the settings screen to let users control tab visibility:

```dart
SwitchListTile(
  title: Text('Show Minutes Tab'),
  value: context.watch<FeatureFlagsProvider>().featureFlags.showMinutesTab,
  onChanged: (value) {
    context.read<FeatureFlagsProvider>().setMinutesTabVisible(value);
  },
),
```

## Testing

Comprehensive tests are included:

1. **Model Tests** (`test/models/feature_flags_test.dart`)
   - Tests for default values
   - Tests for copyWith functionality
   - Tests for JSON serialization/deserialization

2. **Provider Tests** (`test/providers/feature_flags_provider_test.dart`)
   - Tests for initialization
   - Tests for all update methods
   - Tests for listener notifications

3. **Integration Tests** (`test/screens/home_screen_test.dart`)
   - Tests for tab visibility with different flag combinations
   - Tests for navigation with hidden tabs
   - Tests for safe index handling

## Default Behavior

By default, all tabs are visible (all flags are set to `true`). This ensures backward compatibility and prevents any breaking changes to existing functionality.

## Future Enhancements

Potential future enhancements:
1. Persist feature flags to local storage
2. Fetch feature flags from backend API
3. Add more granular feature flags for other UI elements
4. Add feature flag analytics to track usage
5. Add admin panel for managing feature flags
