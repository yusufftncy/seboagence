/// 🎨 Optimized Logo Widget
///
/// Bu widget, optimize edilmiş logo ve branding bölümünü içerir.
library;

import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';

class OptimizedLogo extends StatelessWidget {
  const OptimizedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive breakpoint kontrolü
        final isMobile = constraints.maxWidth < 768;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Responsive ŞEBO Logo Container
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.responsiveValue(
                  context,
                  mobile: 16.0, // Küçük padding
                  tablet: 20.0, // Orta padding
                  desktop: 28.0, // Büyük padding
                ),
                vertical: Responsive.responsiveValue(
                  context,
                  mobile: 6.0, // Küçük padding
                  tablet: 8.0, // Orta padding
                  desktop: 10.0, // Büyük padding
                ),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(
                  Responsive.responsiveValue(
                    context,
                    mobile: 15.0, // Küçük radius
                    tablet: 20.0, // Orta radius
                    desktop: 25.0, // Büyük radius
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE0E0E0).withValues(alpha: 0.2),
                    blurRadius: Responsive.responsiveValue(
                      context,
                      mobile: 2.0, // Küçük shadow
                      tablet: 3.0, // Orta shadow
                      desktop: 4.0, // Büyük shadow
                    ),
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                'ŞEBO',
                style: TextStyle(
                  color: const Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w900,
                  fontSize: Responsive.responsiveValue(
                    context,
                    mobile: 12.0, // Küçük font
                    tablet: 14.0, // Orta font
                    desktop: 16.0, // Büyük font
                  ),
                  letterSpacing: 0.5,
                ),
              ),
            ),

            SizedBox(
              width: Responsive.responsiveValue(
                context,
                mobile: 8.0, // Küçük spacing
                tablet: 12.0, // Orta spacing
                desktop: 16.0, // Büyük spacing
              ),
            ),

            // Responsive Creative Agency Text
            if (!isMobile) // Mobile'da gizle
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.responsiveValue(
                    context,
                    mobile: 8.0, // Küçük padding
                    tablet: 10.0, // Orta padding
                    desktop: 12.0, // Büyük padding
                  ),
                  vertical: Responsive.responsiveValue(
                    context,
                    mobile: 2.0, // Küçük padding
                    tablet: 3.0, // Orta padding
                    desktop: 4.0, // Büyük padding
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xFFE0E0E0),
                      width: Responsive.responsiveValue(
                        context,
                        mobile: 1.0, // Küçük border
                        tablet: 1.2, // Orta border
                        desktop: 1.5, // Büyük border
                      ),
                    ),
                  ),
                ),
                child: Text(
                  'creative agency',
                  style: TextStyle(
                    color: const Color(0xFFE0E0E0),
                    fontWeight: FontWeight.w300,
                    fontSize: Responsive.responsiveValue(
                      context,
                      mobile: 9.0, // Küçük font
                      tablet: 11.0, // Orta font
                      desktop: 13.0, // Büyük font
                    ),
                    letterSpacing: Responsive.responsiveValue(
                      context,
                      mobile: 0.8, // Küçük letter spacing
                      tablet: 1.0, // Orta letter spacing
                      desktop: 1.2, // Büyük letter spacing
                    ),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
