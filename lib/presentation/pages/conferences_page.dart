/// 🎤 Conferences Page - Konferanslar sayfası
///
/// Bu sayfa, ajansın düzenlediği tüm konferans ve etkinlikleri sergiler.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/utils/responsive.dart';
import '../../core/services/navigation_service.dart';
import '../widgets/optimized_navigation_bar.dart';

class ConferencesPage extends ConsumerWidget {
  const ConferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF131B2E),
      body: Column(
        children: [
          const OptimizedNavigationBar(),
          Expanded(child: _ConferencesPageContent()),
        ],
      ),
    );
  }
}

/// Conferences Page Content
class _ConferencesPageContent extends StatelessWidget {
  const _ConferencesPageContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _HeroSection(),
          _UpcomingEventsSection(),
          _PastEventsSection(),
          _FooterSection(),
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
          Text(
            'Konferanslar & Etkinlikler',
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
          Text(
            'Dijital Dünyada Bilgi Paylaşımı ve Networking',
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
          Text(
            'Sektörün önde gelen uzmanlarıyla buluştuğumuz, bilgi paylaştığımız ve network kurduğumuz etkinliklerimiz.',
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

/// Upcoming Events Section
class _UpcomingEventsSection extends StatelessWidget {
  const _UpcomingEventsSection();

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
            'Yaklaşan Etkinlikler',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Önümüzdeki dönemde gerçekleşecek konferanslarımız',
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
            mobile: _buildMobileUpcomingEvents(),
            tablet: _buildTabletUpcomingEvents(),
            desktop: _buildDesktopUpcomingEvents(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileUpcomingEvents() {
    return Column(
      children: [
        _buildEventCard(
          title: 'Dijital Pazarlama Zirvesi 2024',
          date: '15 Mart 2024',
          location: 'İstanbul Kongre Merkezi',
          description: 'Dijital pazarlama trendleri ve gelecek stratejileri',
          type: 'Konferans',
          color: Branding.primary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildEventCard(
          title: 'E-ticaret Masterclass',
          date: '22 Mart 2024',
          location: 'Online',
          description: 'E-ticaret dünyasında başarılı olmanın sırları',
          type: 'Workshop',
          color: Branding.secondary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildEventCard(
          title: 'Sosyal Medya Stratejileri',
          date: '5 Nisan 2024',
          location: 'Ankara Üniversitesi',
          description: 'Etkili sosyal medya yönetimi ve içerik stratejileri',
          type: 'Seminer',
          color: Branding.primary,
        ),
      ],
    );
  }

  Widget _buildTabletUpcomingEvents() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildEventCard(
                title: 'Dijital Pazarlama Zirvesi 2024',
                date: '15 Mart 2024',
                location: 'İstanbul Kongre Merkezi',
                description:
                    'Dijital pazarlama trendleri ve gelecek stratejileri',
                type: 'Konferans',
                color: Branding.primary,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(
              child: _buildEventCard(
                title: 'E-ticaret Masterclass',
                date: '22 Mart 2024',
                location: 'Online',
                description: 'E-ticaret dünyasında başarılı olmanın sırları',
                type: 'Workshop',
                color: Branding.secondary,
              ),
            ),
          ],
        ),
        SizedBox(height: Branding.spacingL),
        Row(
          children: [
            Expanded(
              child: _buildEventCard(
                title: 'Sosyal Medya Stratejileri',
                date: '5 Nisan 2024',
                location: 'Ankara Üniversitesi',
                description:
                    'Etkili sosyal medya yönetimi ve içerik stratejileri',
                type: 'Seminer',
                color: Branding.primary,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(child: Container()), // Boş alan
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopUpcomingEvents() {
    return Row(
      children: [
        Expanded(
          child: _buildEventCard(
            title: 'Dijital Pazarlama Zirvesi 2024',
            date: '15 Mart 2024',
            location: 'İstanbul Kongre Merkezi',
            description: 'Dijital pazarlama trendleri ve gelecek stratejileri',
            type: 'Konferans',
            color: Branding.primary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildEventCard(
            title: 'E-ticaret Masterclass',
            date: '22 Mart 2024',
            location: 'Online',
            description: 'E-ticaret dünyasında başarılı olmanın sırları',
            type: 'Workshop',
            color: Branding.secondary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildEventCard(
            title: 'Sosyal Medya Stratejileri',
            date: '5 Nisan 2024',
            location: 'Ankara Üniversitesi',
            description: 'Etkili sosyal medya yönetimi ve içerik stratejileri',
            type: 'Seminer',
            color: Branding.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard({
    required String title,
    required String date,
    required String location,
    required String description,
    required String type,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Etkinlik türü etiketi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              type,
              style: TextStyle(
                color: color,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: Branding.spacingL),

          // Etkinlik başlığı
          Text(
            title,
            style: const TextStyle(
              color: Branding.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: Branding.spacingS),

          // Tarih ve lokasyon
          Row(
            children: [
              Icon(Icons.calendar_today, color: color, size: 16.0),
              SizedBox(width: 8),
              Text(
                date,
                style: TextStyle(
                  color: Branding.white.withValues(alpha: 0.8),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, color: color, size: 16.0),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(
                    color: Branding.white.withValues(alpha: 0.8),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Branding.spacingL),

          // Açıklama
          Text(
            description,
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.7),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          SizedBox(height: Branding.spacingL),

          // Kayıt ol butonu
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              padding: const EdgeInsets.symmetric(
                horizontal: Branding.spacingL,
                vertical: Branding.spacingM,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Branding.borderRadiusM),
              ),
            ),
            child: const Text(
              'Kayıt Ol',
              style: TextStyle(
                color: Branding.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Past Events Section
class _PastEventsSection extends StatelessWidget {
  const _PastEventsSection();

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
            'Geçmiş Etkinlikler',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Düzenlediğimiz başarılı konferans ve etkinlikler',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.9),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXL),
          Responsive.responsiveWidget(
            context,
            mobile: _buildMobilePastEvents(),
            tablet: _buildTabletPastEvents(),
            desktop: _buildDesktopPastEvents(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobilePastEvents() {
    return Column(
      children: [
        _buildPastEventCard(
          title: 'Dijital Dönüşüm Konferansı 2023',
          date: '15 Aralık 2023',
          participants: '250+ Katılımcı',
          description: 'İş dünyasında dijital dönüşümün etkileri',
          color: Branding.secondary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildPastEventCard(
          title: 'Startup Ekosistemi Paneli',
          date: '8 Kasım 2023',
          participants: '180+ Katılımcı',
          description: 'Türkiye startup ekosisteminin geleceği',
          color: Branding.primary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildPastEventCard(
          title: 'E-ticaret Workshop Serisi',
          date: '20 Ekim 2023',
          participants: '120+ Katılımcı',
          description: 'E-ticaret platformları ve pazarlama stratejileri',
          color: Branding.secondary,
        ),
      ],
    );
  }

  Widget _buildTabletPastEvents() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildPastEventCard(
                title: 'Dijital Dönüşüm Konferansı 2023',
                date: '15 Aralık 2023',
                participants: '250+ Katılımcı',
                description: 'İş dünyasında dijital dönüşümün etkileri',
                color: Branding.secondary,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(
              child: _buildPastEventCard(
                title: 'Startup Ekosistemi Paneli',
                date: '8 Kasım 2023',
                participants: '180+ Katılımcı',
                description: 'Türkiye startup ekosisteminin geleceği',
                color: Branding.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: Branding.spacingL),
        Row(
          children: [
            Expanded(
              child: _buildPastEventCard(
                title: 'E-ticaret Workshop Serisi',
                date: '20 Ekim 2023',
                participants: '120+ Katılımcı',
                description: 'E-ticaret platformları ve pazarlama stratejileri',
                color: Branding.secondary,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(child: Container()), // Boş alan
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopPastEvents() {
    return Row(
      children: [
        Expanded(
          child: _buildPastEventCard(
            title: 'Dijital Dönüşüm Konferansı 2023',
            date: '15 Aralık 2023',
            participants: '250+ Katılımcı',
            description: 'İş dünyasında dijital dönüşümün etkileri',
            color: Branding.secondary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildPastEventCard(
            title: 'Startup Ekosistemi Paneli',
            date: '8 Kasım 2023',
            participants: '180+ Katılımcı',
            description: 'Türkiye startup ekosisteminin geleceği',
            color: Branding.primary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildPastEventCard(
            title: 'E-ticaret Workshop Serisi',
            date: '20 Ekim 2023',
            participants: '120+ Katılımcı',
            description: 'E-ticaret platformları ve pazarlama stratejileri',
            color: Branding.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildPastEventCard({
    required String title,
    required String date,
    required String participants,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başarılı etkinlik etiketi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Tamamlandı',
              style: TextStyle(
                color: color,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: Branding.spacingL),

          // Etkinlik başlığı
          Text(
            title,
            style: const TextStyle(
              color: Branding.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: Branding.spacingS),

          // Tarih ve katılımcı sayısı
          Row(
            children: [
              Icon(Icons.calendar_today, color: color, size: 16.0),
              SizedBox(width: 8),
              Text(
                date,
                style: TextStyle(
                  color: Branding.white.withValues(alpha: 0.95),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.people, color: color, size: 16.0),
              SizedBox(width: 8),
              Text(
                participants,
                style: TextStyle(
                  color: Branding.white.withValues(alpha: 0.95),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: Branding.spacingL),

          // Açıklama
          Text(
            description,
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.9),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          SizedBox(height: Branding.spacingL),

          // Detayları gör butonu
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Branding.white,
              side: BorderSide(color: Branding.white),
              padding: const EdgeInsets.symmetric(
                horizontal: Branding.spacingL,
                vertical: Branding.spacingM,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Branding.borderRadiusM),
              ),
            ),
            child: const Text(
              'Detayları Gör',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Branding.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Footer Section - Ana sayfadaki footer'ın aynısı
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.responsiveValue(
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
        Text(
          'Dijital dünyada yaratıcı çözümler',
          style: TextStyle(
            color: const Color(0xFFB0B0B0),
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMobileSocialIcon(Icons.business, 'https://linkedin.com'),
            const SizedBox(width: 12),
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
                  fontSize: 15,
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
        const SizedBox(height: 12),
        Text(
          'Dijital dünyada yaratıcı çözümler',
          style: TextStyle(
            color: const Color(0xFFB0B0B0),
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
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
        const SizedBox(height: 12),
        Text(
          'Dijital dünyada yaratıcı çözümler',
          style: TextStyle(
            color: const Color(0xFFB0B0B0),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSocialIcon(Icons.business, 'https://linkedin.com'),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.chat, 'https://twitter.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileFooterLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Hızlı Linkler',
          style: TextStyle(
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
          style: TextStyle(
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
          style: TextStyle(
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
          style: TextStyle(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        _buildMobileContactItem(Icons.email, 'info@ajanssebo.com'),
        _buildMobileContactItem(Icons.phone, '+90 (212) 123 45 67'),
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
          style: TextStyle(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 14),
        _buildTabletContactItem(Icons.email, 'info@ajanssebo.com'),
        _buildTabletContactItem(Icons.phone, '+90 (212) 123 45 67'),
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
          style: TextStyle(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactItem(Icons.email, 'info@ajanssebo.com'),
        _buildContactItem(Icons.phone, '+90 (212) 123 45 67'),
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
            style: TextStyle(
              color: const Color(0xFFB0B0B0),
              fontSize: 10,
              fontWeight: FontWeight.w400,
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
          Icon(icon, color: const Color(0xFFB0B0B0), size: 13),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: const Color(0xFFB0B0B0),
              fontSize: 11,
              fontWeight: FontWeight.w400,
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
            style: TextStyle(
              color: const Color(0xFFB0B0B0),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
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
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(6.0),
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
            style: TextStyle(
              color: const Color(0xFF808080),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Geliştirildi ❤️ ile',
            style: TextStyle(
              color: const Color(0xFF808080),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTabletFooterBottom() {
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
            style: TextStyle(
              color: const Color(0xFF808080),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'Geliştirildi ❤️ ile',
            style: TextStyle(
              color: const Color(0xFF808080),
              fontSize: 10,
              fontWeight: FontWeight.w400,
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
            style: TextStyle(
              color: const Color(0xFF808080),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'Geliştirildi ❤️ ile',
            style: TextStyle(
              color: const Color(0xFF808080),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// Hoverable Footer Link Widget - Ana sayfadaki ile aynı
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
            style: TextStyle(
              color: _isHovered ? Colors.white : const Color(0xFFB0B0B0),
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
