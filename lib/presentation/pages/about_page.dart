/// ℹ️ Ultra-Optimized About Page - Hakkımızda sayfası
///
/// Bu sayfa, ajans hakkında profesyonel ve kompakt bilgileri gösterir.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';
import '../../core/services/navigation_service.dart';
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
          _FooterWidget(),
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
            'Dijital Dünyada Fark Yaratıyoruz',
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
            'Şebo Agency olarak, 2019 yılından bu yana dijital pazarlama, web tasarım ve mobil uygulama geliştirme alanlarında uzmanlaşmış bir ekibiz. Müşterilerimizin dijital dönüşüm yolculuğunda güvenilir partneri olarak, yaratıcı çözümlerle markalarını öne çıkarıyoruz.',
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
            'Her projede müşteri memnuniyetini ön planda tutarak, stratejik yaklaşım ve yaratıcı tasarım anlayışıyla markaların dijital varlığını güçlendiriyoruz. Müşterilerimizin iş hedeflerine ulaşması için özelleştirilmiş çözümler üretiyoruz.',
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
            'Türkiye\'nin önde gelen dijital ajanslarından biri olarak, sürekli gelişen teknoloji dünyasında yenilikçi yaklaşımlarla sektörde öncü konumumuzu korumak ve müşterilerimize en güncel çözümleri sunmak.',
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
            'İş yapış şeklimizi belirleyen temel değerlerimiz',
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
          description:
              'Her projede özgün ve etkileyici tasarım çözümleri geliştiriyoruz',
          color: Branding.primary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildValueCard(
          icon: Icons.star,
          title: 'Kalite',
          description:
              'Uluslararası standartlarda, detaylara önem veren yaklaşımla çalışıyoruz',
          color: Branding.secondary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildValueCard(
          icon: Icons.security,
          title: 'Güvenilirlik',
          description:
              'Zamanında teslimat ve şeffaf iletişimle güvenilir partnerlik kuruyoruz',
          color: Branding.secondary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildValueCard(
          icon: Icons.trending_up,
          title: 'İnovasyon',
          description:
              'En son teknolojileri takip ederek sürekli yenilik ve gelişim sağlıyoruz',
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

/// Achievements Section - Minimal Design
class _AchievementsSection extends StatelessWidget {
  const _AchievementsSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? Branding.spacingL : Branding.spacingXXL,
        vertical: isMobile ? Branding.spacingXL : Branding.spacingXXL * 1.5,
      ),
      child: Column(
        children: [
          // Minimal header
          Text(
            'Rakamlarla Başarımız',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 24.0 : 32.0,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? Branding.spacingM : Branding.spacingL),

          // Minimal subtitle
          Container(
            width: isMobile ? 200 : 300,
            height: 1,
            color: Branding.primary.withValues(alpha: 0.3),
          ),
          SizedBox(height: isMobile ? Branding.spacingXL : Branding.spacingXXL),

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
        // First row - 2 cards
        Row(
          children: [
            Expanded(
              child: _buildMinimalAchievementCard(
                number: '150+',
                title: 'Proje',
                color: Branding.primary,
              ),
            ),
            SizedBox(width: Branding.spacingM),
            Expanded(
              child: _buildMinimalAchievementCard(
                number: '80+',
                title: 'Müşteri',
                color: Branding.secondary,
              ),
            ),
          ],
        ),
        SizedBox(height: Branding.spacingL),
        // Second row - 2 cards
        Row(
          children: [
            Expanded(
              child: _buildMinimalAchievementCard(
                number: '5+',
                title: 'Yıl',
                color: Branding.primary,
              ),
            ),
            SizedBox(width: Branding.spacingM),
            Expanded(
              child: _buildMinimalAchievementCard(
                number: '98%',
                title: 'Memnuniyet',
                color: Branding.secondary,
              ),
            ),
          ],
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
              child: _buildMinimalAchievementCard(
                number: '150+',
                title: 'Proje',
                color: Branding.primary,
              ),
            ),
            SizedBox(width: Branding.spacingXL),
            Expanded(
              child: _buildMinimalAchievementCard(
                number: '80+',
                title: 'Müşteri',
                color: Branding.secondary,
              ),
            ),
          ],
        ),
        SizedBox(height: Branding.spacingXXL),
        Row(
          children: [
            Expanded(
              child: _buildMinimalAchievementCard(
                number: '5+',
                title: 'Yıl',
                color: Branding.primary,
              ),
            ),
            SizedBox(width: Branding.spacingXL),
            Expanded(
              child: _buildMinimalAchievementCard(
                number: '98%',
                title: 'Memnuniyet',
                color: Branding.secondary,
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
          child: _buildMinimalAchievementCard(
            number: '150+',
            title: 'Proje',
            color: Branding.primary,
          ),
        ),
        SizedBox(width: Branding.spacingXXL),
        Expanded(
          child: _buildMinimalAchievementCard(
            number: '80+',
            title: 'Müşteri',
            color: Branding.secondary,
          ),
        ),
        SizedBox(width: Branding.spacingXXL),
        Expanded(
          child: _buildMinimalAchievementCard(
            number: '5+',
            title: 'Yıl',
            color: Branding.primary,
          ),
        ),
        SizedBox(width: Branding.spacingXXL),
        Expanded(
          child: _buildMinimalAchievementCard(
            number: '98%',
            title: 'Memnuniyet',
            color: Branding.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMinimalAchievementCard({
    required String number,
    required String title,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Branding.spacingL,
        horizontal: Branding.spacingS,
      ),
      child: Column(
        children: [
          // Number with subtle background
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.1),
              border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: color,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: Branding.spacingM),
 
          // Title with minimal styling
          Text(
            title,
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.9),
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.5,
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
            'Uzman kadromuzla size en iyi hizmeti sunuyoruz',
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
          description:
              'Dijital pazarlama stratejisti ve proje yöneticisi. 5+ yıllık sektör deneyimi ile müşteri odaklı çözümler geliştiriyor.',
          color: Branding.primary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildTeamCard(
          name: 'Şebo Ekibi',
          role: 'Uzman Takım',
          description:
              'Web tasarım, mobil uygulama geliştirme ve dijital pazarlama alanlarında uzmanlaşmış deneyimli profesyoneller.',
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

/// Footer Widget
class _FooterWidget extends StatelessWidget {
  const _FooterWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.responsivePadding(
        context,
        mobile: const EdgeInsets.all(16.0),
        tablet: const EdgeInsets.all(20.0),
        desktop: const EdgeInsets.all(24.0),
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF131B2E), // Dark blue-grey
      ),
      child: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileFooter(context),
        tablet: _buildTabletFooter(context),
        desktop: _buildDesktopFooter(context),
      ),
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      children: [
        _buildMobileFooterLogo(),
        const SizedBox(height: 20),
        _buildMobileFooterLinks(),
        const SizedBox(height: 20),
        _buildMobileFooterContact(),
        const SizedBox(height: 20),
        _buildMobileFooterBottom(),
      ],
    );
  }

  Widget _buildTabletFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildTabletFooterLogo()),
            const SizedBox(width: 20),
            Expanded(flex: 1, child: _buildTabletFooterLinks()),
            const SizedBox(width: 20),
            Expanded(flex: 1, child: _buildTabletFooterContact()),
          ],
        ),
        const SizedBox(height: 24),
        _buildTabletFooterBottom(),
      ],
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildFooterLogo()),
            const SizedBox(width: 32),
            Expanded(flex: 1, child: _buildFooterLinks()),
            const SizedBox(width: 32),
            Expanded(flex: 1, child: _buildFooterContact()),
          ],
        ),
        const SizedBox(height: 24),
        _buildFooterBottom(),
      ],
    );
  }

  Widget _buildMobileFooterLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo - Mobile'da ortalanmış
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Text(
                'ŞEBO',
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFE0E0E0),
                    width: 1.0,
                  ),
                ),
              ),
              child: const Text(
                'creative agency',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontWeight: FontWeight.w300,
                  fontSize: 9,
                  letterSpacing: 1.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Açıklama - Mobile'da küçük ve ortalanmış
        Text(
          '2019 yılından bu yana dijital dünyada yaratıcılık ve teknolojiyi harmanlayarak, müşterilerimizin başarısı için çalışan güvenilir bir partneriz.',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFFB0B0B0),
            height: 1.4,
            fontSize: 10,
          ),
        ),

        const SizedBox(height: 16),

        // Sosyal medya - Mobile'da kompakt
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMobileSocialIcon(Icons.facebook, 'https://facebook.com'),
            const SizedBox(width: 8),
            _buildMobileSocialIcon(Icons.camera_alt, 'https://instagram.com'),
            const SizedBox(width: 8),
            _buildMobileSocialIcon(Icons.business, 'https://linkedin.com'),
            const SizedBox(width: 8),
            _buildMobileSocialIcon(Icons.chat, 'https://twitter.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletFooterLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 7.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(18.0),
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
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFE0E0E0),
                    width: 1.2,
                  ),
                ),
              ),
              child: const Text(
                'creative agency',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                  letterSpacing: 1.1,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Açıklama
        Text(
          '2019 yılından bu yana dijital dünyada yaratıcılık ve teknolojiyi harmanlayarak, müşterilerimizin başarısı için çalışan güvenilir bir partneriz.',
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFFB0B0B0),
            height: 1.5,
            fontSize: 11,
          ),
        ),

        const SizedBox(height: 16),

        // Sosyal medya
        Row(
          children: [
            _buildTabletSocialIcon(Icons.facebook, 'https://facebook.com'),
            const SizedBox(width: 12),
            _buildTabletSocialIcon(Icons.camera_alt, 'https://instagram.com'),
            const SizedBox(width: 12),
            _buildTabletSocialIcon(Icons.business, 'https://linkedin.com'),
            const SizedBox(width: 12),
            _buildTabletSocialIcon(Icons.chat, 'https://twitter.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(16.0),
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
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFE0E0E0),
                    width: 1.0,
                  ),
                ),
              ),
              child: const Text(
                'creative agency',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontWeight: FontWeight.w300,
                  fontSize: 10,
                  letterSpacing: 1.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Açıklama
        Text(
          '2019 yılından bu yana dijital dünyada yaratıcılık ve teknolojiyi harmanlayarak, müşterilerimizin başarısı için çalışan güvenilir bir partneriz.',
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFFB0B0B0),
            height: 1.4,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 16),

        // Sosyal medya
        Row(
          children: [
            _buildSocialIcon(Icons.facebook, 'https://facebook.com'),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.camera_alt, 'https://instagram.com'),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.business, 'https://linkedin.com'),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.chat, 'https://twitter.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileSocialIcon(IconData icon, String url) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Icon(icon, color: const Color(0xFFE0E0E0), size: 14),
    );
  }

  Widget _buildTabletSocialIcon(IconData icon, String url) {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Icon(icon, color: const Color(0xFFE0E0E0), size: 16),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Icon(icon, color: const Color(0xFFE0E0E0), size: 16),
    );
  }

  Widget _buildMobileFooterLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Hızlı Linkler',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        _buildMobileFooterLink('Ana Sayfa'),
        _buildMobileFooterLink('Hakkımızda'),
        _buildMobileFooterLink('Projelerimiz'),
        _buildMobileFooterLink('Konferanslar'),
        _buildMobileFooterLink('İletişim'),
      ],
    );
  }

  Widget _buildTabletFooterLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hızlı Linkler',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 14),
        _buildTabletFooterLink('Ana Sayfa'),
        _buildTabletFooterLink('Hakkımızda'),
        _buildTabletFooterLink('Projelerimiz'),
        _buildTabletFooterLink('Konferanslar'),
        _buildTabletFooterLink('İletişim'),
      ],
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hızlı Linkler',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        _buildFooterLink('Ana Sayfa'),
        _buildFooterLink('Hakkımızda'),
        _buildFooterLink('Projelerimiz'),
        _buildFooterLink('Konferanslar'),
        _buildFooterLink('İletişim'),
      ],
    );
  }

  Widget _buildMobileFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: _HoverableFooterLink(
        text: text,
        fontSize: 10,
        textAlign: TextAlign.center,
        onTap: () {
          switch (text) {
            case 'Ana Sayfa':
              NavigationService.goToHome();
              break;
            case 'Hakkımızda':
              NavigationService.goToAbout();
              break;
            case 'Projelerimiz':
              NavigationService.goToWorks();
              break;
            case 'Konferanslar':
              NavigationService.goToConferences();
              break;
            case 'İletişim':
              NavigationService.goToContact();
              break;
          }
        },
      ),
    );
  }

  Widget _buildTabletFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: _HoverableFooterLink(
        text: text,
        fontSize: 11,
        onTap: () {
          switch (text) {
            case 'Ana Sayfa':
              NavigationService.goToHome();
              break;
            case 'Hakkımızda':
              NavigationService.goToAbout();
              break;
            case 'Projelerimiz':
              NavigationService.goToWorks();
              break;
            case 'Konferanslar':
              NavigationService.goToConferences();
              break;
            case 'İletişim':
              NavigationService.goToContact();
              break;
          }
        },
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _HoverableFooterLink(
        text: text,
        fontSize: 12,
        onTap: () {
          switch (text) {
            case 'Ana Sayfa':
              NavigationService.goToHome();
              break;
            case 'Hakkımızda':
              NavigationService.goToAbout();
              break;
            case 'Projelerimiz':
              NavigationService.goToWorks();
              break;
            case 'Konferanslar':
              NavigationService.goToConferences();
              break;
            case 'İletişim':
              NavigationService.goToContact();
              break;
          }
        },
      ),
    );
  }

  Widget _buildMobileFooterContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'İletişim',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        _buildMobileContactItem(Icons.email, 'info@seboagence.com'),
        _buildMobileContactItem(Icons.phone, '+90 (212) 555 0123'),
        _buildMobileContactItem(Icons.location_on, 'İstanbul, Türkiye'),
      ],
    );
  }

  Widget _buildTabletFooterContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'İletişim',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 14),
        _buildTabletContactItem(Icons.email, 'info@seboagence.com'),
        _buildTabletContactItem(Icons.phone, '+90 (212) 555 0123'),
        _buildTabletContactItem(Icons.location_on, 'İstanbul, Türkiye'),
      ],
    );
  }

  Widget _buildFooterContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'İletişim',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactItem(Icons.email, 'info@seboagence.com'),
        _buildContactItem(Icons.phone, '+90 (212) 555 0123'),
        _buildContactItem(Icons.location_on, 'İstanbul, Türkiye'),
      ],
    );
  }

  Widget _buildMobileContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFB0B0B0), size: 12),
          const SizedBox(width: 6),
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(
              color: const Color(0xFFB0B0B0),
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFB0B0B0), size: 14),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTypography.bodyMedium.copyWith(
              color: const Color(0xFFB0B0B0),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFB0B0B0), size: 14),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTypography.bodyMedium.copyWith(
              color: const Color(0xFFB0B0B0),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileFooterBottom() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      child: Column(
        children: [
          Text(
            '© 2024 Şebo Agence. Tüm hakları saklıdır.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Geliştirildi ❤️ ile',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletFooterBottom() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2024 Şebo Agence. Tüm hakları saklıdır.',
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 9,
            ),
          ),
          Text(
            'Geliştirildi ❤️ ile',
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBottom() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2024 Şebo Agence. Tüm hakları saklıdır.',
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 10,
            ),
          ),
          Text(
            'Geliştirildi ❤️ ile',
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// Hoverable Footer Link Widget
class _HoverableFooterLink extends StatefulWidget {
  final String text;
  final double fontSize;
  final TextAlign? textAlign;
  final VoidCallback onTap;

  const _HoverableFooterLink({
    required this.text,
    required this.fontSize,
    this.textAlign,
    required this.onTap,
  });

  @override
  State<_HoverableFooterLink> createState() => _HoverableFooterLinkState();
}

class _HoverableFooterLinkState extends State<_HoverableFooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Text(
            widget.text,
            textAlign: widget.textAlign,
            style: AppTypography.bodyMedium.copyWith(
              color: _isHovered ? Colors.white : const Color(0xFFB0B0B0),
              fontSize: widget.fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
