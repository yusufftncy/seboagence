/// 🚀 Project Detail Page - Proje detay sayfası
///
/// Bu sayfa, belirli bir projenin detaylarını gösterir.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';
import '../widgets/error_widget.dart' as custom;
import '../widgets/loading_widget.dart';
import '../../core/providers/project_providers.dart';

class ProjectDetailPage extends ConsumerWidget {
  final String projectId;

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectAsync = ref.watch(projectByIdProvider(projectId));

    return Scaffold(
      backgroundColor: Branding.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Proje Detayı'),
        backgroundColor: Branding.primary,
        foregroundColor: Branding.textOnPrimary,
      ),
      body: projectAsync.when(
        data: (project) => _buildProjectDetail(context, project),
        loading: () => const LoadingWidget(message: 'Proje yükleniyor...'),
        error: (error, stackTrace) => custom.ErrorWidget(
          message: error.toString(),
          onRetry: () => ref.refresh(projectByIdProvider(projectId)),
        ),
      ),
    );
  }

  Widget _buildProjectDetail(BuildContext context, dynamic project) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Proje resmi
          Container(
            height: Responsive.responsiveValue(
              context,
              mobile: 250,
              tablet: 350,
              desktop: 450,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(project.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Proje içeriği
          Padding(
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
                // Kategori
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Branding.spacingM,
                    vertical: Branding.spacingS,
                  ),
                  decoration: BoxDecoration(
                    color: Branding.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Branding.borderRadiusM),
                  ),
                  child: Text(
                    project.category,
                    style: AppTypography.labelMedium.copyWith(
                      color: Branding.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: Branding.spacingL),

                // Proje başlığı
                Text(
                  project.title,
                  style: AppTypography.h1.copyWith(color: Branding.textPrimary),
                ),
                const SizedBox(height: Branding.spacingL),

                // Proje açıklaması
                Text(
                  project.description,
                  style: AppTypography.bodyLarge.copyWith(
                    color: Branding.textSecondary,
                  ),
                ),
                const SizedBox(height: Branding.spacingXL),

                // Teknolojiler
                _buildTechnologiesSection(project.technologies),
                const SizedBox(height: Branding.spacingXL),

                // Proje bilgileri
                _buildProjectInfo(project),
                const SizedBox(height: Branding.spacingXL),

                // Butonlar
                _buildActionButtons(project),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnologiesSection(List technologies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kullanılan Teknolojiler',
          style: AppTypography.h4.copyWith(
            color: Branding.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: Branding.spacingM),
        Wrap(
          spacing: Branding.spacingS,
          runSpacing: Branding.spacingS,
          children: technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Branding.spacingM,
                vertical: Branding.spacingS,
              ),
              decoration: BoxDecoration(
                color: Branding.surfaceLight,
                borderRadius: BorderRadius.circular(Branding.borderRadiusM),
                border: Border.all(color: Branding.borderLight),
              ),
              child: Text(
                tech,
                style: AppTypography.bodyMedium.copyWith(
                  color: Branding.textPrimary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildProjectInfo(dynamic project) {
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
              'Proje Bilgileri',
              style: AppTypography.h4.copyWith(
                color: Branding.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: Branding.spacingL),

            _buildInfoRow('Müşteri', project.clientName),
            _buildInfoRow('Proje URL', project.projectUrl),
            _buildInfoRow('GitHub', project.githubUrl),
            _buildInfoRow('Oluşturulma', _formatDate(project.createdAt)),
            _buildInfoRow('Güncellenme', _formatDate(project.updatedAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Branding.spacingS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                color: Branding.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyMedium.copyWith(
                color: Branding.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(dynamic project) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // Proje URL'sine git
            },
            icon: const Icon(Icons.open_in_new),
            label: const Text('Projeyi Görüntüle'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Branding.primary,
              side: BorderSide(color: Branding.primary),
            ),
          ),
        ),
        const SizedBox(width: Branding.spacingM),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // GitHub'a git
            },
            icon: const Icon(Icons.code),
            label: const Text('GitHub'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Branding.primary,
              foregroundColor: Branding.textOnPrimary,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
