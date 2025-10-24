import 'package:flutter/material.dart';
import 'responsive.dart';

/// 🎯 Responsive Utilities
/// Responsive tasarım için yardımcı fonksiyonlar

class ResponsiveUtilities {
  /// 📱 Screen orientation
  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// 📏 Safe area insets
  static EdgeInsets getSafeAreaInsets(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// 🎨 Device pixel ratio
  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// 📱 Text scale factor
  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaler.scale(1.0);
  }

  /// 🎯 Viewport dimensions
  static Size getViewportSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// 📐 Available space (excluding safe areas)
  static Size getAvailableSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    return Size(
      size.width - padding.left - padding.right,
      size.height - padding.top - padding.bottom,
    );
  }

  /// 🎨 Responsive grid columns
  static int getGridColumns(BuildContext context) {
    return Responsive.getGridColumns(context);
  }

  /// 📏 Responsive grid spacing
  static double getGridSpacing(BuildContext context) {
    return Responsive.getGridSpacing(context);
  }

  /// 🎯 Responsive container max width
  static double getContainerMaxWidth(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: double.infinity,
      tablet: 768.0,
      desktop: 1200.0,
      largeDesktop: 1400.0,
    );
  }

  /// 📱 Responsive navigation bar height
  static double getNavigationBarHeight(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 56.0,
      tablet: 64.0,
      desktop: 72.0,
      largeDesktop: 80.0,
    );
  }

  /// 🎨 Responsive app bar height
  static double getAppBarHeight(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 56.0,
      tablet: 64.0,
      desktop: 72.0,
      largeDesktop: 80.0,
    );
  }

  /// 📏 Responsive bottom navigation height
  static double getBottomNavigationHeight(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 56.0,
      tablet: 64.0,
      desktop: 72.0,
      largeDesktop: 80.0,
    );
  }

  /// 🎯 Responsive drawer width
  static double getDrawerWidth(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 280.0,
      tablet: 320.0,
      desktop: 360.0,
      largeDesktop: 400.0,
    );
  }

  /// 📱 Responsive floating action button size
  static double getFloatingActionButtonSize(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 56.0,
      tablet: 64.0,
      desktop: 72.0,
      largeDesktop: 80.0,
    );
  }

  /// 🎨 Responsive card elevation
  static double getCardElevation(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 2.0,
      tablet: 4.0,
      desktop: 6.0,
      largeDesktop: 8.0,
    );
  }

  /// 📐 Responsive border radius
  static double getBorderRadius(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 8.0,
      tablet: 12.0,
      desktop: 16.0,
      largeDesktop: 20.0,
    );
  }

  /// 🎯 Responsive icon size
  static double getIconSize(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 24.0,
      tablet: 28.0,
      desktop: 32.0,
      largeDesktop: 36.0,
    );
  }

  /// 📱 Responsive button height
  static double getButtonHeight(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 48.0,
      tablet: 52.0,
      desktop: 56.0,
      largeDesktop: 60.0,
    );
  }

  /// 🎨 Responsive input field height
  static double getInputFieldHeight(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 48.0,
      tablet: 52.0,
      desktop: 56.0,
      largeDesktop: 60.0,
    );
  }

  /// 📏 Responsive list item height
  static double getListItemHeight(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 56.0,
      tablet: 64.0,
      desktop: 72.0,
      largeDesktop: 80.0,
    );
  }

  /// 🎯 Responsive image aspect ratio
  static double getImageAspectRatio(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 16 / 9,
      tablet: 4 / 3,
      desktop: 3 / 2,
      largeDesktop: 16 / 10,
    );
  }

  /// 📱 Responsive video aspect ratio
  static double getVideoAspectRatio(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: 16 / 9,
      tablet: 16 / 9,
      desktop: 16 / 9,
      largeDesktop: 16 / 9,
    );
  }

  /// 🎨 Responsive animation duration
  static Duration getAnimationDuration(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: const Duration(milliseconds: 200),
      tablet: const Duration(milliseconds: 250),
      desktop: const Duration(milliseconds: 300),
      largeDesktop: const Duration(milliseconds: 350),
    );
  }

  /// 📐 Responsive curve
  static Curve getAnimationCurve(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: Curves.easeInOut,
      tablet: Curves.easeInOutCubic,
      desktop: Curves.easeInOutCubic,
      largeDesktop: Curves.easeInOutCubic,
    );
  }

  /// 🎯 Responsive scroll physics
  static ScrollPhysics getScrollPhysics(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: const BouncingScrollPhysics(),
      tablet: const ClampingScrollPhysics(),
      desktop: const ClampingScrollPhysics(),
      largeDesktop: const ClampingScrollPhysics(),
    );
  }

  /// 📱 Responsive scroll behavior
  static ScrollBehavior getScrollBehavior(BuildContext context) {
    return Responsive.responsiveValue(
      context,
      mobile: const MaterialScrollBehavior(),
      tablet: const MaterialScrollBehavior(),
      desktop: const MaterialScrollBehavior(),
      largeDesktop: const MaterialScrollBehavior(),
    );
  }

  /// 🎨 Responsive keyboard padding
  static EdgeInsets getKeyboardPadding(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return Responsive.responsiveValue(
      context,
      mobile: EdgeInsets.only(bottom: viewInsets.bottom),
      tablet: EdgeInsets.only(bottom: viewInsets.bottom),
      desktop: EdgeInsets.only(bottom: viewInsets.bottom),
      largeDesktop: EdgeInsets.only(bottom: viewInsets.bottom),
    );
  }

  /// 📏 Responsive status bar height
  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// 🎯 Responsive bottom bar height
  static double getBottomBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  /// 📱 Responsive left padding
  static double getLeftPadding(BuildContext context) {
    return MediaQuery.of(context).padding.left;
  }

  /// 🎨 Responsive right padding
  static double getRightPadding(BuildContext context) {
    return MediaQuery.of(context).padding.right;
  }

  /// 📐 Responsive top padding
  static double getTopPadding(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// 🎯 Responsive bottom padding
  static double getBottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
}
