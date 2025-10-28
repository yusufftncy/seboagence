/// 🌿 Şifa İpek Projesi Detay Sayfası
///
/// Bu sayfa, Şifa İpek projesinin detaylarını gösterir.
/// Yeşil ve beyaz renk teması kullanılır.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/utils/responsive.dart';
import '../../core/services/navigation_service.dart';
import '../widgets/optimized_navigation_bar.dart';

class SifaIpekDetailPage extends ConsumerWidget {
  const SifaIpekDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE), // Açık yeşil arka plan
      body: Column(
        children: [
          const OptimizedNavigationBar(),
          Expanded(child: _SifaIpekDetailContent()),
        ],
      ),
    );
  }
}

/// Şifa İpek Detay İçeriği
class _SifaIpekDetailContent extends StatelessWidget {
  const _SifaIpekDetailContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _HeroSection(),
          _ProjectOverviewSection(),
          _ImpactSection(),
          _GallerySection(),
          _PartnersSection(),
          _CustomFooter(),
        ],
      ),
    );
  }
}

/// Hero Section - Yeşil tema
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
          colors: [
            Color(0xFF10B981), // Yeşil
            Color(0xFF059669), // Koyu yeşil
          ],
        ),
      ),
      child: Column(
        children: [
          // Proje ikonu
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.favorite, color: Colors.white, size: 48),
          ),
          SizedBox(height: isMobile ? Branding.spacingL : Branding.spacingXXL),

          // Ana başlık
          Text(
            'Şifa İpek Projesi',
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile
                  ? 32.0
                  : isTablet
                  ? 40.0
                  : 48.0,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? Branding.spacingM : Branding.spacingL),

          // Alt başlık
          Text(
            'Hatay\'da Barış İpeği ile Sosyal Sorumluluk',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: isMobile
                  ? 16.0
                  : isTablet
                  ? 18.0
                  : 20.0,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? Branding.spacingXL : Branding.spacingXXL),

          // Kategori etiketi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: const Text(
              'Sosyal Sorumluluk Projesi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Proje Genel Bakış Bölümü
class _ProjectOverviewSection extends StatelessWidget {
  const _ProjectOverviewSection();

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
            'Proje Hakkında',
            style: TextStyle(
              color: const Color(0xFF1F2937),
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingL),

