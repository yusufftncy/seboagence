/// 🚀 Project Card - Proje kartı widget'ı
///
/// Bu widget, proje bilgilerini kart formatında gösterir.
import 'package:flutter/material.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';
import '../../domain/entities/project_entity.dart';

class ProjectCard extends StatelessWidget {
  final ProjectEntity project;
  final VoidCallback? onTap;

  const ProjectCard({super.key, required this.project, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Branding.primaryColor.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Branding.borderRadiusL),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Branding.borderRadiusL),
        child: Container(
          constraints: const BoxConstraints(minHeight: 300, maxHeight: 500),
          padding: EdgeInsets.all(
            Responsive.responsiveValue(
              context,
              mobile: Branding.spacingM,
              tablet: Branding.spacingL,
              desktop: Branding.spacingL,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Proje resmi
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Branding.borderRadiusM),
                  child: Image.network(
                    project.imageUrl,
                    height: Responsive.responsiveValue(
                      context,
                      mobile: 120,
                      tablet: 150,
                      desktop: 180,
                    ),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: Responsive.responsiveValue(
                          context,
                          mobile: 120,
                          tablet: 150,
                          desktop: 180,
                        ),
                        color: Branding.surfaceLight,
                        child: Text(
                          '🖼️',
                          style: TextStyle(
                            fontSize: 32,
                            color: Branding.textSecondary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: Branding.spacingM),

              // Kategori
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Branding.spacingS,
                  vertical: Branding.spacingXS,
                ),
                decoration: BoxDecoration(
                  color: Branding.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Branding.borderRadiusS),
                ),
                child: Text(
                  project.category,
                  style: AppTypography.labelSmall.copyWith(
                    color: Branding.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: Branding.spacingS),

              // Proje başlığı
              Flexible(
                child: Text(
                  project.title,
                  style: AppTypography.h5.copyWith(
                    color: Branding.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.responsiveFontSize(
                      context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: Branding.spacingS),

              // Proje açıklaması
              Flexible(
                child: Text(
                  project.description,
                  style: AppTypography.bodySmall.copyWith(
                    color: Branding.textSecondary,
                    fontSize: Responsive.responsiveFontSize(
                      context,
                      mobile: 12,
                      tablet: 13,
                      desktop: 14,
                    ),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: Branding.spacingS),

              // Teknolojiler
              Flexible(
                child: Wrap(
                  spacing: Branding.spacingXS,
                  runSpacing: Branding.spacingXS,
                  children: project.technologies.take(2).map((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Branding.spacingXS,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Branding.surfaceLight,
                        borderRadius: BorderRadius.circular(
                          Branding.borderRadiusS,
                        ),
                      ),
                      child: Text(
                        tech,
                        style: AppTypography.labelSmall.copyWith(
                          color: Branding.textSecondary,
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: Branding.spacingS),

              // Butonlar
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Proje detayına git
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Branding.primary,
                        side: BorderSide(color: Branding.primary),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('👁️', style: TextStyle(fontSize: 12)),
                          const SizedBox(width: 4),
                          Text(
                            'Detay',
                            style: AppTypography.labelSmall.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: Branding.spacingXS),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // GitHub'a git
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Branding.primary,
                        foregroundColor: Branding.textOnPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('💻', style: TextStyle(fontSize: 12)),
                          const SizedBox(width: 4),
                          Text(
                            'Kod',
                            style: AppTypography.labelSmall.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
