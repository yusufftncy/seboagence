/// 🎨 Works Page - Projeler sayfası
///
/// Bu sayfa, Hoş İşler platformundaki projeleri gösterir.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/utils/responsive.dart';
import '../../core/services/navigation_service.dart';
import '../widgets/optimized_navigation_bar.dart';

class WorksPage extends ConsumerWidget {
  const WorksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF131B2E),
      body: Column(
        children: [
          const OptimizedNavigationBar(),
          Expanded(child: _WorksPageContent()),
        ],
      ),
    );
  }
}

/// Works Page Content
class _WorksPageContent extends StatelessWidget {
  const _WorksPageContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _HeroSection(),
          _ChaptersSection(),
          _ProjectsSection(),
          _ContactSection(),
        ],
      ),
    );
  }
}

/// Hero Section
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? Branding.spacingL : Branding.spacingXXL,
        vertical: isMobile ? Branding.spacingXXL : Branding.spacingXXL * 2,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF131B2E), Color(0xFF1A237E)],
        ),
      ),
      child: Column(
        children: [
          // Ana başlık
          Text(
            'Hoş İşler',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile
                  ? 36.0
                  : isTablet
                  ? 48.0
                  : 64.0,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? Branding.spacingM : Branding.spacingL),

          // Alt başlık
          Text(
            'Yaratıcı Projeler, Anlamlı Sonuçlar',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.9),
              fontSize: isMobile
                  ? 18.0
                  : isTablet
                  ? 22.0
                  : 28.0,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? Branding.spacingXL : Branding.spacingXXL),

          // Açıklama
          Text(
            'Hoş İşler platformumuzda, sosyal sorumluluk ve yaratıcılığı birleştiren projelerimizi keşfedin. Her proje, topluma değer katma amacıyla tasarlanmıştır.',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Chapters Section
class _ChaptersSection extends StatelessWidget {
  const _ChaptersSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? Branding.spacingL : Branding.spacingXXL,
      ),
      child: Column(
        children: [
          Text(
            'Chapter\'larımız',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Her chapter\'ın kendine özgü hikayesi ve amacı var',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.7),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXXL),

          Responsive.responsiveWidget(
            context,
            mobile: _buildMobileChapters(),
            tablet: _buildTabletChapters(),
            desktop: _buildDesktopChapters(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileChapters() {
    return Column(
      children: [
        _buildChapterCard(
          title: 'Şifa',
          description:
              'Hatay\'da yetişen Barış ipeği ve kadın çiftçilerin ürünlerini değere dönüştürme projesi',
          color: Branding.primary,
          icon: Icons.healing,
        ),
        SizedBox(height: Branding.spacingL),
        _buildChapterCard(
          title: 'Vefa',
          description:
              'Alanya\'daki ailemden kalan okullar ve Alanya ile ilgili projeler',
          color: Branding.secondary,
          icon: Icons.school,
        ),
        SizedBox(height: Branding.spacingL),
        _buildChapterCard(
          title: 'Sefa',
          description: 'Şifa ipeği ile üretilen keyifli ürünlerden oluşan seri',
          color: Branding.primary,
          icon: Icons.spa,
        ),
      ],
    );
  }

  Widget _buildTabletChapters() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildChapterCard(
                title: 'Şifa',
                description:
                    'Hatay\'da yetişen Barış ipeği ve kadın çiftçilerin ürünlerini değere dönüştürme projesi',
                color: Branding.primary,
                icon: Icons.healing,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(
              child: _buildChapterCard(
                title: 'Vefa',
                description:
                    'Alanya\'daki ailemden kalan okullar ve Alanya ile ilgili projeler',
                color: Branding.secondary,
                icon: Icons.school,
              ),
            ),
          ],
        ),
        SizedBox(height: Branding.spacingL),
        Row(
          children: [
            Expanded(
              child: _buildChapterCard(
                title: 'Sefa',
                description:
                    'Şifa ipeği ile üretilen keyifli ürünlerden oluşan seri',
                color: Branding.primary,
                icon: Icons.spa,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(child: Container()), // Boş alan
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopChapters() {
    return Row(
      children: [
        Expanded(
          child: _buildChapterCard(
            title: 'Şifa',
            description:
                'Hatay\'da yetişen Barış ipeği ve kadın çiftçilerin ürünlerini değere dönüştürme projesi',
            color: Branding.primary,
            icon: Icons.healing,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildChapterCard(
            title: 'Vefa',
            description:
                'Alanya\'daki ailemden kalan okullar ve Alanya ile ilgili projeler',
            color: Branding.secondary,
            icon: Icons.school,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildChapterCard(
            title: 'Sefa',
            description:
                'Şifa ipeği ile üretilen keyifli ürünlerden oluşan seri',
            color: Branding.primary,
            icon: Icons.spa,
          ),
        ),
      ],
    );
  }

  Widget _buildChapterCard({
    required String title,
    required String description,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(Branding.spacingXL),
      decoration: BoxDecoration(
        color: Branding.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Branding.borderRadiusL),
        border: Border.all(
          color: Branding.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(Branding.spacingL),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(Branding.borderRadiusM),
            ),
            child: Icon(icon, color: Branding.white, size: 32.0),
          ),
          SizedBox(height: Branding.spacingL),
          Text(
            title,
            style: const TextStyle(
              color: Branding.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            description,
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.8),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Projects Section
class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? Branding.spacingL : Branding.spacingXXL,
      ),
      decoration: BoxDecoration(color: Branding.white.withValues(alpha: 0.05)),
      child: Column(
        children: [
          Text(
            'Projelerimiz',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Her proje, topluma değer katma amacıyla tasarlanmıştır',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.7),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXXL),

          Responsive.responsiveWidget(
            context,
            mobile: _buildMobileProjects(),
            tablet: _buildTabletProjects(),
            desktop: _buildDesktopProjects(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileProjects() {
    return Column(
      children: [
        _buildProjectCard(
          title: 'Şifa İpek',
          chapter: 'Şifa',
          description:
              'Hatay\'da yetişen Barış ipeği ve Hatay depreminden sonra köylerde yaşayan kadın çiftçilerin tezgahlarında dokudukları ürünlerin değere dönüştürülmesi',
          color: Branding.primary,
          features: [
            'Kadın güçlendirme',
            'Sürdürülebilir üretim',
            'Yerel ekonomi',
          ],
          stats: '50+ Kadın Çiftçi',
        ),
        SizedBox(height: Branding.spacingL),
        _buildProjectCard(
          title: 'Alanya Eğitim Projesi',
          chapter: 'Vefa',
          description:
              'Alanya\'daki ailemden kalan kız meslek lisesi ve turizm otelcilik okulu öğrencilerine yönelik projeler',
          color: Branding.secondary,
          features: ['Mesleki eğitim', 'Turizm sektörü', 'Genç istihdam'],
          stats: '200+ Öğrenci',
        ),
        SizedBox(height: Branding.spacingL),
        _buildProjectCard(
          title: 'Sefa Ürün Serisi',
          chapter: 'Sefa',
          description:
              'Şifa ipeği ile üretilen keyifli ürünlerden oluşan özel seri',
          color: Branding.primary,
          features: ['El yapımı ürünler', 'Doğal malzemeler', 'Özel tasarım'],
          stats: '100+ Ürün',
        ),
      ],
    );
  }

  Widget _buildTabletProjects() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildProjectCard(
                title: 'Şifa İpek',
                chapter: 'Şifa',
                description:
                    'Hatay\'da yetişen Barış ipeği ve kadın çiftçilerin ürünlerini değere dönüştürme projesi',
                color: Branding.primary,
                features: [
                  'Kadın güçlendirme',
                  'Sürdürülebilir üretim',
                  'Yerel ekonomi',
                ],
                stats: '50+ Kadın Çiftçi',
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(
              child: _buildProjectCard(
                title: 'Alanya Eğitim Projesi',
                chapter: 'Vefa',
                description:
                    'Alanya\'daki okullar ve öğrencilere yönelik projeler',
                color: Branding.secondary,
                features: ['Mesleki eğitim', 'Turizm sektörü', 'Genç istihdam'],
                stats: '200+ Öğrenci',
              ),
            ),
          ],
        ),
        SizedBox(height: Branding.spacingL),
        Row(
          children: [
            Expanded(
              child: _buildProjectCard(
                title: 'Sefa Ürün Serisi',
                chapter: 'Sefa',
                description:
                    'Şifa ipeği ile üretilen keyifli ürünlerden oluşan seri',
                color: Branding.primary,
                features: [
                  'El yapımı ürünler',
                  'Doğal malzemeler',
                  'Özel tasarım',
                ],
                stats: '100+ Ürün',
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(child: Container()), // Boş alan
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopProjects() {
    return Row(
      children: [
        Expanded(
          child: _buildProjectCard(
            title: 'Şifa İpek',
            chapter: 'Şifa',
            description:
                'Hatay\'da yetişen Barış ipeği ve kadın çiftçilerin ürünlerini değere dönüştürme projesi',
            color: Branding.primary,
            features: [
              'Kadın güçlendirme',
              'Sürdürülebilir üretim',
              'Yerel ekonomi',
            ],
            stats: '50+ Kadın Çiftçi',
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildProjectCard(
            title: 'Alanya Eğitim Projesi',
            chapter: 'Vefa',
            description: 'Alanya\'daki okullar ve öğrencilere yönelik projeler',
            color: Branding.secondary,
            features: ['Mesleki eğitim', 'Turizm sektörü', 'Genç istihdam'],
            stats: '200+ Öğrenci',
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildProjectCard(
            title: 'Sefa Ürün Serisi',
            chapter: 'Sefa',
            description:
                'Şifa ipeği ile üretilen keyifli ürünlerden oluşan seri',
            color: Branding.primary,
            features: ['El yapımı ürünler', 'Doğal malzemeler', 'Özel tasarım'],
            stats: '100+ Ürün',
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String chapter,
    required String description,
    required Color color,
    required List<String> features,
    required String stats,
  }) {
    return Container(
      padding: EdgeInsets.all(Branding.spacingXL),
      decoration: BoxDecoration(
        color: Branding.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Branding.borderRadiusL),
        border: Border.all(
          color: Branding.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chapter etiketi ve istatistik
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  chapter,
                  style: TextStyle(
                    color: color,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  stats,
                  style: TextStyle(
                    color: color,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Branding.spacingL),

          // Proje başlığı
          Text(
            title,
            style: const TextStyle(
              color: Branding.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: Branding.spacingS),

          // Proje açıklaması
          Text(
            description,
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.8),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          SizedBox(height: Branding.spacingL),

          // Özellikler listesi
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              color: Branding.white.withValues(alpha: 0.7),
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

/// Contact Section
class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? Branding.spacingL : Branding.spacingXXL,
      ),
      decoration: const BoxDecoration(color: Color(0xFF1A237E)),
      child: Column(
        children: [
          Text(
            'Projelerimizle İlgileniyor musunuz?',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Detaylı bilgi almak için bizimle iletişime geçin',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXL),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  NavigationService.goToContact();
                },
                icon: const Icon(Icons.email, color: Branding.white),
                label: const Text(
                  'İletişime Geç',
                  style: TextStyle(color: Branding.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Branding.primary,
                  padding: EdgeInsets.symmetric(
                    vertical: Branding.spacingM,
                    horizontal: Branding.spacingL,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Branding.borderRadiusM),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
