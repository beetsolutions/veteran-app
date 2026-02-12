import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/utils/responsive_utils.dart';

void main() {
  group('ResponsiveUtils Tests', () {
    testWidgets('getDeviceType returns mobile for small screens', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final deviceType = ResponsiveUtils.getDeviceType(context);
              expect(deviceType, DeviceType.mobile);
              return const SizedBox();
            },
          ),
        ),
      );
      
      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('getDeviceType returns tablet for medium screens', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(768, 1024));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final deviceType = ResponsiveUtils.getDeviceType(context);
              expect(deviceType, DeviceType.tablet);
              return const SizedBox();
            },
          ),
        ),
      );
      
      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('getDeviceType returns desktop for large screens', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final deviceType = ResponsiveUtils.getDeviceType(context);
              expect(deviceType, DeviceType.desktop);
              return const SizedBox();
            },
          ),
        ),
      );
      
      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('isMobile returns correct values', (WidgetTester tester) async {
      // Test mobile screen
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.isMobile(context), true);
              expect(ResponsiveUtils.isTablet(context), false);
              expect(ResponsiveUtils.isDesktop(context), false);
              return const SizedBox();
            },
          ),
        ),
      );

      // Test tablet screen
      await tester.binding.setSurfaceSize(const Size(768, 1024));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.isMobile(context), false);
              expect(ResponsiveUtils.isTablet(context), true);
              expect(ResponsiveUtils.isDesktop(context), false);
              return const SizedBox();
            },
          ),
        ),
      );

      // Test desktop screen
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.isMobile(context), false);
              expect(ResponsiveUtils.isTablet(context), false);
              expect(ResponsiveUtils.isDesktop(context), true);
              return const SizedBox();
            },
          ),
        ),
      );
      
      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('getPadding returns correct values for different screen sizes', (WidgetTester tester) async {
      // Mobile
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.getPadding(context), 16.0);
              return const SizedBox();
            },
          ),
        ),
      );

      // Tablet
      await tester.binding.setSurfaceSize(const Size(768, 1024));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.getPadding(context), 24.0);
              return const SizedBox();
            },
          ),
        ),
      );

      // Desktop
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.getPadding(context), 32.0);
              return const SizedBox();
            },
          ),
        ),
      );
      
      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('getFontSize returns correct values for different screen sizes', (WidgetTester tester) async {
      // Mobile
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.getFontSize(context), 14.0);
              return const SizedBox();
            },
          ),
        ),
      );

      // Tablet
      await tester.binding.setSurfaceSize(const Size(768, 1024));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.getFontSize(context), 16.0);
              return const SizedBox();
            },
          ),
        ),
      );

      // Desktop
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.getFontSize(context), 18.0);
              return const SizedBox();
            },
          ),
        ),
      );
      
      addTearDown(() => tester.binding.setSurfaceSize(null));
    });

    testWidgets('getGridColumns returns correct values for different screen sizes', (WidgetTester tester) async {
      // Mobile - 2 columns
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.getGridColumns(context), 2);
              return const SizedBox();
            },
          ),
        ),
      );

      // Tablet - 3 columns
      await tester.binding.setSurfaceSize(const Size(768, 1024));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.getGridColumns(context), 3);
              return const SizedBox();
            },
          ),
        ),
      );

      // Desktop - 4 columns
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              expect(ResponsiveUtils.getGridColumns(context), 4);
              return const SizedBox();
            },
          ),
        ),
      );
      
      addTearDown(() => tester.binding.setSurfaceSize(null));
    });
  });
}
