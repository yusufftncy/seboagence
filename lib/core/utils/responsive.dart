import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// 🎯 Responsive Design System
/// Gelişmiş responsive utilities ve breakpoint yönetimi
class Responsive {
  // 📱 BREAKPOINT DETECTION
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.mobileBreakpoint && 
           width < AppConstants.tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.tabletBreakpoint;
  }

  static bool isLargeDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;
  }

  // 📏 SCREEN SIZE GETTERS
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  // 🎨 RESPONSIVE VALUES
  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    if (isLargeDesktop(context) && largeDesktop != null) {
      return largeDesktop;
    } else if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  // 📐 RESPONSIVE PADDING
  static EdgeInsets responsivePadding(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    if (isMobile(context)) {
      return mobile ?? const EdgeInsets.all(16.0);
    } else if (isTablet(context)) {
      return tablet ?? const EdgeInsets.all(24.0);
    } else {
      return desktop ?? const EdgeInsets.all(32.0);
    }
  }

  // 📏 RESPONSIVE FONT SIZE
  static double responsiveFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.1,
      desktop: desktop ?? mobile * 1.2,
      largeDesktop: largeDesktop ?? mobile * 1.3,
    );
  }

  // 🎯 RESPONSIVE WIDGET
  static Widget responsiveWidget(
    BuildContext context, {
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
    Widget? largeDesktop,
  }) {
    if (isLargeDesktop(context) && largeDesktop != null) {
      return largeDesktop;
    } else if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  // 📊 GRID SYSTEM
  static int getGridColumns(BuildContext context) {
    return responsiveValue(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
      largeDesktop: 4,
    );
  }

  static double getGridSpacing(BuildContext context) {
    return responsiveValue(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
      largeDesktop: 48.0,
    );
  }

  // 🎨 RESPONSIVE CONTAINER
  static Widget responsiveContainer(
    BuildContext context, {
    required Widget child,
    double? maxWidth,
    EdgeInsets? padding,
  }) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? responsiveValue(
          context,
          mobile: double.infinity,
          tablet: 768.0,
          desktop: 1200.0,
          largeDesktop: 1400.0,
        ),
      ),
      padding: padding ?? responsivePadding(context),
      child: child,
    );
  }

  // 📱 RESPONSIVE LAYOUT
  static Widget responsiveLayout(
    BuildContext context, {
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
    Widget? largeDesktop,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppConstants.desktopBreakpoint) {
          return largeDesktop ?? desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= AppConstants.tabletBreakpoint) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= AppConstants.mobileBreakpoint) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }

  // 🎯 RESPONSIVE SPACING
  static double responsiveSpacing(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.2,
      desktop: desktop ?? mobile * 1.5,
      largeDesktop: largeDesktop ?? mobile * 2.0,
    );
  }

  // 📐 RESPONSIVE BORDER RADIUS
  static double responsiveBorderRadius(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.1,
      desktop: desktop ?? mobile * 1.2,
      largeDesktop: largeDesktop ?? mobile * 1.3,
    );
  }

  // 🎨 RESPONSIVE ELEVATION
  static double responsiveElevation(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.2,
      desktop: desktop ?? mobile * 1.5,
      largeDesktop: largeDesktop ?? mobile * 2.0,
    );
  }

  // 📱 RESPONSIVE ICON SIZE
  static double responsiveIconSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.1,
      desktop: desktop ?? mobile * 1.2,
      largeDesktop: largeDesktop ?? mobile * 1.3,
    );
  }

  // 🎯 RESPONSIVE ASPECT RATIO
  static double responsiveAspectRatio(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile,
      desktop: desktop ?? mobile,
      largeDesktop: largeDesktop ?? mobile,
    );
  }

  // 📊 RESPONSIVE ANIMATION DURATION
  static Duration responsiveAnimationDuration(
    BuildContext context, {
    required Duration mobile,
    Duration? tablet,
    Duration? desktop,
    Duration? largeDesktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? Duration(milliseconds: (mobile.inMilliseconds * 1.1).round()),
      desktop: desktop ?? Duration(milliseconds: (mobile.inMilliseconds * 1.2).round()),
      largeDesktop: largeDesktop ?? Duration(milliseconds: (mobile.inMilliseconds * 1.3).round()),
    );
  }
}