import 'package:flutter/material.dart';
import 'responsive.dart';
import '../theme/branding.dart';

/// 🎯 Responsive Theme Extensions
/// Tema ile entegre responsive özellikler

extension ResponsiveThemeExtensions on BuildContext {
  /// 📱 Responsive text style
  TextStyle responsiveTextStyle({
    required TextStyle mobile,
    TextStyle? tablet,
    TextStyle? desktop,
    TextStyle? largeDesktop,
  }) {
    final baseStyle = Responsive.responsiveValue(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );

    return baseStyle.copyWith(
      fontSize: Responsive.responsiveFontSize(
        this,
        mobile: mobile.fontSize ?? 14.0,
        tablet: tablet?.fontSize,
        desktop: desktop?.fontSize,
        largeDesktop: largeDesktop?.fontSize,
      ),
    );
  }

  /// 🎨 Responsive color scheme
  ColorScheme get responsiveColorScheme {
    return Theme.of(this).colorScheme;
  }

  /// 📏 Responsive spacing
  double responsiveSpacing({
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return Responsive.responsiveSpacing(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// 🎯 Responsive border radius
  double responsiveBorderRadius({
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return Responsive.responsiveBorderRadius(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// 📱 Responsive elevation
  double responsiveElevation({
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return Responsive.responsiveElevation(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// 🎨 Responsive icon size
  double responsiveIconSize({
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return Responsive.responsiveIconSize(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// 📐 Responsive aspect ratio
  double responsiveAspectRatio({
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return Responsive.responsiveAspectRatio(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// 🎯 Responsive animation duration
  Duration responsiveAnimationDuration({
    required Duration mobile,
    Duration? tablet,
    Duration? desktop,
    Duration? largeDesktop,
  }) {
    return Responsive.responsiveAnimationDuration(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }
}

/// 🎨 Responsive Theme Data
class ResponsiveThemeData {
  static ThemeData responsiveTheme(BuildContext context) {
    final theme = Theme.of(context);
    
    return theme.copyWith(
      // Responsive text theme
      textTheme: theme.textTheme.copyWith(
        displayLarge: context.responsiveTextStyle(
          mobile: theme.textTheme.displayLarge ?? const TextStyle(),
          tablet: theme.textTheme.displayLarge?.copyWith(fontSize: 48),
          desktop: theme.textTheme.displayLarge?.copyWith(fontSize: 56),
          largeDesktop: theme.textTheme.displayLarge?.copyWith(fontSize: 64),
        ),
        displayMedium: context.responsiveTextStyle(
          mobile: theme.textTheme.displayMedium ?? const TextStyle(),
          tablet: theme.textTheme.displayMedium?.copyWith(fontSize: 40),
          desktop: theme.textTheme.displayMedium?.copyWith(fontSize: 48),
          largeDesktop: theme.textTheme.displayMedium?.copyWith(fontSize: 56),
        ),
        displaySmall: context.responsiveTextStyle(
          mobile: theme.textTheme.displaySmall ?? const TextStyle(),
          tablet: theme.textTheme.displaySmall?.copyWith(fontSize: 32),
          desktop: theme.textTheme.displaySmall?.copyWith(fontSize: 40),
          largeDesktop: theme.textTheme.displaySmall?.copyWith(fontSize: 48),
        ),
        headlineLarge: context.responsiveTextStyle(
          mobile: theme.textTheme.headlineLarge ?? const TextStyle(),
          tablet: theme.textTheme.headlineLarge?.copyWith(fontSize: 28),
          desktop: theme.textTheme.headlineLarge?.copyWith(fontSize: 32),
          largeDesktop: theme.textTheme.headlineLarge?.copyWith(fontSize: 36),
        ),
        headlineMedium: context.responsiveTextStyle(
          mobile: theme.textTheme.headlineMedium ?? const TextStyle(),
          tablet: theme.textTheme.headlineMedium?.copyWith(fontSize: 24),
          desktop: theme.textTheme.headlineMedium?.copyWith(fontSize: 28),
          largeDesktop: theme.textTheme.headlineMedium?.copyWith(fontSize: 32),
        ),
        headlineSmall: context.responsiveTextStyle(
          mobile: theme.textTheme.headlineSmall ?? const TextStyle(),
          tablet: theme.textTheme.headlineSmall?.copyWith(fontSize: 20),
          desktop: theme.textTheme.headlineSmall?.copyWith(fontSize: 24),
          largeDesktop: theme.textTheme.headlineSmall?.copyWith(fontSize: 28),
        ),
        titleLarge: context.responsiveTextStyle(
          mobile: theme.textTheme.titleLarge ?? const TextStyle(),
          tablet: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
          desktop: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
          largeDesktop: theme.textTheme.titleLarge?.copyWith(fontSize: 22),
        ),
        titleMedium: context.responsiveTextStyle(
          mobile: theme.textTheme.titleMedium ?? const TextStyle(),
          tablet: theme.textTheme.titleMedium?.copyWith(fontSize: 16),
          desktop: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
          largeDesktop: theme.textTheme.titleMedium?.copyWith(fontSize: 20),
        ),
        titleSmall: context.responsiveTextStyle(
          mobile: theme.textTheme.titleSmall ?? const TextStyle(),
          tablet: theme.textTheme.titleSmall?.copyWith(fontSize: 14),
          desktop: theme.textTheme.titleSmall?.copyWith(fontSize: 16),
          largeDesktop: theme.textTheme.titleSmall?.copyWith(fontSize: 18),
        ),
        bodyLarge: context.responsiveTextStyle(
          mobile: theme.textTheme.bodyLarge ?? const TextStyle(),
          tablet: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
          desktop: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
          largeDesktop: theme.textTheme.bodyLarge?.copyWith(fontSize: 20),
        ),
        bodyMedium: context.responsiveTextStyle(
          mobile: theme.textTheme.bodyMedium ?? const TextStyle(),
          tablet: theme.textTheme.bodyMedium?.copyWith(fontSize: 14),
          desktop: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
          largeDesktop: theme.textTheme.bodyMedium?.copyWith(fontSize: 18),
        ),
        bodySmall: context.responsiveTextStyle(
          mobile: theme.textTheme.bodySmall ?? const TextStyle(),
          tablet: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
          desktop: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
          largeDesktop: theme.textTheme.bodySmall?.copyWith(fontSize: 16),
        ),
        labelLarge: context.responsiveTextStyle(
          mobile: theme.textTheme.labelLarge ?? const TextStyle(),
          tablet: theme.textTheme.labelLarge?.copyWith(fontSize: 14),
          desktop: theme.textTheme.labelLarge?.copyWith(fontSize: 16),
          largeDesktop: theme.textTheme.labelLarge?.copyWith(fontSize: 18),
        ),
        labelMedium: context.responsiveTextStyle(
          mobile: theme.textTheme.labelMedium ?? const TextStyle(),
          tablet: theme.textTheme.labelMedium?.copyWith(fontSize: 12),
          desktop: theme.textTheme.labelMedium?.copyWith(fontSize: 14),
          largeDesktop: theme.textTheme.labelMedium?.copyWith(fontSize: 16),
        ),
        labelSmall: context.responsiveTextStyle(
          mobile: theme.textTheme.labelSmall ?? const TextStyle(),
          tablet: theme.textTheme.labelSmall?.copyWith(fontSize: 10),
          desktop: theme.textTheme.labelSmall?.copyWith(fontSize: 12),
          largeDesktop: theme.textTheme.labelSmall?.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}

/// 🎯 Responsive Branding Extensions
extension ResponsiveBrandingExtensions on BuildContext {
  /// 📱 Responsive logo
  Widget responsiveLogo({
    double? mobileSize,
    double? tabletSize,
    double? desktopSize,
    double? largeDesktopSize,
    Color? color,
  }) {
    return Branding.buildLogo(
      fontSize: Responsive.responsiveValue(
        this,
        mobile: mobileSize ?? 24.0,
        tablet: tabletSize,
        desktop: desktopSize,
        largeDesktop: largeDesktopSize,
      ),
      color: color,
    );
  }

  /// 🎨 Responsive sub logo
  Widget responsiveSubLogo({
    double? mobileSize,
    double? tabletSize,
    double? desktopSize,
    double? largeDesktopSize,
    Color? color,
  }) {
    return Branding.buildSubLogo(
      fontSize: Responsive.responsiveValue(
        this,
        mobile: mobileSize ?? 10.0,
        tablet: tabletSize,
        desktop: desktopSize,
        largeDesktop: largeDesktopSize,
      ),
      color: color,
    );
  }

  /// 📏 Responsive spacing
  Widget responsiveSpacing({
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return SizedBox(
      height: Responsive.responsiveSpacing(
        this,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
    );
  }

  /// 🎯 Responsive horizontal spacing
  Widget responsiveHorizontalSpacing({
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return SizedBox(
      width: Responsive.responsiveSpacing(
        this,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
    );
  }
}
