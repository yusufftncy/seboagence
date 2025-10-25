/// ⏳ Loading Widget - Yükleme widget'ı
///
/// Bu widget, yükleme durumlarını gösterir.
library;

import 'package:flutter/material.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final double? size;

  const LoadingWidget({super.key, this.message, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Branding.spacingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size ?? 48,
              height: size ?? 48,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Branding.primary),
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: Branding.spacingM),
              Text(
                message!,
                style: AppTypography.bodyMedium.copyWith(
                  color: Branding.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

