/// 🏠 Home Page - Ana sayfa
///
/// Bu sayfa, uygulamanın ana sayfasıdır.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';
import '../../core/services/navigation_service.dart';
import '../widgets/optimized_navigation_bar.dart';
import '../widgets/common/footer_widget.dart';
import 'sifa_ipek_detail_page.dart';
import 'empowerment_voice_seminar_detail_page.dart';
import 'cci_france_turquie_event_detail_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late AnimationController _heroAnimationController;
  late AnimationController _fadeAnimationController;
  late AnimationController _slideAnimationController;

  late Animation<double> _heroAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isLinkedInHovered = false;

  @override
  void initState() {
    super.initState();

    _heroAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _heroAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _heroAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _slideAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Start animations
    _heroAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeAnimationController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _slideAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _heroAnimationController.dispose();
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Branding.backgroundPrimary,
      body: Column(
        children: [
          // Ultra-Optimized Navigation Bar
          const OptimizedNavigationBar(),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Hero Section - Şebo Ajans Tanıtımı
                  _buildAgencyHeroSection(context),

                  // About Section - Kimim, Ne Yapıyoruz, Neden Çalışıyoruz
                  _buildAgencyAboutSection(context),

                  // Projects Section - Hoş İşler (Şebo Ajans'ın Projeleri)
                  _buildAgencyProjectsSection(context),

                  // Conferences Section - Yurt Dışı Konferanslar & Etkinlikler
                  _buildConferencesSection(context),

                  // Footer
                  const FooterWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgencyHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Responsive.responsiveValue(
        context,
        mobile: Responsive.screenHeight(context), // Tam ekran mobil
        tablet: Responsive.screenHeight(context), // Tam ekran tablet
        desktop: Responsive.screenHeight(context) * 0.9, // %90 desktop
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF131B2E), // rgba(19, 27, 46) - Dark blue-grey
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B2E).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Pattern
          _buildBackgroundPattern(context),

          // Main Content
          Center(
            child: SingleChildScrollView(
              padding: Responsive.responsivePadding(
                context,
                mobile: const EdgeInsets.all(16.0),
                tablet: const EdgeInsets.all(20.0),
                desktop: const EdgeInsets.all(20.0),
              ),
              child: AnimatedBuilder(
                animation: _heroAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 0.8 + (0.2 * _heroAnimation.value),
                    child: Opacity(
                      opacity: _heroAnimation.value,
                      child: Responsive.responsiveWidget(
                        context,
                        mobile: _buildMobileHeroContent(context),
                        tablet: _buildTabletHeroContent(context),
                        desktop: _buildDesktopHeroContent(context),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileHeroContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Main Title - H1 for SEO (Mobile)
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Semantics(
              header: true,
              child: Text(
                'Ajans Şebo',
                style: AppTypography.h1.copyWith(
                  color: Branding.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      color: Branding.black.withValues(alpha: 0.3),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Agency Tagline - Mobile'da kompakt
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Branding.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Branding.white.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                'Yaratıcı Dijital Çözümler',
                style: AppTypography.h5.copyWith(
                  color: Branding.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Subtitle - Mobile'da küçük
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Text(
              'Dijital dünyada markanızı öne çıkaran\nstratejik ve yaratıcı çözümler',
              style: AppTypography.h4.copyWith(
                color: Branding.white.withValues(alpha: 0.9),
                fontSize: 14,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.8,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // CTA Buttons - Mobile'da dikey
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: _buildMobileHeroButtons(context),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletHeroContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Main Title - H1 for SEO
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Semantics(
              header: true,
              child: Text(
                'Ajans Şebo',
                style: AppTypography.h1.copyWith(
                  color: Branding.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.5,
                  shadows: [
                    Shadow(
                      color: Branding.black.withValues(alpha: 0.3),
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Agency Tagline
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Branding.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Branding.white.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                'Yaratıcı Dijital Çözümler',
                style: AppTypography.h5.copyWith(
                  color: Branding.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Subtitle
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Text(
              'Dijital dünyada markanızı öne çıkaran\nstratejik ve yaratıcı çözümler',
              style: AppTypography.h4.copyWith(
                color: Branding.white.withValues(alpha: 0.9),
                fontSize: 18,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.0,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        const SizedBox(height: 28),

        // CTA Buttons
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: _buildTabletHeroButtons(context),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopHeroContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Main Title - H1 for SEO
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Semantics(
              header: true,
              child: Text(
                'Ajans Şebo',
                style: AppTypography.h1.copyWith(
                  color: Branding.white,
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.5,
                  shadows: [
                    Shadow(
                      color: Branding.black.withValues(alpha: 0.3),
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Agency Tagline
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: Branding.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Branding.white.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Text(
                'Yaratıcı Dijital Çözümler',
                style: AppTypography.h5.copyWith(
                  color: Branding.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Subtitle
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Text(
              'Dijital dünyada markanızı öne çıkaran\nstratejik ve yaratıcı çözümler',
              style: AppTypography.h4.copyWith(
                color: Branding.white.withValues(alpha: 0.9),
                fontSize: 22,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.0,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        const SizedBox(height: 28),

        // CTA Buttons
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: _buildDesktopHeroButtons(context),
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundPattern(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _BackgroundPatternPainter(),
    );
  }

  Widget _buildMobileHeroButtons(BuildContext context) {
    return Column(
      children: [
        _buildMobilePrimaryButton(context),
        const SizedBox(height: 12),
        _buildMobileSecondaryButton(context),
      ],
    );
  }

  Widget _buildTabletHeroButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTabletPrimaryButton(context),
        const SizedBox(width: 16),
        _buildTabletSecondaryButton(context),
      ],
    );
  }

  Widget _buildDesktopHeroButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDesktopPrimaryButton(context),
        const SizedBox(width: 20),
        _buildDesktopSecondaryButton(context),
      ],
    );
  }

  Widget _buildMobilePrimaryButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0), // Light grey
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E0E0).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          NavigationService.goToContact();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'Hemen İletişime Geç',
          style: AppTypography.button.copyWith(
            color: const Color(0xFF4A4A4A), // Medium grey
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildMobileSecondaryButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        NavigationService.goToWorks();
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Color(0xFFE0E0E0), // Light grey border
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        'Projelerimizi İncele',
        style: AppTypography.button.copyWith(
          color: const Color(0xFFE0E0E0), // Light grey
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTabletPrimaryButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0), // Light grey
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E0E0).withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          NavigationService.goToContact();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          'Hemen İletişime Geç',
          style: AppTypography.button.copyWith(
            color: const Color(0xFF4A4A4A), // Medium grey
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildTabletSecondaryButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        NavigationService.goToWorks();
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Color(0xFFE0E0E0), // Light grey border
          width: 1.8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        'Projelerimizi İncele',
        style: AppTypography.button.copyWith(
          color: const Color(0xFFE0E0E0), // Light grey
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDesktopPrimaryButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0), // Light grey
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E0E0).withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          NavigationService.goToContact();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'Hemen İletişime Geç',
          style: AppTypography.button.copyWith(
            color: const Color(0xFF4A4A4A), // Medium grey
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopSecondaryButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        NavigationService.goToWorks();
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Color(0xFFE0E0E0), // Light grey border
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        'Projelerimizi İncele',
        style: AppTypography.button.copyWith(
          color: const Color(0xFFE0E0E0), // Light grey
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAgencyProjectsSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.responsivePadding(
        context,
        mobile: const EdgeInsets.all(16.0),
        tablet: const EdgeInsets.all(20.0),
        desktop: const EdgeInsets.all(24.0),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF8F9FA), // Açık gri
            const Color(0xFFE9ECEF), // Yumuşak gri
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileProjectsSection(context),
        tablet: _buildTabletProjectsSection(context),
        desktop: _buildDesktopProjectsSection(context),
      ),
    );
  }

  Widget _buildMobileProjectsSection(BuildContext context) {
    return Column(
      children: [
        // Section Header - Mobile'da ortalanmış ve küçük
        Text(
          'Hoş İşler',
          style: AppTypography.h2.copyWith(
            color: const Color(0xFF2C2C2C),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        Text(
          'Sosyal Sorumluluk ve El Sanatları Platformu',
          style: AppTypography.h4.copyWith(
            color: const Color(0xFF6B6B6B),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 20),

        // Projects Grid - Mobile'da tek sütun
        _buildMobileProjectsGrid(context),
      ],
    );
  }

  Widget _buildTabletProjectsSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hoş İşler',
          style: AppTypography.h2.copyWith(
            color: const Color(0xFF2C2C2C),
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 12),

        Text(
          'Sosyal Sorumluluk ve El Sanatları Platformu',
          style: AppTypography.h4.copyWith(
            color: const Color(0xFF6B6B6B),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        _buildTabletProjectsGrid(context),
      ],
    );
  }

  Widget _buildDesktopProjectsSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hoş İşler',
          style: AppTypography.h2.copyWith(
            color: const Color(0xFF2C2C2C),
            fontSize: 42,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 16),

        Text(
          'Sosyal Sorumluluk ve El Sanatları Platformu',
          style: AppTypography.h4.copyWith(
            color: const Color(0xFF6B6B6B),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 32),

        _buildDesktopProjectsGrid(context),
      ],
    );
  }

  Widget _buildMobileProjectsGrid(BuildContext context) {
    final projects = _getProjectsData();

    return Column(
      children: projects.map((project) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildMobileProjectCard(context, project),
        );
      }).toList(),
    );
  }

  Widget _buildTabletProjectsGrid(BuildContext context) {
    final projects = _getProjectsData();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 sütun - yan yana
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.9, // Daha kompakt oran
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildTabletProjectCard(context, projects[index]);
      },
    );
  }

  Widget _buildDesktopProjectsGrid(BuildContext context) {
    final projects = _getProjectsData();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24.0,
        mainAxisSpacing: 24.0,
        childAspectRatio: 1.0, // Daha dengeli oran
      ),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return _buildDesktopProjectCard(context, projects[index]);
      },
    );
  }

  List<Map<String, dynamic>> _getProjectsData() {
    return [
      {
        'id': 'sifa',
        'title': 'Şifa İpek',
        'description':
            'Hatay\'da yetişen Barış ipeği ve Hatay depreminden sonra köylerde yaşayan kadın çiftçilerin tezgahlarında dokudukları ürünlerin değere döndürülmesine yardım eden sosyal sorumluluk projesi.',
        'image': 'assets/images/projects/sifa_project.jpg',
        'category': 'Sosyal',
        'icon': Icons.favorite,
        'color': const Color(0xFF10B981), // Yeşil
      },
      {
        'id': 'vefa',
        'title': 'Vefa',
        'description':
            'Alanya\'daki ailemden kalan kız meslek lisesi ve turizm otelcilik okulu öğrencilerine ve Alanya ile ilgili projeleri kapsayan eğitim ve gelişim platformu.',
        'image': 'assets/images/projects/vefa_project.jpg',
        'category': 'Eğitim',
        'icon': Icons.school,
        'color': const Color(0xFF3B82F6), // Mavi
      },
      {
        'id': 'sefa',
        'title': 'Sefa',
        'description':
            'Şifa İpeği ile üretilen keyifli ürünlerden oluşan bir seri. Geleneksel el sanatlarının modern yaşamla buluştuğu özel koleksiyon.',
        'image': 'assets/images/projects/sefa_project.jpg',
        'category': 'El Sanatları',
        'icon': Icons.palette,
        'color': const Color(0xFFF59E0B), // Turuncu
      },
    ];
  }

  Widget _buildMobileProjectCard(
    BuildContext context,
    Map<String, dynamic> project,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            (project['color'] as Color).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (project['color'] as Color).withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (project['color'] as Color).withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (project['id'] == 'sifa') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SifaIpekDetailPage(),
                ),
              );
            } else if (project['id'] == 'vefa') {
              NavigationService.goToVefa();
            } else if (project['id'] == 'sefa') {
              NavigationService.goToSefa();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Proje ikonu ve başlık - Mobile'da kompakt
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            (project['color'] as Color).withValues(alpha: 0.3),
                            (project['color'] as Color).withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        project['icon'] as IconData,
                        color: project['color'] as Color,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        project['title'] as String,
                        style: AppTypography.h5.copyWith(
                          color: const Color(0xFF2C2C2C),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (project['color'] as Color).withValues(
                          alpha: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '2023',
                        style: AppTypography.bodySmall.copyWith(
                          color: project['color'] as Color,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Müşteri bilgisi - Mobile'da küçük
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (project['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: (project['color'] as Color).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.business,
                        color: project['color'] as Color,
                        size: 12,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Müşteri: ${project['category']} Holding',
                        style: AppTypography.bodySmall.copyWith(
                          color: project['color'] as Color,
                          fontWeight: FontWeight.w600,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Proje açıklaması - Mobile'da kısa
                Text(
                  project['description'] as String,
                  style: AppTypography.bodyMedium.copyWith(
                    color: const Color(0xFF6B6B6B),
                    height: 1.4,
                    fontSize: 10,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 12),

                // Alt bilgi - Mobile'da kompakt
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            (project['color'] as Color).withValues(alpha: 0.2),
                            (project['color'] as Color).withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: (project['color'] as Color).withValues(
                            alpha: 0.4,
                          ),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            project['icon'] as IconData,
                            color: project['color'] as Color,
                            size: 12,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            project['category'] as String,
                            style: AppTypography.bodySmall.copyWith(
                              color: project['color'] as Color,
                              fontWeight: FontWeight.w600,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (project['color'] as Color).withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: (project['color'] as Color).withValues(
                            alpha: 0.3,
                          ),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Detayları Gör',
                            style: AppTypography.bodyMedium.copyWith(
                              color: project['color'] as Color,
                              fontWeight: FontWeight.w600,
                              fontSize: 9,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward,
                            color: project['color'] as Color,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletProjectCard(
    BuildContext context,
    Map<String, dynamic> project,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            (project['color'] as Color).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (project['color'] as Color).withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (project['color'] as Color).withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (project['id'] == 'sifa') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SifaIpekDetailPage(),
                ),
              );
            } else if (project['id'] == 'vefa') {
              NavigationService.goToVefa();
            } else if (project['id'] == 'sefa') {
              NavigationService.goToSefa();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Proje ikonu ve başlık - 3 sütun için kompakt
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            (project['color'] as Color).withValues(alpha: 0.3),
                            (project['color'] as Color).withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        project['icon'] as IconData,
                        color: project['color'] as Color,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        project['title'] as String,
                        style: AppTypography.h5.copyWith(
                          color: const Color(0xFF2C2C2C),
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: (project['color'] as Color).withValues(
                          alpha: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '2023',
                        style: AppTypography.bodySmall.copyWith(
                          color: project['color'] as Color,
                          fontWeight: FontWeight.w600,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Müşteri bilgisi - 3 sütun için kompakt
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (project['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: (project['color'] as Color).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.business,
                        color: project['color'] as Color,
                        size: 12,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Müşteri: ${project['category']} Holding',
                        style: AppTypography.bodySmall.copyWith(
                          color: project['color'] as Color,
                          fontWeight: FontWeight.w600,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Proje açıklaması - 3 sütun için kompakt, genişleyebilir
                Expanded(
                  child: Text(
                    project['description'] as String,
                    style: AppTypography.bodyMedium.copyWith(
                      color: const Color(0xFF6B6B6B),
                      height: 1.3,
                      fontSize: 9,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 12),

                // Alt bilgi - 3 sütun için kompakt, yan yana, kartın en altında
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Kategori butonu - solda, orta boyut
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              (project['color'] as Color).withValues(
                                alpha: 0.2,
                              ),
                              (project['color'] as Color).withValues(
                                alpha: 0.1,
                              ),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: (project['color'] as Color).withValues(
                              alpha: 0.4,
                            ),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              project['icon'] as IconData,
                              color: project['color'] as Color,
                              size: 12,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              project['category'] as String,
                              style: AppTypography.bodySmall.copyWith(
                                color: project['color'] as Color,
                                fontWeight: FontWeight.w600,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Detayları Gör butonu - sağda, orta boyut
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: (project['color'] as Color).withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: (project['color'] as Color).withValues(
                              alpha: 0.3,
                            ),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Detayları Gör',
                              style: AppTypography.bodyMedium.copyWith(
                                color: project['color'] as Color,
                                fontWeight: FontWeight.w600,
                                fontSize: 8,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              color: project['color'] as Color,
                              size: 12,
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
      ),
    );
  }

  Widget _buildDesktopProjectCard(
    BuildContext context,
    Map<String, dynamic> project,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            (project['color'] as Color).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (project['color'] as Color).withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: (project['color'] as Color).withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (project['id'] == 'sifa') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SifaIpekDetailPage(),
                ),
              );
            } else if (project['id'] == 'vefa') {
              NavigationService.goToVefa();
            } else if (project['id'] == 'sefa') {
              NavigationService.goToSefa();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Proje ikonu ve başlık - Desktop için optimize
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            (project['color'] as Color).withValues(alpha: 0.3),
                            (project['color'] as Color).withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        project['icon'] as IconData,
                        color: project['color'] as Color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        project['title'] as String,
                        style: AppTypography.h5.copyWith(
                          color: const Color(0xFF2C2C2C),
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: (project['color'] as Color).withValues(
                          alpha: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '2023',
                        style: AppTypography.bodySmall.copyWith(
                          color: project['color'] as Color,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Müşteri bilgisi - Desktop için optimize
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: (project['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (project['color'] as Color).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.business,
                        color: project['color'] as Color,
                        size: 14,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Müşteri: ${project['category']} Holding',
                        style: AppTypography.bodySmall.copyWith(
                          color: project['color'] as Color,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Proje açıklaması - Desktop için optimize
                Expanded(
                  child: Text(
                    project['description'] as String,
                    style: AppTypography.bodyMedium.copyWith(
                      color: const Color(0xFF6B6B6B),
                      height: 1.4,
                      fontSize: 12,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 16),

                // Alt bilgi - Desktop için optimize
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Kategori butonu - solda
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              (project['color'] as Color).withValues(
                                alpha: 0.2,
                              ),
                              (project['color'] as Color).withValues(
                                alpha: 0.1,
                              ),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: (project['color'] as Color).withValues(
                              alpha: 0.4,
                            ),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              project['icon'] as IconData,
                              color: project['color'] as Color,
                              size: 14,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              project['category'] as String,
                              style: AppTypography.bodySmall.copyWith(
                                color: project['color'] as Color,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Detayları Gör butonu - sağda
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: (project['color'] as Color).withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: (project['color'] as Color).withValues(
                              alpha: 0.3,
                            ),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Detayları Gör',
                              style: AppTypography.bodyMedium.copyWith(
                                color: project['color'] as Color,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: project['color'] as Color,
                              size: 14,
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
      ),
    );
  }

  Widget _buildAgencyAboutSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        Responsive.responsiveValue(
          context,
          mobile: Branding.spacingL,
          tablet: Branding.spacingXL,
          desktop: Branding.spacingXXL,
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF), // Beyaz
            const Color(0xFFF8F9FA), // Çok açık gri
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileAboutSection(context),
        tablet: _buildTabletAboutSection(context),
        desktop: _buildDesktopAboutSection(context),
      ),
    );
  }

  Widget _buildMobileAboutSection(BuildContext context) {
    return Column(
      children: [
        _buildAboutContent(context),
        const SizedBox(height: Branding.spacingXL),
        _buildAboutStats(context),
      ],
    );
  }

  Widget _buildTabletAboutSection(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 2, child: _buildAboutContent(context)),
        const SizedBox(width: Branding.spacingXL),
        Expanded(flex: 1, child: _buildAboutStats(context)),
      ],
    );
  }

  Widget _buildDesktopAboutSection(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildAboutContent(context)),
        const SizedBox(width: Branding.spacingXXL),
        Expanded(flex: 2, child: _buildAboutStats(context)),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Şebnem Yüceer Profil Bölümü
        _buildFounderProfile(context),

        SizedBox(
          height: Responsive.responsiveValue(
            context,
            mobile: Branding.spacingXL,
            tablet: Branding.spacingXXL,
            desktop: Branding.spacingXXL + 16,
          ),
        ),

        // Ajans Hikayesi
        _buildAgencyStory(context),
      ],
    );
  }

  Widget _buildFounderProfile(BuildContext context) {
    return Container(
      padding: Responsive.responsivePadding(
        context,
        mobile: const EdgeInsets.all(16.0),
        tablet: const EdgeInsets.all(20.0),
        desktop: const EdgeInsets.all(20.0),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF), // Beyaz
            const Color(0xFFF8F9FA), // Çok açık gri
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileProfileLayout(context),
        tablet: _buildTabletProfileLayout(context),
        desktop: _buildDesktopProfileLayout(context),
      ),
    );
  }

  Widget _buildMobileProfileLayout(BuildContext context) {
    return Column(
      children: [
        // Profil Fotoğrafı - Mobile'da ortalanmış
        Center(
          child: GestureDetector(
            onTap: () => _showImageDialog(context),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6B6B6B).withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/images/sebnemyuceer.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  cacheWidth: 160,
                  cacheHeight: 160,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFE5E7EB),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Color(0xFF9CA3AF),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Profil Bilgileri - Mobile'da ortalanmış
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Şebnem Yüceer',
              textAlign: TextAlign.center,
              style: AppTypography.h3.copyWith(
                color: const Color(0xFF2C2C2C),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Lüks Marka Lideri & Ajans Kurucusu',
              textAlign: TextAlign.center,
              style: AppTypography.h5.copyWith(
                color: const Color(0xFF6B6B6B),
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Louis Vuitton, Gucci ve Bulgari gibi dünya devi lüks markaların Türkiye Genel Müdürlüğü yapmış, Harvard Business School mezunu deneyimli bir lider.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyLarge.copyWith(
                color: const Color(0xFF4A4A4A),
                fontSize: 11,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 20),

            // LinkedIn Link - Mobile'da tam genişlik
            _buildLinkedInButton(context, isMobile: true),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletProfileLayout(BuildContext context) {
    return Row(
      children: [
        // Profil Fotoğrafı
        GestureDetector(
          onTap: () => _showImageDialog(context),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6B6B6B).withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/sebnemyuceer.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
                cacheWidth: 200,
                cacheHeight: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE5E7EB),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xFF9CA3AF),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        const SizedBox(width: 20),

        // Profil Bilgileri
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Şebnem Yüceer',
                style: AppTypography.h3.copyWith(
                  color: const Color(0xFF2C2C2C),
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Lüks Marka Lideri & Ajans Kurucusu',
                style: AppTypography.h5.copyWith(
                  color: const Color(0xFF6B6B6B),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Louis Vuitton, Gucci ve Bulgari gibi dünya devi lüks markaların Türkiye Genel Müdürlüğü yapmış, Harvard Business School mezunu deneyimli bir lider.',
                style: AppTypography.bodyLarge.copyWith(
                  color: const Color(0xFF4A4A4A),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),

              _buildLinkedInButton(context, isMobile: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopProfileLayout(BuildContext context) {
    return Row(
      children: [
        // Profil Fotoğrafı
        GestureDetector(
          onTap: () => _showImageDialog(context),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6B6B6B).withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/sebnemyuceer.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
                cacheWidth: 200,
                cacheHeight: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE5E7EB),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xFF9CA3AF),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        const SizedBox(width: 20),

        // Profil Bilgileri
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Şebnem Yüceer',
                style: AppTypography.h3.copyWith(
                  color: const Color(0xFF2C2C2C),
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Lüks Marka Lideri & Ajans Kurucusu',
                style: AppTypography.h5.copyWith(
                  color: const Color(0xFF6B6B6B),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Louis Vuitton, Gucci ve Bulgari gibi dünya devi lüks markaların Türkiye Genel Müdürlüğü yapmış, Harvard Business School mezunu deneyimli bir lider.',
                style: AppTypography.bodyLarge.copyWith(
                  color: const Color(0xFF4A4A4A),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),

              _buildLinkedInButton(context, isMobile: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLinkedInButton(BuildContext context, {required bool isMobile}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isLinkedInHovered = true),
      onExit: (_) => setState(() => _isLinkedInHovered = false),
      child: GestureDetector(
        onTap: () => _launchLinkedIn(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isMobile ? double.infinity : null,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16.0 : 12.0,
            vertical: isMobile ? 12.0 : 8.0,
          ),
          decoration: BoxDecoration(
            color: _isLinkedInHovered
                ? const Color(0xFF005885)
                : const Color(0xFF0077B5),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(
                  0xFF0077B5,
                ).withValues(alpha: _isLinkedInHovered ? 0.3 : 0.15),
                blurRadius: _isLinkedInHovered ? 10 : 6,
                offset: Offset(0, _isLinkedInHovered ? 4 : 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: isMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Icon(
                Icons.business,
                color: Colors.white,
                size: isMobile ? 14 : 14,
              ),
              SizedBox(width: isMobile ? 8 : 6),
              Flexible(
                child: Text(
                  'LinkedIn Profili',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: isMobile ? 12 : 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgencyStory(BuildContext context) {
    return Container(
      padding: Responsive.responsivePadding(
        context,
        mobile: const EdgeInsets.all(16.0),
        tablet: const EdgeInsets.all(20.0),
        desktop: const EdgeInsets.all(20.0),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF), // Beyaz
            const Color(0xFFF8F9FA), // Çok açık gri
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileAgencyStory(context),
        tablet: _buildTabletAgencyStory(context),
        desktop: _buildDesktopAgencyStory(context),
      ),
    );
  }

  Widget _buildMobileAgencyStory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Başlık - Mobile'da ortalanmış
        Center(
          child: Text(
            'Şebo Ajans Hikayesi',
            textAlign: TextAlign.center,
            style: AppTypography.h3.copyWith(
              color: const Color(0xFF2C2C2C),
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Alt başlık - Mobile'da ortalanmış
        Center(
          child: Text(
            'Kimim, Ne Yapıyoruz, Neden Çalışıyoruz',
            textAlign: TextAlign.center,
            style: AppTypography.h5.copyWith(
              color: const Color(0xFF6B6B6B),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Ana metin - Mobile'da daha küçük font
        Text(
          '20+ yıllık lüks perakende deneyimi ile Louis Vuitton, Gucci ve Bulgari gibi dünya devi markaların Türkiye pazarında büyümesine liderlik ettim. Harvard Business School eğitimi ve küresel marka yönetimi deneyimimle, Şebo Ajans\'ı kurarak bu bilgi birikimini dijital dünyaya taşıyorum.',
          textAlign: TextAlign.justify,
          style: AppTypography.bodyLarge.copyWith(
            color: const Color(0xFF4A4A4A),
            height: 1.5,
            fontSize: 11,
          ),
        ),

        const SizedBox(height: 16),

        // İkinci metin - Mobile'da daha küçük font
        Text(
          'Türkiye Tanıtım Grubu İcra Kurulu Başkanlığı ve Comité Colbert Türkiye Yılı Başkanlığı deneyimlerimle, markaların küresel pazarlarda güçlü konumlanması için stratejik yaklaşımlar geliştiriyoruz. Her proje, bir markanın hikayesini en etkili şekilde anlatma fırsatıdır.',
          textAlign: TextAlign.justify,
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFF6B6B6B),
            height: 1.5,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildTabletAgencyStory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Şebo Ajans Hikayesi',
          style: AppTypography.h3.copyWith(
            color: const Color(0xFF2C2C2C),
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Kimim, Ne Yapıyoruz, Neden Çalışıyoruz',
          style: AppTypography.h5.copyWith(
            color: const Color(0xFF6B6B6B),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          '20+ yıllık lüks perakende deneyimi ile Louis Vuitton, Gucci ve Bulgari gibi dünya devi markaların Türkiye pazarında büyümesine liderlik ettim. Harvard Business School eğitimi ve küresel marka yönetimi deneyimimle, Şebo Ajans\'ı kurarak bu bilgi birikimini dijital dünyaya taşıyorum.',
          style: AppTypography.bodyLarge.copyWith(
            color: const Color(0xFF4A4A4A),
            height: 1.6,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Türkiye Tanıtım Grubu İcra Kurulu Başkanlığı ve Comité Colbert Türkiye Yılı Başkanlığı deneyimlerimle, markaların küresel pazarlarda güçlü konumlanması için stratejik yaklaşımlar geliştiriyoruz. Her proje, bir markanın hikayesini en etkili şekilde anlatma fırsatıdır.',
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFF6B6B6B),
            height: 1.6,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopAgencyStory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Şebo Ajans Hikayesi',
          style: AppTypography.h3.copyWith(
            color: const Color(0xFF2C2C2C),
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Kimim, Ne Yapıyoruz, Neden Çalışıyoruz',
          style: AppTypography.h5.copyWith(
            color: const Color(0xFF6B6B6B),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          '20+ yıllık lüks perakende deneyimi ile Louis Vuitton, Gucci ve Bulgari gibi dünya devi markaların Türkiye pazarında büyümesine liderlik ettim. Harvard Business School eğitimi ve küresel marka yönetimi deneyimimle, Şebo Ajans\'ı kurarak bu bilgi birikimini dijital dünyaya taşıyorum.',
          style: AppTypography.bodyLarge.copyWith(
            color: const Color(0xFF4A4A4A),
            height: 1.5,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Türkiye Tanıtım Grubu İcra Kurulu Başkanlığı ve Comité Colbert Türkiye Yılı Başkanlığı deneyimlerimle, markaların küresel pazarlarda güçlü konumlanması için stratejik yaklaşımlar geliştiriyoruz. Her proje, bir markanın hikayesini en etkili şekilde anlatma fırsatıdır.',
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFF6B6B6B),
            height: 1.5,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutStats(BuildContext context) {
    return Container(
      padding: Responsive.responsivePadding(
        context,
        mobile: const EdgeInsets.all(16.0),
        tablet: const EdgeInsets.all(20.0),
        desktop: const EdgeInsets.all(20.0),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileAboutStats(context),
        tablet: _buildTabletAboutStats(context),
        desktop: _buildDesktopAboutStats(context),
      ),
    );
  }

  Widget _buildMobileAboutStats(BuildContext context) {
    return Column(
      children: [
        // Başlık - Mobile'da ortalanmış ve küçük
        Text(
          'Neden Bizi Seçmelisiniz?',
          style: AppTypography.h3.copyWith(
            color: const Color(0xFF2C2C2C),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 20),

        // Özellikler listesi - Mobile'da kompakt
        _buildMobileFeaturesList(context),
      ],
    );
  }

  Widget _buildTabletAboutStats(BuildContext context) {
    return Column(
      children: [
        Text(
          'Neden Bizi Seçmelisiniz?',
          style: AppTypography.h3.copyWith(
            color: const Color(0xFF2C2C2C),
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        _buildTabletFeaturesList(context),
      ],
    );
  }

  Widget _buildDesktopAboutStats(BuildContext context) {
    return Column(
      children: [
        Text(
          'Neden Bizi Seçmelisiniz?',
          style: AppTypography.h3.copyWith(
            color: const Color(0xFF2C2C2C),
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        _buildDesktopFeaturesList(context),
      ],
    );
  }

  Widget _buildMobileFeaturesList(BuildContext context) {
    final features = [
      '🏆 20+ yıl lüks perakende deneyimi',
      '🎓 Harvard Business School eğitimi',
      '🌍 Küresel marka yönetimi uzmanlığı',
      '🤝 Louis Vuitton, Gucci, Bulgari deneyimi',
      '📈 Türkiye Tanıtım Grubu liderliği',
      '🎨 Comité Colbert Türkiye Yılı başkanlığı',
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  feature,
                  style: AppTypography.bodyLarge.copyWith(
                    color: const Color(0xFF2C2C2C),
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTabletFeaturesList(BuildContext context) {
    final features = [
      '🏆 20+ yıl lüks perakende deneyimi',
      '🎓 Harvard Business School eğitimi',
      '🌍 Küresel marka yönetimi uzmanlığı',
      '🤝 Louis Vuitton, Gucci, Bulgari deneyimi',
      '📈 Türkiye Tanıtım Grubu liderliği',
      '🎨 Comité Colbert Türkiye Yılı başkanlığı',
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  feature,
                  style: AppTypography.bodyLarge.copyWith(
                    color: const Color(0xFF2C2C2C),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopFeaturesList(BuildContext context) {
    final features = [
      '🏆 20+ yıl lüks perakende deneyimi',
      '🎓 Harvard Business School eğitimi',
      '🌍 Küresel marka yönetimi uzmanlığı',
      '🤝 Louis Vuitton, Gucci, Bulgari deneyimi',
      '📈 Türkiye Tanıtım Grubu liderliği',
      '🎨 Comité Colbert Türkiye Yılı başkanlığı',
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  feature,
                  style: AppTypography.bodyLarge.copyWith(
                    color: const Color(0xFF2C2C2C),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConferencesSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.responsivePadding(
        context,
        mobile: const EdgeInsets.all(16.0),
        tablet: const EdgeInsets.all(20.0),
        desktop: const EdgeInsets.all(24.0),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF), // Beyaz
            const Color(0xFFF8F9FA), // Çok açık gri
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileConferencesSection(context),
        tablet: _buildTabletConferencesSection(context),
        desktop: _buildDesktopConferencesSection(context),
      ),
    );
  }

  Widget _buildMobileConferencesSection(BuildContext context) {
    return Column(
      children: [
        // Başlık - Mobile'da ortalanmış ve küçük
        Text(
          'Yurt Dışı Konferanslar & Etkinlikler',
          style: AppTypography.h2.copyWith(
            color: const Color(0xFF2C2C2C),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 8),

        Text(
          'Uluslararası platformlarda yer aldığımız etkinlikler',
          style: AppTypography.bodyLarge.copyWith(
            color: const Color(0xFF6B6B6B),
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 20),

        // Conferences Grid - Mobile'da tek sütun
        _buildMobileConferencesGrid(context),

        const SizedBox(height: 20),

        // Daha Fazla Butonu - Mobile'da küçük
        _buildMobileMoreConferencesButton(context),
      ],
    );
  }

  Widget _buildTabletConferencesSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Yurt Dışı Konferanslar & Etkinlikler',
          style: AppTypography.h2.copyWith(
            color: const Color(0xFF2C2C2C),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 12),

        Text(
          'Uluslararası platformlarda yer aldığımız etkinlikler',
          style: AppTypography.bodyLarge.copyWith(
            color: const Color(0xFF6B6B6B),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        _buildTabletConferencesGrid(context),

        const SizedBox(height: 24),

        _buildTabletMoreConferencesButton(context),
      ],
    );
  }

  Widget _buildDesktopConferencesSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'Yurt Dışı Konferanslar & Etkinlikler',
          style: AppTypography.h2.copyWith(
            color: const Color(0xFF2C2C2C),
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 12),

        Text(
          'Uluslararası platformlarda yer aldığımız etkinlikler',
          style: AppTypography.bodyLarge.copyWith(
            color: const Color(0xFF6B6B6B),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 24),

        _buildDesktopConferencesGrid(context),

        const SizedBox(height: 24),

        _buildDesktopMoreConferencesButton(context),
      ],
    );
  }

  Widget _buildMobileConferencesGrid(BuildContext context) {
    final conferences = _getConferencesData();

    return Column(
      children: conferences.map((conference) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: _buildMobileConferenceCard(context, conference),
        );
      }).toList(),
    );
  }

  Widget _buildTabletConferencesGrid(BuildContext context) {
    final conferences = _getConferencesData();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: conferences.map((conference) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _buildTabletConferenceCard(context, conference),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDesktopConferencesGrid(BuildContext context) {
    final conferences = _getConferencesData();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: conferences.map((conference) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _buildDesktopConferenceCard(context, conference),
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Map<String, dynamic>> _getConferencesData() {
    return [
      {
        'id': 'empowerment_voice_seminar',
        'title': 'Empowerment Through Voice Seminar',
        'description':
            'CCI France-Turquie, Dutch Business Association Turkey, CorporateConnections® ve Yapı Kredi Bankası işbirliğiyle düzenlenen "Empowerment Through Voice Seminar". Ünlü İletişim Stratejisti ve ses mentoru Arthur Samuel Joseph\'in konuşmacı olarak katıldığı bu özel etkinlikte, katılımcılar ses ve iletişim becerilerini geliştirme fırsatı buldular.',
        'location': 'İstanbul, Türkiye',
        'date': 'Ekim 2025',
        'type': 'Seminer',
        'icon': Icons.record_voice_over,
        'color': const Color(0xFF6B6B6B),
      },
      {
        'id': 'cci_france_turquie_event',
        'title': 'CCI France-Turquie Etkinlik Serisi',
        'description':
            'Fransız Ticaret Odası CCI France-Turquie tarafından düzenlenen özel etkinlik serisi. Sebnem Berkol Yuceer\'in değerli desteğiyle organize edilen bu etkinlikte, iş dünyasından önemli isimler bir araya gelerek networking ve bilgi paylaşımı gerçekleştirdi. Tüm ortaklarımıza ve katılımcılarımıza teşekkürler.',
        'location': 'İstanbul, Türkiye',
        'date': 'Ekim 2025',
        'type': 'Etkinlik',
        'icon': Icons.business,
        'color': const Color(0xFF6B6B6B),
      },
    ];
  }

  Widget _buildMobileConferenceCard(
    BuildContext context,
    Map<String, dynamic> conference,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık ve tip - Mobile'da kompakt
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    conference['title'] as String,
                    style: AppTypography.h6.copyWith(
                      color: const Color(0xFF2C2C2C),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    conference['type'] as String,
                    style: AppTypography.bodySmall.copyWith(
                      color: const Color(0xFF6B6B6B),
                      fontWeight: FontWeight.w500,
                      fontSize: 9,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Tarih ve lokasyon - Mobile'da küçük
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color(0xFF6B6B6B),
                  size: 12,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    conference['location'] as String,
                    style: AppTypography.bodySmall.copyWith(
                      color: const Color(0xFF6B6B6B),
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: const Color(0xFF6B6B6B),
                  size: 12,
                ),
                const SizedBox(width: 6),
                Text(
                  conference['date'] as String,
                  style: AppTypography.bodySmall.copyWith(
                    color: const Color(0xFF6B6B6B),
                    fontSize: 10,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Açıklama - Mobile'da kısa
            Text(
              conference['description'] as String,
              style: AppTypography.bodyMedium.copyWith(
                color: const Color(0xFF6B6B6B),
                height: 1.4,
                fontSize: 10,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Detayları Gör butonu - Mobile'da küçük
            GestureDetector(
              onTap: () {
                _navigateToConferenceDetail(
                  context,
                  conference['id'] as String,
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF6B6B6B), const Color(0xFF4A4A4A)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Detayları Gör',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletConferenceCard(
    BuildContext context,
    Map<String, dynamic> conference,
  ) {
    return Container(
      constraints: const BoxConstraints(minHeight: 240),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık ve tip
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    conference['title'] as String,
                    style: AppTypography.h6.copyWith(
                      color: const Color(0xFF2C2C2C),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    conference['type'] as String,
                    style: AppTypography.bodySmall.copyWith(
                      color: const Color(0xFF6B6B6B),
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Tarih ve lokasyon
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color(0xFF6B6B6B),
                  size: 14,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    conference['location'] as String,
                    style: AppTypography.bodySmall.copyWith(
                      color: const Color(0xFF6B6B6B),
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: const Color(0xFF6B6B6B),
                  size: 14,
                ),
                const SizedBox(width: 8),
                Text(
                  conference['date'] as String,
                  style: AppTypography.bodySmall.copyWith(
                    color: const Color(0xFF6B6B6B),
                    fontSize: 11,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Açıklama
            Text(
              conference['description'] as String,
              style: AppTypography.bodyMedium.copyWith(
                color: const Color(0xFF6B6B6B),
                height: 1.5,
                fontSize: 11,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 16),

            // Detayları Gör butonu - Tablet'te orta boyut
            GestureDetector(
              onTap: () {
                _navigateToConferenceDetail(
                  context,
                  conference['id'] as String,
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF6B6B6B), const Color(0xFF4A4A4A)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Detayları Gör',
                      style: AppTypography.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopConferenceCard(
    BuildContext context,
    Map<String, dynamic> conference,
  ) {
    return Container(
      constraints: const BoxConstraints(minHeight: 240),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Başlık ve tip
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    conference['title'] as String,
                    style: AppTypography.h6.copyWith(
                      color: const Color(0xFF2C2C2C),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    conference['type'] as String,
                    style: AppTypography.bodySmall.copyWith(
                      color: const Color(0xFF6B6B6B),
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Tarih ve lokasyon
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color(0xFF6B6B6B),
                  size: 14,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    conference['location'] as String,
                    style: AppTypography.bodySmall.copyWith(
                      color: const Color(0xFF6B6B6B),
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: const Color(0xFF6B6B6B),
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  conference['date'] as String,
                  style: AppTypography.bodySmall.copyWith(
                    color: const Color(0xFF6B6B6B),
                    fontSize: 11,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Açıklama
            Text(
              conference['description'] as String,
              style: AppTypography.bodyMedium.copyWith(
                color: const Color(0xFF6B6B6B),
                height: 1.4,
                fontSize: 12,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 16),

            // Detayları Gör butonu - Desktop'ta büyük
            GestureDetector(
              onTap: () {
                _navigateToConferenceDetail(
                  context,
                  conference['id'] as String,
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF6B6B6B), const Color(0xFF4A4A4A)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Detayları Gör',
                      style: AppTypography.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMoreConferencesButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF6B6B6B), const Color(0xFF4A4A4A)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          NavigationService.goToConferences();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tüm Etkinlikleri Gör',
              style: AppTypography.button.copyWith(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.arrow_forward, color: Colors.white, size: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletMoreConferencesButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF6B6B6B), const Color(0xFF4A4A4A)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          NavigationService.goToConferences();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tüm Etkinlikleri Gör',
              style: AppTypography.button.copyWith(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: Colors.white, size: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopMoreConferencesButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF6B6B6B), const Color(0xFF4A4A4A)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          NavigationService.goToConferences();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tüm Etkinlikleri Gör',
              style: AppTypography.button.copyWith(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.arrow_forward, color: Colors.white, size: 14),
          ],
        ),
      ),
    );
  }

  Future<void> _launchLinkedIn() async {
    try {
      final Uri url = Uri.parse(
        'https://www.linkedin.com/in/sebnem-berkol-yuceer-1255947/',
      );

      // Direkt launchUrl kullan - en basit yaklaşım
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'LinkedIn profili açılamadı. Manuel olarak açın: https://www.linkedin.com/in/sebnem-berkol-yuceer-1255947/',
            ),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  void _showImageDialog(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {
                Navigator.of(context).pop();
              }
            },
            child: Scaffold(
              backgroundColor: Colors.black.withValues(alpha: 0.7),
              body: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                  child: Center(
                    child: AbsorbPointer(
                      absorbing: false,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                          maxHeight: MediaQuery.of(context).size.height * 0.8,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/sebnemyuceer.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void _navigateToConferenceDetail(BuildContext context, String conferenceId) {
    print('Navigating to conference detail: $conferenceId'); // Debug print
    switch (conferenceId) {
      case 'empowerment_voice_seminar':
        print('Opening Empowerment Voice Seminar page'); // Debug print
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EmpowermentVoiceSeminarDetailPage(),
          ),
        );
        break;
      case 'cci_france_turquie_event':
        print('Opening CCI France-Turquie Event page'); // Debug print
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CciFranceTurquieEventDetailPage(),
          ),
        );
        break;
      default:
        print('Unknown conference ID: $conferenceId'); // Debug print
        // Varsayılan sayfa veya hata mesajı
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Etkinlik detayı bulunamadı.'),
            backgroundColor: Color(0xFF6B6B6B),
          ),
        );
    }
  }
}

// Background Pattern Painter
class _BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create very subtle platin grey circles with soft shimmer effect
    final paint1 = Paint()
      ..color = const Color(0xFFE8E8E8)
          .withValues(alpha: 0.06) // Çok daha süzgün platin gri
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);

    final paint2 = Paint()
      ..color = const Color(0xFFF2F2F2)
          .withValues(alpha: 0.08) // Çok daha süzgün parlak platin gri
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 65);

    // Sol üst köşe - çok süzgün yuvarlak
    canvas.drawCircle(
      Offset(size.width * 0.12, size.height * 0.18),
      size.width * 0.32,
      paint1,
    );

    // Sağ alt köşe - çok süzgün yuvarlak
    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.82),
      size.width * 0.28,
      paint2,
    );

    // Çok süzgün parıltı efekti
    final shimmerPaint = Paint()
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.03)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 45);

    // Sol üst çok süzgün parıltı
    canvas.drawCircle(
      Offset(size.width * 0.08, size.height * 0.12),
      size.width * 0.15,
      shimmerPaint,
    );

    // Sağ alt çok süzgün parıltı
    canvas.drawCircle(
      Offset(size.width * 0.92, size.height * 0.88),
      size.width * 0.12,
      shimmerPaint,
    );

    // Ek süzgün katman
    final subtlePaint = Paint()
      ..color = const Color(0xFFF5F5F5).withValues(alpha: 0.02)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);

    // Merkez süzgün efekt
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.25,
      subtlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Hoverable Footer Link Widget
