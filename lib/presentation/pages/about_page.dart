/// ℹ️ About Page - Hakkımızda sayfası
///
/// Bu sayfa, ajans hakkında bilgileri gösterir.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';
import '../widgets/error_widget.dart' as custom;
import '../widgets/loading_widget.dart';
import '../../core/providers/about_providers.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aboutAsync = ref.watch(aboutInfoProvider);

    return Scaffold(
      backgroundColor: Branding.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Hakkımızda'),
        backgroundColor: Branding.primary,
        foregroundColor: Branding.textOnPrimary,
      ),
      body: aboutAsync.when(
        data: (about) => _buildAboutContent(context, about),
        loading: () => const LoadingWidget(message: 'Bilgiler yükleniyor...'),
        error: (error, stackTrace) => custom.ErrorWidget(
          message: error.toString(),
          onRetry: () => ref.refresh(aboutInfoProvider),
        ),
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context, about) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(
          Responsive.responsiveValue(
            context,
            mobile: Branding.spacingL,
            tablet: Branding.spacingXL,
            desktop: Branding.spacingXXL,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık
            Text(
              'Ajans Şebo',
              style: AppTypography.h1.copyWith(color: Branding.textPrimary),
            ),
            const SizedBox(height: Branding.spacingL),

            // Açıklama
            Text(
              'Yaratıcı ve yenilikçi çözümler sunan dijital ajans',
              style: AppTypography.h3.copyWith(color: Branding.textSecondary),
            ),
            const SizedBox(height: Branding.spacingXL),

            // Misyon
            _buildSection(
              context,
              'Misyonumuz',
              'Müşterilerimize en iyi dijital deneyimi sunmak',
              Icons.flag,
            ),

            // Vizyon
            _buildSection(
              context,
              'Vizyonumuz',
              'Dijital dünyada öncü olmak',
              Icons.visibility,
            ),

            // Değerler
            _buildSection(
              context,
              'Değerlerimiz',
              'Yaratıcılık, Kalite, Güvenilirlik, İnovasyon',
              Icons.star,
            ),

            // Başarılar
            _buildAchievementsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
  ) {
    return Card(
      elevation: 4,
      shadowColor: Branding.shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Branding.borderRadiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Branding.spacingL),
        child: Row(
          children: [
            Icon(icon, size: 48, color: Branding.primary),
            const SizedBox(width: Branding.spacingL),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.h4.copyWith(
                      color: Branding.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: Branding.spacingS),
                  Text(
                    content,
                    style: AppTypography.bodyLarge.copyWith(
                      color: Branding.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Branding.shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Branding.borderRadiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Branding.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Başarılarımız',
              style: AppTypography.h4.copyWith(
                color: Branding.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: Branding.spacingL),
            const Wrap(
              spacing: Branding.spacingM,
              runSpacing: Branding.spacingM,
              children: [
                _AchievementChip('100+ Başarılı Proje'),
                _AchievementChip('50+ Mutlu Müşteri'),
                _AchievementChip('5 Yıllık Deneyim'),
                _AchievementChip('Award Winning Agency'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementChip extends StatelessWidget {
  final String text;

  const _AchievementChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Branding.spacingM,
        vertical: Branding.spacingS,
      ),
      decoration: BoxDecoration(
        color: Branding.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Branding.borderRadiusM),
        border: Border.all(color: Branding.primary.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: AppTypography.bodyMedium.copyWith(
          color: Branding.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
