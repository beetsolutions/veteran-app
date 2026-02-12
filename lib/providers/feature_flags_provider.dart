import 'package:flutter/foundation.dart';
import '../models/feature_flags.dart';

/// Provider for managing feature flags
class FeatureFlagsProvider extends ChangeNotifier {
  FeatureFlags _featureFlags = const FeatureFlags();

  /// Get the current feature flags
  FeatureFlags get featureFlags => _featureFlags;

  /// Update feature flags
  void updateFeatureFlags(FeatureFlags featureFlags) {
    _featureFlags = featureFlags;
    notifyListeners();
  }

  /// Toggle minutes tab visibility
  void toggleMinutesTab() {
    _featureFlags = _featureFlags.copyWith(
      showMinutesTab: !_featureFlags.showMinutesTab,
    );
    notifyListeners();
  }

  /// Toggle constitution tab visibility
  void toggleConstitutionTab() {
    _featureFlags = _featureFlags.copyWith(
      showConstitutionTab: !_featureFlags.showConstitutionTab,
    );
    notifyListeners();
  }

  /// Set minutes tab visibility
  void setMinutesTabVisible(bool visible) {
    _featureFlags = _featureFlags.copyWith(showMinutesTab: visible);
    notifyListeners();
  }

  /// Set constitution tab visibility
  void setConstitutionTabVisible(bool visible) {
    _featureFlags = _featureFlags.copyWith(showConstitutionTab: visible);
    notifyListeners();
  }
}
