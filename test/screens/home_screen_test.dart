import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:veteranapp/screens/home_screen.dart';
import 'package:veteranapp/providers/feature_flags_provider.dart';
import 'package:veteranapp/models/feature_flags.dart';

void main() {
  // Helper to wrap widget with Provider
  Widget wrapWithProvider(Widget child, FeatureFlags featureFlags, {FeatureFlagsProvider? provider}) {
    final featureFlagsProvider = provider ?? FeatureFlagsProvider();
    featureFlagsProvider.updateFeatureFlags(featureFlags);
    return ChangeNotifierProvider<FeatureFlagsProvider>.value(
      value: featureFlagsProvider,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  group('HomeScreen Feature Flags Tests', () {
    testWidgets('All tabs are visible when all feature flags are enabled', (WidgetTester tester) async {
      const featureFlags = FeatureFlags(
        showMinutesTab: true,
        showConstitutionTab: true,
      );

      await tester.pumpWidget(
        wrapWithProvider(const HomeScreen(), featureFlags),
      );
      await tester.pumpAndSettle();

      // Verify all tabs are displayed in bottom navigation
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Constitution'), findsOneWidget);
      expect(find.text('Members'), findsOneWidget);
      expect(find.text('Minutes'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
    });

    testWidgets('Minutes tab is hidden when feature flag is disabled', (WidgetTester tester) async {
      const featureFlags = FeatureFlags(
        showMinutesTab: false,
        showConstitutionTab: true,
      );

      await tester.pumpWidget(
        wrapWithProvider(const HomeScreen(), featureFlags),
      );
      await tester.pumpAndSettle();

      // Verify Minutes tab is not displayed
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Constitution'), findsOneWidget);
      expect(find.text('Members'), findsOneWidget);
      expect(find.text('Minutes'), findsNothing);
      expect(find.text('More'), findsOneWidget);
    });

    testWidgets('Constitution tab is hidden when feature flag is disabled', (WidgetTester tester) async {
      const featureFlags = FeatureFlags(
        showMinutesTab: true,
        showConstitutionTab: false,
      );

      await tester.pumpWidget(
        wrapWithProvider(const HomeScreen(), featureFlags),
      );
      await tester.pumpAndSettle();

      // Verify Constitution tab is not displayed
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Constitution'), findsNothing);
      expect(find.text('Members'), findsOneWidget);
      expect(find.text('Minutes'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
    });

    testWidgets('Both Minutes and Constitution tabs are hidden when both feature flags are disabled', (WidgetTester tester) async {
      const featureFlags = FeatureFlags(
        showMinutesTab: false,
        showConstitutionTab: false,
      );

      await tester.pumpWidget(
        wrapWithProvider(const HomeScreen(), featureFlags),
      );
      await tester.pumpAndSettle();

      // Verify only Home, Members, and More tabs are displayed
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Constitution'), findsNothing);
      expect(find.text('Members'), findsOneWidget);
      expect(find.text('Minutes'), findsNothing);
      expect(find.text('More'), findsOneWidget);
    });

    testWidgets('Navigation works correctly with hidden tabs', (WidgetTester tester) async {
      const featureFlags = FeatureFlags(
        showMinutesTab: false,
        showConstitutionTab: false,
      );

      await tester.pumpWidget(
        wrapWithProvider(const HomeScreen(), featureFlags),
      );
      await tester.pumpAndSettle();

      // Tap on Members tab (which should be at index 1 when Constitution is hidden)
      await tester.tap(find.text('Members'));
      await tester.pumpAndSettle();

      // Navigation should work without errors
      expect(tester.takeException(), isNull);
    });

    testWidgets('Current index resets to 0 when active tab is hidden by feature flag change', (WidgetTester tester) async {
      final provider = FeatureFlagsProvider();
      
      // Start with all tabs visible
      await tester.pumpWidget(
        wrapWithProvider(const HomeScreen(), const FeatureFlags(
          showMinutesTab: true,
          showConstitutionTab: true,
        ), provider: provider),
      );
      await tester.pumpAndSettle();

      // Navigate to Constitution tab (index 1)
      await tester.tap(find.text('Constitution'));
      await tester.pumpAndSettle();

      // Hide Constitution tab
      provider.setConstitutionTabVisible(false);
      await tester.pumpAndSettle();

      // Should reset to home tab and not throw any errors
      expect(tester.takeException(), isNull);
      
      // Verify Constitution tab is no longer visible
      expect(find.text('Constitution'), findsNothing);
    });
  });
}
