import 'package:flutter/material.dart';
import 'responsive.dart';

/// 🎯 Responsive Extensions
/// Widget'lara responsive özellikler ekleyen extension'lar

extension ResponsiveExtensions on Widget {
  /// 📱 Responsive padding ekle
  Widget responsivePadding(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    EdgeInsets? largeDesktop,
  }) {
    return Padding(
      padding: Responsive.responsiveValue(
        context,
        mobile: mobile ?? EdgeInsets.all(16),
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
      child: this,
    );
  }

  /// 📏 Responsive margin ekle
  Widget responsiveMargin(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    EdgeInsets? largeDesktop,
  }) {
    return Container(
      margin: Responsive.responsiveValue(
        context,
        mobile: mobile ?? EdgeInsets.zero,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
      child: this,
    );
  }

  /// 🎨 Responsive container
  Widget responsiveContainer(
    BuildContext context, {
    Color? color,
    double? width,
    double? height,
    EdgeInsets? padding,
    EdgeInsets? margin,
    BoxDecoration? decoration,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration,
      color: color,
      child: this,
    );
  }

  /// 📐 Responsive border radius
  Widget responsiveBorderRadius(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
    Color? borderColor,
    double? borderWidth,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        Responsive.responsiveBorderRadius(
          context,
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
          largeDesktop: largeDesktop,
        ),
      ),
      child: Container(
        decoration: borderColor != null
            ? BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: borderWidth ?? 1.0,
                ),
              )
            : null,
        child: this,
      ),
    );
  }

  /// 🎯 Responsive elevation
  Widget responsiveElevation(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
    Color? shadowColor,
  }) {
    return Material(
      elevation: Responsive.responsiveElevation(
        context,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
      shadowColor: shadowColor,
      child: this,
    );
  }

  /// 📱 Responsive width
  Widget responsiveWidth(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return SizedBox(
      width: Responsive.responsiveValue(
        context,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
      child: this,
    );
  }

  /// 📏 Responsive height
  Widget responsiveHeight(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return SizedBox(
      height: Responsive.responsiveValue(
        context,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
      child: this,
    );
  }

  /// 🎨 Responsive opacity
  Widget responsiveOpacity(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return Opacity(
      opacity: Responsive.responsiveValue(
        context,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
      child: this,
    );
  }

  /// 📱 Responsive scale
  Widget responsiveScale(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return Transform.scale(
      scale: Responsive.responsiveValue(
        context,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
      child: this,
    );
  }

  /// 🎯 Responsive rotation
  Widget responsiveRotation(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return Transform.rotate(
      angle: Responsive.responsiveValue(
        context,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
      child: this,
    );
  }

  /// 📐 Responsive aspect ratio
  Widget responsiveAspectRatio(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return AspectRatio(
      aspectRatio: Responsive.responsiveAspectRatio(
        context,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
      child: this,
    );
  }

  /// 🎨 Responsive flexible
  Widget responsiveFlexible(
    BuildContext context, {
    int? flex,
    FlexFit? fit,
  }) {
    return Flexible(
      flex: flex ?? 1,
      fit: fit ?? FlexFit.loose,
      child: this,
    );
  }

  /// 📱 Responsive expanded
  Widget responsiveExpanded(
    BuildContext context, {
    int? flex,
  }) {
    return Expanded(
      flex: flex ?? 1,
      child: this,
    );
  }

  /// 🎯 Responsive center
  Widget responsiveCenter(
    BuildContext context, {
    double? widthFactor,
    double? heightFactor,
  }) {
    return Center(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  /// 📏 Responsive align
  Widget responsiveAlign(
    BuildContext context, {
    required Alignment mobile,
    Alignment? tablet,
    Alignment? desktop,
    Alignment? largeDesktop,
  }) {
    return Align(
      alignment: Responsive.responsiveValue(
        context,
        mobile: mobile,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
      child: this,
    );
  }

  /// 🎨 Responsive positioned
  Widget responsivePositioned(
    BuildContext context, {
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: this,
    );
  }

  /// 📱 Responsive safe area
  Widget responsiveSafeArea(
    BuildContext context, {
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
    EdgeInsets? minimum,
  }) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      minimum: minimum ?? EdgeInsets.zero,
      child: this,
    );
  }

  /// 🎯 Responsive scrollable
  Widget responsiveScrollable(
    BuildContext context, {
    Axis? direction,
    ScrollPhysics? physics,
    EdgeInsets? padding,
  }) {
    return SingleChildScrollView(
      scrollDirection: direction ?? Axis.vertical,
      physics: physics,
      padding: padding,
      child: this,
    );
  }
}
