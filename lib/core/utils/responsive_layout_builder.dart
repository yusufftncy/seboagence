import 'package:flutter/material.dart';
import 'responsive.dart';

/// 🎯 Responsive Layout Builder
/// Gelişmiş responsive layout yönetimi

class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveBreakpoint breakpoint)? builder;
  final Widget Function(BuildContext context)? mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;
  final Widget Function(BuildContext context)? largeDesktop;

  const ResponsiveLayoutBuilder({
    super.key,
    this.builder,
    this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final breakpoint = _getBreakpoint(constraints.maxWidth);
        
        if (builder != null) {
          return builder!(context, breakpoint);
        }
        
        switch (breakpoint) {
          case ResponsiveBreakpoint.mobile:
            return mobile?.call(context) ?? const SizedBox.shrink();
          case ResponsiveBreakpoint.tablet:
            return tablet?.call(context) ?? const SizedBox.shrink();
          case ResponsiveBreakpoint.desktop:
            return desktop?.call(context) ?? const SizedBox.shrink();
          case ResponsiveBreakpoint.largeDesktop:
            return largeDesktop?.call(context) ?? const SizedBox.shrink();
        }
      },
    );
  }

  ResponsiveBreakpoint _getBreakpoint(double width) {
    if (width >= 1400) return ResponsiveBreakpoint.largeDesktop;
    if (width >= 1024) return ResponsiveBreakpoint.desktop;
    if (width >= 768) return ResponsiveBreakpoint.tablet;
    return ResponsiveBreakpoint.mobile;
  }
}

/// 📱 Responsive Breakpoint Enum
enum ResponsiveBreakpoint {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

/// 🎯 Responsive Breakpoint Extensions
extension ResponsiveBreakpointExtensions on ResponsiveBreakpoint {
  bool get isMobile => this == ResponsiveBreakpoint.mobile;
  bool get isTablet => this == ResponsiveBreakpoint.tablet;
  bool get isDesktop => this == ResponsiveBreakpoint.desktop;
  bool get isLargeDesktop => this == ResponsiveBreakpoint.largeDesktop;

  String get name {
    switch (this) {
      case ResponsiveBreakpoint.mobile:
        return 'Mobile';
      case ResponsiveBreakpoint.tablet:
        return 'Tablet';
      case ResponsiveBreakpoint.desktop:
        return 'Desktop';
      case ResponsiveBreakpoint.largeDesktop:
        return 'Large Desktop';
    }
  }
}

/// 🎨 Responsive Grid System
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final int? largeDesktopColumns;
  final double? spacing;
  final double? runSpacing;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.largeDesktopColumns,
    this.spacing,
    this.runSpacing,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      builder: (context, breakpoint) {
        final columns = _getColumns(breakpoint);
        final spacing = this.spacing ?? Responsive.getGridSpacing(context);
        final runSpacing = this.runSpacing ?? spacing;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          alignment: WrapAlignment.start,
          children: children.map((child) {
            return SizedBox(
              width: (MediaQuery.of(context).size.width - 
                     (columns - 1) * spacing) / columns,
              child: child,
            );
          }).toList(),
        );
      },
    );
  }

  int _getColumns(ResponsiveBreakpoint breakpoint) {
    switch (breakpoint) {
      case ResponsiveBreakpoint.mobile:
        return mobileColumns ?? 1;
      case ResponsiveBreakpoint.tablet:
        return tabletColumns ?? 2;
      case ResponsiveBreakpoint.desktop:
        return desktopColumns ?? 3;
      case ResponsiveBreakpoint.largeDesktop:
        return largeDesktopColumns ?? 4;
    }
  }
}

/// 📱 Responsive Row
class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final double? spacing;
  final bool? wrap;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.spacing,
    this.wrap,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      builder: (context, breakpoint) {
        if (wrap == true && Responsive.isMobile(context)) {
          return Wrap(
            spacing: spacing ?? 16.0,
            runSpacing: spacing ?? 16.0,
            children: children,
          );
        }

        return Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: children.map((child) {
            if (spacing != null && child != children.last) {
              return Row(
                children: [
                  child,
                  SizedBox(width: spacing),
                ],
              );
            }
            return child;
          }).toList(),
        );
      },
    );
  }
}

/// 📏 Responsive Column
class ResponsiveColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final double? spacing;

  const ResponsiveColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: children.map((child) {
        if (spacing != null && child != children.last) {
          return Column(
            children: [
              child,
              SizedBox(height: spacing),
            ],
          );
        }
        return child;
      }).toList(),
    );
  }
}

/// 🎯 Responsive Container
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final BoxDecoration? decoration;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive.responsiveContainer(
      context,
      child: child,
      maxWidth: maxWidth,
      padding: padding,
    );
  }
}

/// 📱 Responsive Text
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// 🎨 Responsive Icon
class ResponsiveIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double? size;

  const ResponsiveIcon(
    this.icon, {
    super.key,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      size: size ?? Responsive.responsiveIconSize(
        context,
        mobile: 24.0,
        tablet: 28.0,
        desktop: 32.0,
        largeDesktop: 36.0,
      ),
    );
  }
}

/// 📐 Responsive Spacer
class ResponsiveSpacer extends StatelessWidget {
  final double? mobile;
  final double? tablet;
  final double? desktop;
  final double? largeDesktop;

  const ResponsiveSpacer({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.responsiveValue(
        context,
        mobile: mobile ?? 16.0,
        tablet: tablet,
        desktop: desktop,
        largeDesktop: largeDesktop,
      ),
    );
  }
}
