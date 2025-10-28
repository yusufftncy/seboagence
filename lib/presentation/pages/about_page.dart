/// ℹ️ Ultra-Optimized About Page - Hakkımızda sayfası
///
/// Bu sayfa, ajans hakkında profesyonel ve kompakt bilgileri gösterir.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/branding.dart';
import '../../core/utils/responsive.dart';
import '../../core/services/navigation_service.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/optimized_navigation_bar.dart';

class AboutPage extends ConsumerWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF131B2E),
      body: Column(
        children: [
          const OptimizedNavigationBar(),
          Expanded(child: _AboutPageContent()),
        ],
      ),
    );
  }
}

/// Optimized About Page Content
class _AboutPageContent extends StatelessWidget {
  const _AboutPageContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _HeroSection(),
          _MissionVisionSection(),
          _ValuesSection(),
          _AchievementsSection(),
          _TeamSection(),
          _ContactSection(),
        ],
      ),
    );
  }
}

/// Hero Section - Ultra Optimized
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
            'Hakkımızda',
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
            'Yaratıcı Çözümler, Etkili Sonuçlar',
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
            'Şebo Agency olarak, dijital dünyada yaratıcılık ve teknolojiyi birleştirerek müşterilerimize en iyi deneyimi sunuyoruz. 5 yıllık deneyimimizle, markanızı dijital dünyada öne çıkarıyoruz.',
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

