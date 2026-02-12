/// Model for managing feature flags throughout the application
class FeatureFlags {
  final bool showMinutesTab;
  final bool showConstitutionTab;

  const FeatureFlags({
    this.showMinutesTab = true,
    this.showConstitutionTab = true,
  });

  /// Create a copy of this feature flags with updated fields
  FeatureFlags copyWith({
    bool? showMinutesTab,
    bool? showConstitutionTab,
  }) {
    return FeatureFlags(
      showMinutesTab: showMinutesTab ?? this.showMinutesTab,
      showConstitutionTab: showConstitutionTab ?? this.showConstitutionTab,
    );
  }

  /// Create from JSON
  factory FeatureFlags.fromJson(Map<String, dynamic> json) {
    return FeatureFlags(
      showMinutesTab: json['showMinutesTab'] as bool? ?? true,
      showConstitutionTab: json['showConstitutionTab'] as bool? ?? true,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'showMinutesTab': showMinutesTab,
      'showConstitutionTab': showConstitutionTab,
    };
  }
}
