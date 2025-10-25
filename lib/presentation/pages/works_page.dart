/// 🚀 Works Page - Projeler sayfası
///
/// Bu sayfa, tüm projeleri listeler.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';
import '../widgets/error_widget.dart' as custom;
import '../widgets/project_card.dart';
import '../../core/providers/project_providers.dart';

class WorksPage extends ConsumerWidget {
  const WorksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);

    return Scaffold(
      backgroundColor: Branding.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Projelerimiz'),
        backgroundColor: Branding.primary,
        foregroundColor: Branding.textOnPrimary,
      ),
      body: projectsAsync.when(
        data: (projects) => _buildProjectsContent(context, projects),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => custom.ErrorWidget(
          message: error.toString(),
          onRetry: () => ref.refresh(projectsProvider),
        ),
      ),
    );
  }

  Widget _buildProjectsContent(BuildContext context, List projects) {
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
              'Projelerimiz',
              style: AppTypography.h1.copyWith(color: Branding.textPrimary),
            ),
            const SizedBox(height: Branding.spacingS),
            Text(
              'Yaratıcı ve yenilikçi çözümlerimizi keşfedin',
              style: AppTypography.h3.copyWith(color: Branding.textSecondary),
            ),
            const SizedBox(height: Branding.spacingXL),

            // Proje sayısı
            Container(
              padding: const EdgeInsets.all(Branding.spacingM),
              decoration: BoxDecoration(
                color: Branding.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Branding.borderRadiusM),
              ),
              child: Row(
                children: [
                  Icon(Icons.work, color: Branding.primary, size: 24),
                  const SizedBox(width: Branding.spacingS),
                  Text(
                    '${projects.length} Proje',
                    style: AppTypography.bodyLarge.copyWith(
                      color: Branding.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Branding.spacingXL),

            // Projeler grid'i
            LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Responsive.responsiveValue(
                      context,
                      mobile: 1,
                      tablet: 2,
                      desktop: 3,
                    ),
                    crossAxisSpacing: Branding.spacingL,
                    mainAxisSpacing: Branding.spacingL,
                    childAspectRatio: Responsive.responsiveValue(
                      context,
                      mobile: 0.8,
                      tablet: 0.9,
                      desktop: 1.0,
                    ),
                  ),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return ProjectCard(
                      project: projects[index],
                      onTap: () {
                        // Proje detayına git
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
