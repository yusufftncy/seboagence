/// 🎨 Optimized Logo Widget
///
/// Bu widget, optimize edilmiş logo ve branding bölümünü içerir.
library;

import 'package:flutter/material.dart';

class OptimizedLogo extends StatelessWidget {
  const OptimizedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Optimized ŞEBO Logo Container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE0E0E0).withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Text(
            'ŞEBO',
            style: TextStyle(
              color: Color(0xFF4A4A4A),
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 16.0),

        // Creative Agency Text
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: const Color(0xFFE0E0E0), width: 1.5),
            ),
          ),
          child: const Text(
            'creative agency',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontWeight: FontWeight.w300,
              fontSize: 13,
              letterSpacing: 1.2,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}