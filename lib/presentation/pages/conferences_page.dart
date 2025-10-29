/// 🎤 Conferences Page - Konferanslar sayfası
///
/// Bu sayfa, ajansın düzenlediği tüm konferans ve etkinlikleri sergiler.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/utils/responsive.dart';
import '../widgets/optimized_navigation_bar.dart';
import '../widgets/common/footer_widget.dart';

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
          const FooterWidget(),
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
          _buildNoUpcomingEventsMessage(context),
        ],
      ),
    );
  }

  Widget _buildNoUpcomingEventsMessage(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.all(isMobile ? 24.0 : 32.0),
      decoration: BoxDecoration(
        color: Branding.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Branding.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.event_busy_outlined,
            color: Branding.white.withValues(alpha: 0.6),
            size: isMobile ? 48.0 : 64.0,
          ),
          SizedBox(height: Branding.spacingM),
          Text(
            'Yaklaşan Etkinlik Bulunmuyor',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 20.0 : 24.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Şu anda planlanmış yaklaşan etkinliğimiz bulunmamaktadır.\nYeni etkinlikler için takipte kalın!',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.7),
              fontSize: isMobile ? 14.0 : 16.0,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
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
          title: 'CCI France Turquie Etkinliği',
          date: 'Aralık 2025',
          participants: '150+ Katılımcı',
          description: 'Fransız Ticaret Odası Türkiye ile işbirliği etkinliği',
          color: Branding.secondary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildPastEventCard(
          title: 'Fransız Ticaret Odası Konferansı',
          date: 'Kasım 2025',
          participants: '200+ Katılımcı',
          description:
              'CCI France Turquie ile ortak düzenlenen ticaret konferansı',
          color: Branding.primary,
        ),
        SizedBox(height: Branding.spacingL),
        _buildPastEventCard(
          title: 'CCI France Turquie İşbirliği Etkinliği',
          date: 'Ekim 2025',
          participants: '120+ Katılımcı',
          description: 'Fransız-Türk iş dünyası arasında köprü kuran etkinlik',
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
                title: 'CCI France Turquie Etkinliği',
                date: 'Aralık 2025',
                participants: '150+ Katılımcı',
                description:
                    'Fransız Ticaret Odası Türkiye ile işbirliği etkinliği',
                color: Branding.secondary,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(
              child: _buildPastEventCard(
                title: 'Fransız Ticaret Odası Konferansı',
                date: 'Kasım 2025',
                participants: '200+ Katılımcı',
                description:
                    'CCI France Turquie ile ortak düzenlenen ticaret konferansı',
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
                title: 'CCI France Turquie İşbirliği Etkinliği',
                date: 'Ekim 2025',
                participants: '120+ Katılımcı',
                description:
                    'Fransız-Türk iş dünyası arasında köprü kuran etkinlik',
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
            title: 'CCI France Turquie Etkinliği',
            date: 'Aralık 2025',
            participants: '150+ Katılımcı',
            description:
                'Fransız Ticaret Odası Türkiye ile işbirliği etkinliği',
            color: Branding.secondary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildPastEventCard(
            title: 'Fransız Ticaret Odası Konferansı',
            date: 'Kasım 2025',
            participants: '200+ Katılımcı',
            description:
                'CCI France Turquie ile ortak düzenlenen ticaret konferansı',
            color: Branding.primary,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildPastEventCard(
            title: 'CCI France Turquie İşbirliği Etkinliği',
            date: 'Ekim 2025',
            participants: '120+ Katılımcı',
            description:
                'Fransız-Türk iş dünyası arasında köprü kuran etkinlik',
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
                color: Branding.white,
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
              Icon(Icons.calendar_today, color: Branding.white, size: 16.0),
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
              Icon(Icons.people, color: Branding.white, size: 16.0),
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

// Footer section replaced by common FooterWidget