          Text(
            'Hatay\'da yetişen Barış ipeği ve Hatay depreminden sonra köylerde yaşayan kadın çiftçilerin tezgahlarında dokudukları ürünlerin değere döndürülmesine yardım eden sosyal sorumluluk projesi.',
            style: TextStyle(
              color: const Color(0xFF6B7280),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXXL),

          // Özellikler grid'i
          Responsive.responsiveWidget(
            context,
            mobile: _buildMobileFeatures(),
            tablet: _buildTabletFeatures(),
            desktop: _buildDesktopFeatures(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileFeatures() {
    return Column(
      children: [
        _buildFeatureCard(
          icon: Icons.location_on,
          title: 'Hatay, Türkiye',
          description: 'Proje lokasyonu',
          color: const Color(0xFF10B981),
        ),
        SizedBox(height: Branding.spacingL),
        _buildFeatureCard(
          icon: Icons.people,
          title: 'Kadın Çiftçiler',
          description: 'Yerel topluluk desteği',
          color: const Color(0xFF10B981),
        ),
        SizedBox(height: Branding.spacingL),
        _buildFeatureCard(
          icon: Icons.eco,
          title: 'Sürdürülebilir',
          description: 'Çevre dostu üretim',
          color: const Color(0xFF10B981),
        ),
      ],
    );
  }

  Widget _buildTabletFeatures() {
    return Row(
      children: [
        Expanded(
          child: _buildFeatureCard(
            icon: Icons.location_on,
            title: 'Hatay, Türkiye',
            description: 'Proje lokasyonu',
            color: const Color(0xFF10B981),
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildFeatureCard(
            icon: Icons.people,
            title: 'Kadın Çiftçiler',
            description: 'Yerel topluluk desteği',
            color: const Color(0xFF10B981),
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildFeatureCard(
            icon: Icons.eco,
            title: 'Sürdürülebilir',
            description: 'Çevre dostu üretim',
            color: const Color(0xFF10B981),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopFeatures() {
    return Row(
      children: [
        Expanded(
          child: _buildFeatureCard(
            icon: Icons.location_on,
            title: 'Hatay, Türkiye',
            description: 'Proje lokasyonu',
            color: const Color(0xFF10B981),
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildFeatureCard(
            icon: Icons.people,
            title: 'Kadın Çiftçiler',
            description: 'Yerel topluluk desteği',
            color: const Color(0xFF10B981),
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildFeatureCard(
            icon: Icons.eco,
            title: 'Sürdürülebilir',
            description: 'Çevre dostu üretim',
            color: const Color(0xFF10B981),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          SizedBox(height: Branding.spacingM),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Etki Bölümü
class _ImpactSection extends StatelessWidget {
  const _ImpactSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? Branding.spacingL : Branding.spacingXXL,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF10B981).withValues(alpha: 0.05),
            const Color(0xFF059669).withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Proje Etkisi',
            style: TextStyle(
              color: const Color(0xFF1F2937),
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingL),
          Text(
            'Hatay depreminden sonra kadın çiftçilerin ekonomik güçlenmesi ve geleneksel el sanatlarının korunması',
            style: TextStyle(
              color: const Color(0xFF6B7280),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXXL),

          // İstatistikler
          Responsive.responsiveWidget(
            context,
            mobile: _buildMobileStats(),
            tablet: _buildTabletStats(),
            desktop: _buildDesktopStats(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileStats() {
    return Column(
      children: [
        _buildStatCard('50+', 'Kadın Çiftçi', const Color(0xFF10B981)),
        SizedBox(height: Branding.spacingL),
        _buildStatCard('200+', 'Üretilen Ürün', const Color(0xFF10B981)),
        SizedBox(height: Branding.spacingL),
        _buildStatCard('15', 'Köy', const Color(0xFF10B981)),
      ],
    );
  }

  Widget _buildTabletStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('50+', 'Kadın Çiftçi', const Color(0xFF10B981)),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildStatCard(
            '200+',
            'Üretilen Ürün',
            const Color(0xFF10B981),
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(child: _buildStatCard('15', 'Köy', const Color(0xFF10B981))),
      ],
    );
  }

  Widget _buildDesktopStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('50+', 'Kadın Çiftçi', const Color(0xFF10B981)),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildStatCard(
            '200+',
            'Üretilen Ürün',
            const Color(0xFF10B981),
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(child: _buildStatCard('15', 'Köy', const Color(0xFF10B981))),
      ],
    );
  }

  Widget _buildStatCard(String number, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              color: color,
              fontSize: 36,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Galeri Bölümü - Slider
class _GallerySection extends StatelessWidget {
  const _GallerySection();

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
            'Proje Galerisi',
            style: TextStyle(
              color: const Color(0xFF1F2937),
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingL),
          Text(
            'Hatay\'daki kadın çiftçilerin el emeği göz nuru ürünleri',
            style: TextStyle(
              color: const Color(0xFF6B7280),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXXL),

          // Slider
          SizedBox(
            height: isMobile ? 200 : 300,
            child: PageView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    border: Border.all(
                      color: const Color(0xFF10B981).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: const Color(0xFF10B981),
                          size: 48,
                        ),
                        SizedBox(height: Branding.spacingM),
                        Text(
                          'Galeri Görseli ${index + 1}',
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Partnerler Bölümü
class _PartnersSection extends StatelessWidget {
  const _PartnersSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? Branding.spacingL : Branding.spacingXXL,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF10B981).withValues(alpha: 0.05),
            const Color(0xFF059669).withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Proje Ortakları',
            style: TextStyle(
              color: const Color(0xFF1F2937),
              fontSize: isMobile ? 28.0 : 36.0,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingL),
          Text(
            'Bu projeyi mümkün kılan değerli ortaklarımız',
            style: TextStyle(
              color: const Color(0xFF6B7280),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXXL),

          // Partner kartları
          Responsive.responsiveWidget(
            context,
            mobile: _buildMobilePartners(),
            tablet: _buildTabletPartners(),
            desktop: _buildDesktopPartners(),
          ),
        ],
      ),
    );
  }

  Widget _buildMobilePartners() {
    return Column(
      children: [
        _buildPartnerCard('Hatay Valiliği', 'Resmi Destek'),
        SizedBox(height: Branding.spacingL),
        _buildPartnerCard('Kadın Kooperatifi', 'Yerel Organizasyon'),
        SizedBox(height: Branding.spacingL),
        _buildPartnerCard('Sivil Toplum', 'Gönüllü Destek'),
      ],
    );
  }

  Widget _buildTabletPartners() {
    return Row(
      children: [
        Expanded(child: _buildPartnerCard('Hatay Valiliği', 'Resmi Destek')),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildPartnerCard('Kadın Kooperatifi', 'Yerel Organizasyon'),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(child: _buildPartnerCard('Sivil Toplum', 'Gönüllü Destek')),
      ],
    );
  }

  Widget _buildDesktopPartners() {
    return Row(
      children: [
        Expanded(child: _buildPartnerCard('Hatay Valiliği', 'Resmi Destek')),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _buildPartnerCard('Kadın Kooperatifi', 'Yerel Organizasyon'),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(child: _buildPartnerCard('Sivil Toplum', 'Gönüllü Destek')),
      ],
    );
  }

  Widget _buildPartnerCard(String name, String role) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.handshake,
              color: Color(0xFF10B981),
              size: 32,
            ),
          ),
          SizedBox(height: Branding.spacingM),
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            role,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Özel Footer Widget - Ana sayfadaki footer tasarımını baz alır
class _CustomFooter extends StatelessWidget {
  const _CustomFooter();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? Branding.spacingL : Branding.spacingXXL,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF131B2E), // Dark blue-grey - Ana sayfa ile aynı
      ),
      child: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileFooter(),
        tablet: _buildTabletFooter(),
        desktop: _buildDesktopFooter(),
      ),
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      children: [
        _buildFooterLogo(),
        const SizedBox(height: 20),
        _buildFooterLinks(),
        const SizedBox(height: 20),
        _buildFooterContact(),
        const SizedBox(height: 20),
        _buildFooterBottom(),
      ],
    );
  }

  Widget _buildTabletFooter() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildFooterLogo()),
            const SizedBox(width: 20),
            Expanded(flex: 1, child: _buildFooterLinks()),
            const SizedBox(width: 20),
            Expanded(flex: 1, child: _buildFooterContact()),
          ],
        ),
        const SizedBox(height: 24),
        _buildFooterBottom(),
      ],
    );
  }

  Widget _buildDesktopFooter() {
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
                color: const Color(0xFFE0E0E0), // Ana sayfa ile aynı
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Text(
                'ŞEBO',
                style: TextStyle(
                  color: Color(0xFF4A4A4A), // Ana sayfa ile aynı
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
                    color: const Color(0xFFE0E0E0), // Ana sayfa ile aynı
                    width: 1.0,
                  ),
                ),
              ),
              child: const Text(
                'creative agency',
                style: TextStyle(
                  color: Color(0xFFE0E0E0), // Ana sayfa ile aynı
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
          'Yaratıcı ve yenilikçi çözümler sunan premium dijital ajans olarak, müşterilerimize en iyi hizmeti sunmayı hedefliyoruz.',
          style: const TextStyle(
            color: Color(0xFFB0B0B0),
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

  Widget _buildFooterLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hızlı Linkler',
          style: TextStyle(
            color: Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        _buildFooterLink('Ana Sayfa', () => NavigationService.goToHome()),
        _buildFooterLink('Hakkımızda', () => NavigationService.goToAbout()),
        _buildFooterLink('Projelerimiz', () => NavigationService.goToWorks()),
        _buildFooterLink(
          'Konferanslar',
          () => NavigationService.goToConferences(),
        ),
        _buildFooterLink('İletişim', () => NavigationService.goToContact()),
      ],
    );
  }

  Widget _buildFooterContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'İletişim',
          style: TextStyle(
            color: Color(0xFFE0E0E0),
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

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _HoverableFooterLink(text: text, fontSize: 12, onTap: onTap),
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
            style: const TextStyle(color: Color(0xFFB0B0B0), fontSize: 12),
          ),
        ],
      ),
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

  Widget _buildFooterBottom() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '© 2024 Şebo Agence. Tüm hakları saklıdır.',
            style: TextStyle(color: Color(0xFF808080), fontSize: 10),
          ),
          const Text(
            'Geliştirildi ❤️ ile',
            style: TextStyle(color: Color(0xFF808080), fontSize: 10),
          ),
        ],
      ),
    );
  }
}

/// Hoverable Footer Link Widget
class _HoverableFooterLink extends StatefulWidget {
  final String text;
  final double fontSize;
  final VoidCallback onTap;

  const _HoverableFooterLink({
    required this.text,
    required this.fontSize,
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
            style: TextStyle(
              color: _isHovered ? Colors.white : const Color(0xFFB0B0B0),
              fontSize: widget.fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
