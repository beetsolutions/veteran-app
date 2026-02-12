# Feature Flags Quick Start Guide

## What Are Feature Flags?

Feature flags allow you to dynamically control which tabs are visible in the app without modifying code. This implementation adds flags for the **Minutes** and **Constitution** tabs.

## Default Behavior

By default, **all tabs are visible** (backward compatible):
- ✅ Home (always visible)
- ✅ Constitution (controlled by flag, default: visible)
- ✅ Members (always visible)
- ✅ Minutes (controlled by flag, default: visible)
- ✅ More (always visible)

## Quick Examples

### 1. Hide the Minutes Tab

```dart
import 'package:provider/provider.dart';
import 'package:veteranapp/providers/feature_flags_provider.dart';

// In your widget:
Provider.of<FeatureFlagsProvider>(context, listen: false)
  .setMinutesTabVisible(false);
```

Result: `Home | Constitution | Members | More`

### 2. Hide the Constitution Tab

```dart
Provider.of<FeatureFlagsProvider>(context, listen: false)
  .setConstitutionTabVisible(false);
```

Result: `Home | Members | Minutes | More`

### 3. Hide Both Minutes and Constitution Tabs

```dart
final provider = Provider.of<FeatureFlagsProvider>(context, listen: false);
provider.setMinutesTabVisible(false);
provider.setConstitutionTabVisible(false);
```

Result: `Home | Members | More`

### 4. Toggle a Tab

```dart
Provider.of<FeatureFlagsProvider>(context, listen: false)
  .toggleMinutesTab();
```

### 5. Update All Flags at Once

```dart
import 'package:veteranapp/models/feature_flags.dart';

final provider = Provider.of<FeatureFlagsProvider>(context, listen: false);
provider.updateFeatureFlags(
  FeatureFlags(
    showMinutesTab: false,
    showConstitutionTab: true,
  ),
);
```

## Adding UI Controls

### Settings Screen Example

Add switches to the settings screen to let users control tab visibility:

```dart
import 'package:provider/provider.dart';

// In your settings screen build method:
SwitchListTile(
  title: Text('Show Minutes Tab'),
  subtitle: Text('Display meeting minutes in navigation'),
  value: context.watch<FeatureFlagsProvider>().featureFlags.showMinutesTab,
  onChanged: (value) {
    context.read<FeatureFlagsProvider>().setMinutesTabVisible(value);
  },
),
SwitchListTile(
  title: Text('Show Constitution Tab'),
  subtitle: Text('Display organization constitution in navigation'),
  value: context.watch<FeatureFlagsProvider>().featureFlags.showConstitutionTab,
  onChanged: (value) {
    context.read<FeatureFlagsProvider>().setConstitutionTabVisible(value);
  },
),
```

## API Integration

### Fetch Flags from Backend

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:veteranapp/models/feature_flags.dart';

Future<void> fetchFeatureFlags(BuildContext context) async {
  try {
    final response = await http.get(
      Uri.parse('https://api.example.com/feature-flags'),
    );
    
    if (response.statusCode == 200) {
      final flags = FeatureFlags.fromJson(json.decode(response.body));
      context.read<FeatureFlagsProvider>().updateFeatureFlags(flags);
    }
  } catch (e) {
    print('Failed to fetch feature flags: $e');
  }
}
```

### Expected API Response

```json
{
  "showMinutesTab": true,
  "showConstitutionTab": false
}
```

## Persisting Flags to Local Storage

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class FeatureFlagsService {
  final _storage = FlutterSecureStorage();
  static const _key = 'feature_flags';

  Future<void> saveFlags(FeatureFlags flags) async {
    await _storage.write(
      key: _key,
      value: json.encode(flags.toJson()),
    );
  }

  Future<FeatureFlags?> loadFlags() async {
    final value = await _storage.read(key: _key);
    if (value != null) {
      return FeatureFlags.fromJson(json.decode(value));
    }
    return null;
  }
}
```

## Testing

The implementation includes comprehensive tests. Run them with:

```bash
flutter test test/models/feature_flags_test.dart
flutter test test/providers/feature_flags_provider_test.dart
flutter test test/screens/home_screen_test.dart
```

## Common Use Cases

1. **Beta Features**: Hide new tabs until they're ready for production
2. **User Preferences**: Let users customize which tabs they see
3. **A/B Testing**: Show different tabs to different user groups
4. **Gradual Rollout**: Enable features for a percentage of users
5. **Emergency Disable**: Quickly hide problematic features without deploying new code

## Safety Features

✅ **Safe Navigation**: If a user is on a tab that gets hidden, they're automatically redirected to the Home tab

✅ **Bounds Checking**: The app prevents crashes by validating tab indices

✅ **Default Visibility**: All tabs are visible by default, preventing accidental feature hiding

## Need Help?

- See `FEATURE_FLAGS_DOCUMENTATION.md` for detailed implementation docs
- See `FEATURE_FLAGS_SUMMARY.md` for the complete implementation summary
- Check the test files for usage examples

## Summary

This feature flag system is:
- ✅ Simple to use
- ✅ Well-tested (20 tests)
- ✅ Backward compatible
- ✅ Production-ready
- ✅ Extensible for future features