/// Mission & Vision Section
class _MissionVisionSection extends StatelessWidget {
  const _MissionVisionSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? Branding.spacingL : Branding.spacingXXL,
      ),
      child: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileMissionVision(),
        tablet: _buildTabletMissionVision(),
        desktop: _buildDesktopMissionVision(),
      ),
    );
  }

  Widget _buildMobileMissionVision() {
    return Column(
      children: [
        _buildMissionCard(),
        SizedBox(height: Branding.spacingL),
        _buildVisionCard(),
      ],
    );
  }

  Widget _buildTabletMissionVision() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildMissionCard()),
            SizedBox(width: Branding.spacingL),
            Expanded(child: _buildVisionCard()),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopMissionVision() {
    return Row(
      children: [
        Expanded(child: _buildMissionCard()),
        SizedBox(width: Branding.spacingL),
        Expanded(child: _buildVisionCard()),
      ],
    );
  }

  Widget _buildMissionCard() {
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
              color: Branding.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(Branding.borderRadiusM),
            ),
            child: const Icon(Icons.flag, color: Branding.white, size: 32.0),
          ),
          SizedBox(height: Branding.spacingL),
          const Text(
            'Misyonumuz',
            style: TextStyle(
              color: Branding.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Müşterilerimize en iyi dijital deneyimi sunarak, markalarını dijital dünyada öne çıkarmak ve hedeflerine ulaşmalarını sağlamak.',
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

  Widget _buildVisionCard() {
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
              color: Branding.secondary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(Branding.borderRadiusM),
            ),
            child: const Icon(
              Icons.visibility,
              color: Branding.white,
              size: 32.0,
            ),
          ),
          SizedBox(height: Branding.spacingL),
          const Text(
            'Vizyonumuz',
            style: TextStyle(
              color: Branding.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Dijital dünyada öncü olmak, yaratıcılık ve teknolojiyi birleştirerek sektörde fark yaratan çözümler üretmek.',
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

/// Values Section
class _ValuesSection extends StatelessWidget {
  const _ValuesSection();

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
            'Değerlerimiz',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Çalışma prensiplerimiz ve değerlerimiz',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.7),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXL),

          Responsive.responsiveWidget(
            context,
            mobile: _buildMobileValues(),
            tablet: _buildTabletValues(),
            desktop: _buildDesktopValues(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileValues() {
    return Column(
      children: [
        _buildValueCard(
          icon: Icons.lightbulb,
          title: 'Yaratıcılık',
          description: 'Benzersiz ve etkili çözümler üretiyoruz',
          color: Branding.primary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildValueCard(
          icon: Icons.star,
          title: 'Kalite',
          description: 'En yüksek standartlarda hizmet veriyoruz',
          color: Branding.secondary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildValueCard(
          icon: Icons.security,
          title: 'Güvenilirlik',
          description: 'Sözümüzü tutar, güvenilir partneriz',
          color: Branding.secondary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildValueCard(
          icon: Icons.trending_up,
          title: 'İnovasyon',
          description: 'Sürekli gelişim ve yenilik peşindeyiz',
          color: Branding.primary,
        ),
      ],
    );
  }

  Widget _buildTabletValues() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildValueCard(
                icon: Icons.lightbulb,
                title: 'Yaratıcılık',
                description: 'Benzersiz ve etkili çözümler üretiyoruz',
                color: Branding.primary,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(
              child: _buildValueCard(
                icon: Icons.star,
                title: 'Kalite',
                description: 'En yüksek standartlarda hizmet veriyoruz',
                color: Branding.secondary,
              ),
            ),
          ],
        ),
        SizedBox(height: Branding.spacingL),
        Row(
          children: [
            Expanded(
              child: _buildValueCard(
                icon: Icons.security,
                title: 'Güvenilirlik',
                description: 'Sözümüzü tutar, güvenilir partneriz',
                color: Branding.secondary,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(
              child: _buildValueCard(
                icon: Icons.trending_up,
                title: 'İnovasyon',
                description: 'Sürekli gelişim ve yenilik peşindeyiz',
                color: Branding.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopValues() {
    return Row(
      children: [
        Expanded(
          child: _buildValueCard(
            icon: Icons.lightbulb,
            title: 'Yaratıcılık',
            description: 'Benzersiz ve etkili çözümler üretiyoruz',
            color: Branding.primary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildValueCard(
            icon: Icons.star,
            title: 'Kalite',
            description: 'En yüksek standartlarda hizmet veriyoruz',
            color: Branding.secondary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildValueCard(
            icon: Icons.security,
            title: 'Güvenilirlik',
            description: 'Sözümüzü tutar, güvenilir partneriz',
            color: Branding.secondary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildValueCard(
            icon: Icons.trending_up,
            title: 'İnovasyon',
            description: 'Sürekli gelişim ve yenilik peşindeyiz',
            color: Branding.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildValueCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
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
            child: Icon(icon, color: color, size: 32.0),
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

/// Achievements Section
class _AchievementsSection extends StatelessWidget {
  const _AchievementsSection();

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
            'Başarılarımız',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Rakamlarla başarı hikayemiz',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.7),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXL),

          Responsive.responsiveWidget(
            context,
            mobile: _buildMobileAchievements(),
            tablet: _buildTabletAchievements(),
            desktop: _buildDesktopAchievements(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileAchievements() {
    return Column(
      children: [
        _buildAchievementCard(
          number: '100+',
          title: 'Başarılı Proje',
          description: 'Tamamlanan proje sayısı',
          color: Branding.primary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildAchievementCard(
          number: '50+',
          title: 'Mutlu Müşteri',
          description: 'Memnun müşteri sayısı',
          color: Branding.secondary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildAchievementCard(
          number: '5',
          title: 'Yıllık Deneyim',
          description: 'Sektördeki deneyimimiz',
          color: Branding.secondary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildAchievementCard(
          number: '24/7',
          title: 'Destek',
          description: 'Kesintisiz hizmet',
          color: Branding.primary,
        ),
      ],
    );
  }

  Widget _buildTabletAchievements() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildAchievementCard(
                number: '100+',
                title: 'Başarılı Proje',
                description: 'Tamamlanan proje sayısı',
                color: Branding.primary,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(
              child: _buildAchievementCard(
                number: '50+',
                title: 'Mutlu Müşteri',
                description: 'Memnun müşteri sayısı',
                color: Branding.secondary,
              ),
            ),
          ],
        ),
        SizedBox(height: Branding.spacingL),
        Row(
          children: [
            Expanded(
              child: _buildAchievementCard(
                number: '5',
                title: 'Yıllık Deneyim',
                description: 'Sektördeki deneyimimiz',
                color: Branding.secondary,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(
              child: _buildAchievementCard(
                number: '24/7',
                title: 'Destek',
                description: 'Kesintisiz hizmet',
                color: Branding.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopAchievements() {
    return Row(
      children: [
        Expanded(
          child: _buildAchievementCard(
            number: '100+',
            title: 'Başarılı Proje',
            description: 'Tamamlanan proje sayısı',
            color: Branding.primary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildAchievementCard(
            number: '50+',
            title: 'Mutlu Müşteri',
            description: 'Memnun müşteri sayısı',
            color: Branding.secondary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildAchievementCard(
            number: '5',
            title: 'Yıllık Deneyim',
            description: 'Sektördeki deneyimimiz',
            color: Branding.secondary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildAchievementCard(
            number: '24/7',
            title: 'Destek',
            description: 'Kesintisiz hizmet',
            color: Branding.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard({
    required String number,
    required String title,
    required String description,
    required Color color,
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
          Text(
            number,
            style: TextStyle(
              color: color,
              fontSize: 36.0,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            title,
            style: const TextStyle(
              color: Branding.white,
              fontSize: 18.0,
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

/// Team Section
class _TeamSection extends StatelessWidget {
  const _TeamSection();

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
            'Ekibimiz',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Deneyimli ve yaratıcı ekibimizle hizmetinizdeyiz',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.7),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXL),

          Responsive.responsiveWidget(
            context,
            mobile: _buildMobileTeam(),
            tablet: _buildTabletTeam(),
            desktop: _buildDesktopTeam(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileTeam() {
    return Column(
      children: [
        _buildTeamCard(
          name: 'Şebo Yüceer',
          role: 'Kurucu & CEO',
          description: 'Dijital strateji ve yönetim uzmanı',
          color: Branding.primary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildTeamCard(
          name: 'Şebo Ekibi',
          role: 'Yaratıcı Takım',
          description: 'Tasarım ve geliştirme uzmanları',
          color: Branding.secondary,
        ),
      ],
    );
  }

  Widget _buildTabletTeam() {
    return Row(
      children: [
        Expanded(
          child: _buildTeamCard(
            name: 'Şebo Yüceer',
            role: 'Kurucu & CEO',
            description: 'Dijital strateji ve yönetim uzmanı',
            color: Branding.primary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildTeamCard(
            name: 'Şebo Ekibi',
            role: 'Yaratıcı Takım',
            description: 'Tasarım ve geliştirme uzmanları',
            color: Branding.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopTeam() {
    return Row(
      children: [
        Expanded(
          child: _buildTeamCard(
            name: 'Şebo Yüceer',
            role: 'Kurucu & CEO',
            description: 'Dijital strateji ve yönetim uzmanı',
            color: Branding.primary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildTeamCard(
            name: 'Şebo Ekibi',
            role: 'Yaratıcı Takım',
            description: 'Tasarım ve geliştirme uzmanları',
            color: Branding.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamCard({
    required String name,
    required String role,
    required String description,
    required Color color,
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
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: name == 'Şebo Yüceer'
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.asset(
                      'assets/images/sebnemyuceer.jpg',
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(Icons.person, color: color, size: 40.0),
          ),
          SizedBox(height: Branding.spacingL),
          Text(
            name,
            style: const TextStyle(
              color: Branding.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            role,
            style: TextStyle(
              color: color,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
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
            'İletişime Geçin',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Projeleriniz için bizimle iletişime geçmekten çekinmeyin',
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
                  'E-posta Gönder',
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
              SizedBox(width: Branding.spacingL),
              ElevatedButton.icon(
                onPressed: () async {
                  final Uri phoneUri = Uri(
                    scheme: 'tel',
                    path: AppConstants.companyPhone,
                  );
                  if (await canLaunchUrl(phoneUri)) {
                    await launchUrl(phoneUri);
                  }
                },
                icon: const Icon(Icons.phone, color: Branding.white),
                label: const Text(
                  'Hemen Ara',
                  style: TextStyle(color: Branding.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Branding.secondary,
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
