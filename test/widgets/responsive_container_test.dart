import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/widgets/responsive_container.dart';

void main() {
  group('ResponsiveContainer', () {
    testWidgets('applies mobile padding on small screens', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Scaffold(
              body: ResponsiveContainer(
                child: Container(
                  color: Colors.red,
                  child: const Text('Test Content'),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify the container is rendered
      expect(find.text('Test Content'), findsOneWidget);
      
      // The widget should use Padding for mobile
      expect(find.byType(Padding), findsOneWidget);
      
      // Verify mobile padding (16.0 on all sides)
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.all(16.0));
    });

    testWidgets('applies tablet padding on medium screens', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 600)),
            child: Scaffold(
              body: ResponsiveContainer(
                child: Container(
                  color: Colors.blue,
                  child: const Text('Test Content'),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify the container is rendered
      expect(find.text('Test Content'), findsOneWidget);
      
      // For tablet, should use Center with Container
      expect(find.byType(Center), findsOneWidget);
    });

    testWidgets('applies desktop padding on large screens', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1400, 900)),
            child: Scaffold(
              body: ResponsiveContainer(
                child: Container(
                  color: Colors.green,
                  child: const Text('Test Content'),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify the container is rendered
      expect(find.text('Test Content'), findsOneWidget);
      
      // For desktop, should use Center with Container
      expect(find.byType(Center), findsOneWidget);
      
      // Verify max width constraint is applied
      final center = tester.widget<Center>(find.byType(Center));
      final container = center.child as Container;
      expect(container.constraints?.maxWidth, 1200);
    });

    testWidgets('uses custom padding when provided', (WidgetTester tester) async {
      const customPadding = EdgeInsets.all(50.0);
      
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Scaffold(
              body: ResponsiveContainer(
                mobilePadding: customPadding,
                child: Container(
                  color: Colors.yellow,
                  child: const Text('Test Content'),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify custom padding is applied
      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, customPadding);
    });
  });

  group('Responsive Helper Functions', () {
    testWidgets('isMobile returns true for small screens', (WidgetTester tester) async {
      bool? isMobileResult;
      
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Builder(
              builder: (context) {
                isMobileResult = isMobile(context);
                return const Scaffold(body: Text('Test'));
              },
            ),
          ),
        ),
      );

      expect(isMobileResult, true);
    });

    testWidgets('isTablet returns true for medium screens', (WidgetTester tester) async {
      bool? isTabletResult;
      
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 600)),
            child: Builder(
              builder: (context) {
                isTabletResult = isTablet(context);
                return const Scaffold(body: Text('Test'));
              },
            ),
          ),
        ),
      );

      expect(isTabletResult, true);
    });

    testWidgets('isDesktop returns true for large screens', (WidgetTester tester) async {
      bool? isDesktopResult;
      
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1400, 900)),
            child: Builder(
              builder: (context) {
                isDesktopResult = isDesktop(context);
                return const Scaffold(body: Text('Test'));
              },
            ),
          ),
        ),
      );

      expect(isDesktopResult, true);
    });

    testWidgets('getResponsivePadding returns correct padding for mobile', (WidgetTester tester) async {
      EdgeInsets? paddingResult;
      
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: Builder(
              builder: (context) {
                paddingResult = getResponsivePadding(context);
                return const Scaffold(body: Text('Test'));
              },
            ),
          ),
        ),
      );

      expect(paddingResult, const EdgeInsets.all(16.0));
    });

    testWidgets('getResponsivePadding returns correct padding for tablet', (WidgetTester tester) async {
      EdgeInsets? paddingResult;
      
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 600)),
            child: Builder(
              builder: (context) {
                paddingResult = getResponsivePadding(context);
                return const Scaffold(body: Text('Test'));
              },
            ),
          ),
        ),
      );

      expect(paddingResult, const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0));
    });

    testWidgets('getResponsivePadding returns correct padding for desktop', (WidgetTester tester) async {
      EdgeInsets? paddingResult;
      
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1400, 900)),
            child: Builder(
              builder: (context) {
                paddingResult = getResponsivePadding(context);
                return const Scaffold(body: Text('Test'));
              },
            ),
          ),
        ),
      );

      expect(paddingResult, const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0));
    });
  });
}
