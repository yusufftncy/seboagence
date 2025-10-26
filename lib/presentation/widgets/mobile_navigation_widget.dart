/// 📱 Mobile Navigation Widget
///
/// Mobile cihazlar için optimize edilmiş navigation widget'ı
library;

import 'package:flutter/material.dart';
import '../../core/theme/branding.dart';

class MobileNavigationWidget extends StatelessWidget {
  final bool showScrollIndicator;
  final VoidCallback? onMenuTap;

  const MobileNavigationWidget({
    super.key,
    this.showScrollIndicator = false,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showScrollIndicator) ...[
          _buildScrollIndicator(),
          const SizedBox(width: 12),
        ],
        _buildMenuButton(context),
      ],
    );
  }

  Widget _buildScrollIndicator() {
    return Container(
      width: 3,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0x1AFFFFFF), Color(0x33FFFFFF)],
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onMenuTap,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: const Icon(
              Icons.menu,
              color: Branding.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
