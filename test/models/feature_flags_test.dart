import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/models/feature_flags.dart';

void main() {
  group('FeatureFlags Model Tests', () {
    test('FeatureFlags can be created with default values', () {
      const featureFlags = FeatureFlags();

      expect(featureFlags.showMinutesTab, true);
      expect(featureFlags.showConstitutionTab, true);
    });

    test('FeatureFlags can be created with custom values', () {
      const featureFlags = FeatureFlags(
        showMinutesTab: false,
        showConstitutionTab: false,
      );

      expect(featureFlags.showMinutesTab, false);
      expect(featureFlags.showConstitutionTab, false);
    });

    test('FeatureFlags copyWith creates a new instance with updated values', () {
      const featureFlags = FeatureFlags(
        showMinutesTab: true,
        showConstitutionTab: true,
      );

      final updatedFlags = featureFlags.copyWith(showMinutesTab: false);

      expect(updatedFlags.showMinutesTab, false);
      expect(updatedFlags.showConstitutionTab, true);
      // Original should be unchanged
      expect(featureFlags.showMinutesTab, true);
    });

    test('FeatureFlags copyWith without parameters returns identical flags', () {
      const featureFlags = FeatureFlags(
        showMinutesTab: false,
        showConstitutionTab: true,
      );

      final copiedFlags = featureFlags.copyWith();

      expect(copiedFlags.showMinutesTab, featureFlags.showMinutesTab);
      expect(copiedFlags.showConstitutionTab, featureFlags.showConstitutionTab);
    });

    test('FeatureFlags fromJson parses JSON correctly', () {
      final json = {
        'showMinutesTab': false,
        'showConstitutionTab': true,
      };

      final featureFlags = FeatureFlags.fromJson(json);

      expect(featureFlags.showMinutesTab, false);
      expect(featureFlags.showConstitutionTab, true);
    });

    test('FeatureFlags fromJson uses defaults for missing values', () {
      final json = <String, dynamic>{};

      final featureFlags = FeatureFlags.fromJson(json);

      expect(featureFlags.showMinutesTab, true);
      expect(featureFlags.showConstitutionTab, true);
    });

    test('FeatureFlags toJson converts to JSON correctly', () {
      const featureFlags = FeatureFlags(
        showMinutesTab: false,
        showConstitutionTab: true,
      );

      final json = featureFlags.toJson();

      expect(json['showMinutesTab'], false);
      expect(json['showConstitutionTab'], true);
    });
  });
}
