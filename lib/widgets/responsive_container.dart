import 'package:flutter/material.dart';

/// Breakpoints for responsive design
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1200;
}

/// A responsive container that adapts its layout based on screen size
/// - Mobile (< 600px): Full width with standard padding
/// - Tablet (600-1200px): Constrained width with increased padding
/// - Desktop (> 1200px): Max width with center alignment
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;
  final double maxWidth;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.mobilePadding = const EdgeInsets.all(16.0),
    this.tabletPadding = const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
    this.desktopPadding = const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0),
    this.maxWidth = 1200,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        
        EdgeInsets padding;
        if (screenWidth < ResponsiveBreakpoints.mobile) {
          // Mobile
          padding = mobilePadding ?? const EdgeInsets.all(16.0);
        } else if (screenWidth < ResponsiveBreakpoints.tablet) {
          // Tablet
          padding = tabletPadding ?? const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0);
        } else {
          // Desktop
          padding = desktopPadding ?? const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0);
        }

        if (screenWidth >= ResponsiveBreakpoints.tablet) {
          // For tablet and desktop, center content with max width
          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              padding: padding,
              child: child,
            ),
          );
        }

        // For mobile, use full width with padding
        return Padding(
          padding: padding,
          child: child,
        );
      },
    );
  }
}

/// Helper function to get responsive padding based on screen width
EdgeInsets getResponsivePadding(BuildContext context, {
  EdgeInsets? mobile,
  EdgeInsets? tablet,
  EdgeInsets? desktop,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  
  if (screenWidth < ResponsiveBreakpoints.mobile) {
    return mobile ?? const EdgeInsets.all(16.0);
  } else if (screenWidth < ResponsiveBreakpoints.tablet) {
    return tablet ?? const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0);
  } else {
    return desktop ?? const EdgeInsets.symmetric(horizontal: 48.0, vertical: 24.0);
  }
}

/// Helper function to check if device is mobile
bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < ResponsiveBreakpoints.mobile;
}

/// Helper function to check if device is tablet
bool isTablet(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width >= ResponsiveBreakpoints.mobile && width < ResponsiveBreakpoints.tablet;
}

/// Helper function to check if device is desktop
bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width >= ResponsiveBreakpoints.tablet;
}
