/// ❌ Error Widget - Hata widget'ı
///
/// Bu widget, hata durumlarını gösterir.
import 'package:flutter/material.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';

class ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;

  const ErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Branding.spacingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon ?? Icons.error_outline, size: 64, color: Branding.error),
            const SizedBox(height: Branding.spacingM),
            Text(
              'Bir hata oluştu',
              style: AppTypography.h3.copyWith(color: Branding.textPrimary),
            ),
            const SizedBox(height: Branding.spacingS),
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(
                color: Branding.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: Branding.spacingL),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Tekrar Dene'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Branding.primary,
                  foregroundColor: Branding.textOnPrimary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
