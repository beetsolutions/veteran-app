import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/providers/feature_flags_provider.dart';
import 'package:veteranapp/models/feature_flags.dart';

void main() {
  group('FeatureFlagsProvider Tests', () {
    test('FeatureFlagsProvider initializes with default feature flags', () {
      final provider = FeatureFlagsProvider();

      expect(provider.featureFlags.showMinutesTab, true);
      expect(provider.featureFlags.showConstitutionTab, true);
    });

    test('updateFeatureFlags updates the feature flags', () {
      final provider = FeatureFlagsProvider();

      const newFlags = FeatureFlags(
        showMinutesTab: false,
        showConstitutionTab: false,
      );

      provider.updateFeatureFlags(newFlags);

      expect(provider.featureFlags.showMinutesTab, false);
      expect(provider.featureFlags.showConstitutionTab, false);
    });

    test('toggleMinutesTab toggles minutes tab visibility', () {
      final provider = FeatureFlagsProvider();

      expect(provider.featureFlags.showMinutesTab, true);

      provider.toggleMinutesTab();
      expect(provider.featureFlags.showMinutesTab, false);

      provider.toggleMinutesTab();
      expect(provider.featureFlags.showMinutesTab, true);
    });

    test('toggleConstitutionTab toggles constitution tab visibility', () {
      final provider = FeatureFlagsProvider();

      expect(provider.featureFlags.showConstitutionTab, true);

      provider.toggleConstitutionTab();
      expect(provider.featureFlags.showConstitutionTab, false);

      provider.toggleConstitutionTab();
      expect(provider.featureFlags.showConstitutionTab, true);
    });

    test('setMinutesTabVisible sets minutes tab visibility', () {
      final provider = FeatureFlagsProvider();

      provider.setMinutesTabVisible(false);
      expect(provider.featureFlags.showMinutesTab, false);

      provider.setMinutesTabVisible(true);
      expect(provider.featureFlags.showMinutesTab, true);
    });

    test('setConstitutionTabVisible sets constitution tab visibility', () {
      final provider = FeatureFlagsProvider();

      provider.setConstitutionTabVisible(false);
      expect(provider.featureFlags.showConstitutionTab, false);

      provider.setConstitutionTabVisible(true);
      expect(provider.featureFlags.showConstitutionTab, true);
    });

    test('provider notifies listeners on changes', () {
      final provider = FeatureFlagsProvider();
      var notificationCount = 0;

      provider.addListener(() {
        notificationCount++;
      });

      provider.toggleMinutesTab();
      expect(notificationCount, 1);

      provider.toggleConstitutionTab();
      expect(notificationCount, 2);

      provider.setMinutesTabVisible(false);
      expect(notificationCount, 3);
    });
  });
}
