/// 🏠 Home Page - Ana sayfa
///
/// Bu sayfa, uygulamanın ana sayfasıdır.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';

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
          // Navigation Bar
          _buildNavigationBar(context),

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
                  _FooterWidget(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFF131B2E), // rgba(19, 27, 46) - Dark blue-grey
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo Section - Exact match to reference
            Row(
              children: [
                // ŞEBO Logo Container
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28.0,
                    vertical: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0), // Light grey background
                    borderRadius: BorderRadius.circular(
                      25.0,
                    ), // Very rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE0E0E0).withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Text(
                    'ŞEBO',
                    style: TextStyle(
                      color: Color(0xFF4A4A4A), // Medium grey text
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                // Creative Agency Text
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: const Color(0xFFE0E0E0),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: const Text(
                    'creative agency',
                    style: TextStyle(
                      color: Color(0xFFE0E0E0), // Light grey text
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      letterSpacing: 1.2,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),

            // Navigation Menu
            Responsive.responsiveWidget(
              context,
              mobile: _buildMobileMenu(context),
              tablet: _buildDesktopMenu(context),
              desktop: _buildDesktopMenu(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Mobile menu
      },
      icon: const Icon(Icons.menu, color: Branding.white, size: 24),
    );
  }

  Widget _buildDesktopMenu(BuildContext context) {
    return Row(
      children: [
        _buildNavItem('Ana Sayfa', false),
        const SizedBox(width: Branding.spacingL),
        _buildNavItem('Hakkımızda', false),
        const SizedBox(width: Branding.spacingL),
        _buildDropdownMenu(context),
        const SizedBox(width: Branding.spacingL),
        _buildNavItem('İletişim', false),
      ],
    );
  }

  Widget _buildDropdownMenu(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: 0.05), // Dış kısım - az renk
              Colors.white.withValues(alpha: 0.15), // İç kısım - çok renk
            ],
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hoş İşler',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'vefa',
          child: const Text(
            'Vefa Projesi',
            style: TextStyle(
              color: Color(0xFF6B6B6B),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'sefa',
          child: const Text(
            'Sefa Projesi',
            style: TextStyle(
              color: Color(0xFF6B6B6B),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'sifa',
          child: const Text(
            'Şifa Projesi',
            style: TextStyle(
              color: Color(0xFF6B6B6B),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
      onSelected: (String value) {
        // Proje detayına git
        switch (value) {
          case 'vefa':
            // Vefa projesi detayı
            break;
          case 'sefa':
            // Sefa projesi detayı
            break;
          case 'sifa':
            // Şifa projesi detayı
            break;
        }
      },
    );
  }

  Widget _buildNavItem(String text, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navigation
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.05), // Dış kısım - az renk
                  Colors.white.withValues(alpha: 0.15), // İç kısım - çok renk
                ],
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgencyHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Responsive.screenHeight(context) * 0.85,
        maxHeight: Responsive.screenHeight(context) * 0.9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF131B2E), // rgba(19, 27, 46) - Dark blue-grey
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B2E).withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
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
              padding: const EdgeInsets.all(Branding.spacingL),
              child: AnimatedBuilder(
                animation: _heroAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 0.8 + (0.2 * _heroAnimation.value),
                    child: Opacity(
                      opacity: _heroAnimation.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Main Title
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Text(
                                'ŞEBO AJANS',
                                style: AppTypography.h1.copyWith(
                                  color: Branding.white,
                                  fontSize: Responsive.responsiveFontSize(
                                    context,
                                    desktop: 72,
                                    tablet: 56,
                                    mobile: 42,
                                  ),
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 3.0,
                                  shadows: [
                                    Shadow(
                                      color: Branding.black.withValues(
                                        alpha: 0.3,
                                      ),
                                      offset: const Offset(0, 4),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          const SizedBox(height: Branding.spacingL),

                          // Agency Tagline
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Branding.spacingXL,
                                  vertical: Branding.spacingM,
                                ),
                                decoration: BoxDecoration(
                                  color: Branding.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(
                                    Branding.radiusL,
                                  ),
                                  border: Border.all(
                                    color: Branding.white.withValues(
                                      alpha: 0.3,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'Yaratıcı Dijital Çözümler',
                                  style: AppTypography.h5.copyWith(
                                    color: Branding.white,
                                    fontSize: Responsive.responsiveFontSize(
                                      context,
                                      desktop: 20,
                                      tablet: 18,
                                      mobile: 16,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: Branding.spacingXL),

                          // Subtitle
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Text(
                                'Dijital dünyada markanızı öne çıkaran\nstratejik ve yaratıcı çözümler',
                                style: AppTypography.h4.copyWith(
                                  color: Branding.white.withValues(alpha: 0.9),
                                  fontSize: Responsive.responsiveFontSize(
                                    context,
                                    desktop: 28,
                                    tablet: 22,
                                    mobile: 18,
                                  ),
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          const SizedBox(height: Branding.spacingXL),

                          // CTA Buttons
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: _buildHeroButtons(context),
                            ),
                          ),
                        ],
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

  Widget _buildBackgroundPattern(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _BackgroundPatternPainter(),
    );
  }

  Widget _buildHeroButtons(BuildContext context) {
    return Responsive.responsiveWidget(
      context,
      mobile: Column(
        children: [
          _buildPrimaryButton(context),
          const SizedBox(height: Branding.spacingM),
          _buildSecondaryButton(context),
        ],
      ),
      tablet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPrimaryButton(context),
          const SizedBox(width: Branding.spacingM),
          _buildSecondaryButton(context),
        ],
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPrimaryButton(context),
          const SizedBox(width: Branding.spacingL),
          _buildSecondaryButton(context),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0), // Light grey
        borderRadius: BorderRadius.circular(Branding.radiusXL),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE0E0E0).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Projeler sayfasına git
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingXL,
              tablet: Branding.spacingXXL,
              desktop: Branding.spacingXXL + 8,
            ),
            vertical: Branding.spacingL,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Branding.radiusXL),
          ),
        ),
        child: Text(
          'Hemen İletişime Geç',
          style: AppTypography.button.copyWith(
            color: const Color(0xFF4A4A4A), // Medium grey
            fontSize: Responsive.responsiveFontSize(
              context,
              mobile: 14,
              tablet: 16,
              desktop: 18,
            ),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // Hakkımızda sayfasına git
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Color(0xFFE0E0E0), // Light grey border
          width: 2,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.responsiveValue(
            context,
            mobile: Branding.spacingXL,
            tablet: Branding.spacingXXL,
            desktop: Branding.spacingXXL + 8,
          ),
          vertical: Branding.spacingL,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Branding.radiusXL),
        ),
      ),
      child: Text(
        'Projelerimizi İncele',
        style: AppTypography.button.copyWith(
          color: const Color(0xFFE0E0E0), // Light grey
          fontSize: Responsive.responsiveFontSize(
            context,
            mobile: 14,
            tablet: 16,
            desktop: 18,
          ),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAgencyProjectsSection(BuildContext context) {
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
      child: Column(
        children: [
          // Section Header
          Text(
            'Hoş İşler',
            style: AppTypography.h2.copyWith(
              color: const Color(0xFF2C2C2C),
              fontSize: Responsive.responsiveFontSize(
                context,
                desktop: 42,
                tablet: 32,
                mobile: 28,
              ),
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: Branding.spacingM),

          Text(
            'Sosyal Sorumluluk ve El Sanatları Platformu',
            style: AppTypography.h4.copyWith(
              color: const Color(0xFF6B6B6B),
              fontSize: Responsive.responsiveFontSize(
                context,
                desktop: 18,
                tablet: 16,
                mobile: 14,
              ),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingXL,
              tablet: Branding.spacingXXL,
              desktop: Branding.spacingXXL + 16,
            ),
          ),

          // Projects Grid
          _buildAgencyProjectsGrid(context),
        ],
      ),
    );
  }

  Widget _buildAgencyProjectsGrid(BuildContext context) {
    final projects = [
      {
        'id': 'sifa',
        'title': 'Şifa İpek',
        'description':
            'Hatay\'da yetişen Barış ipeği ve Hatay depreminden sonra köylerde yaşayan kadın çiftçilerin tezgahlarında dokudukları ürünlerin değere döndürülmesine yardım eden sosyal sorumluluk projesi.',
        'image': 'assets/images/projects/sifa_project.jpg',
        'category': 'Sosyal Sorumluluk',
        'icon': Icons.favorite,
        'color': const Color(0xFF6B7280), // Yumuşak gri
      },
      {
        'id': 'vefa',
        'title': 'Vefa',
        'description':
            'Alanya\'daki ailemden kalan kız meslek lisesi ve turizm otelcilik okulu öğrencilerine ve Alanya ile ilgili projeleri kapsayan eğitim ve gelişim platformu.',
        'image': 'assets/images/projects/vefa_project.jpg',
        'category': 'Eğitim',
        'icon': Icons.school,
        'color': const Color(0xFF6B7280), // Yumuşak gri
      },
      {
        'id': 'sefa',
        'title': 'Sefa',
        'description':
            'Şifa İpeği ile üretilen keyifli ürünlerden oluşan bir seri. Geleneksel el sanatlarının modern yaşamla buluştuğu özel koleksiyon.',
        'image': 'assets/images/projects/sefa_project.jpg',
        'category': 'El Sanatları',
        'icon': Icons.palette,
        'color': const Color(0xFF6B7280), // Yumuşak gri
      },
    ];

    return LayoutBuilder(
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
              mobile: 0.7,
              tablet: 0.8,
              desktop: 0.9,
            ),
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return _buildAgencyProjectCard(context, projects[index]);
          },
        );
      },
    );
  }

  Widget _buildAgencyProjectCard(
    BuildContext context,
    Map<String, dynamic> project,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, const Color(0xFFF8F9FA)],
        ),
        borderRadius: BorderRadius.circular(Branding.radiusXL),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Branding.radiusXL),
          onTap: () {
            // Proje detayına git
          },
          child: Padding(
            padding: const EdgeInsets.all(Branding.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Proje ikonu ve başlık
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Branding.spacingM),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            (project['color'] as Color).withValues(alpha: 0.3),
                            (project['color'] as Color).withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(Branding.radiusL),
                      ),
                      child: Icon(
                        project['icon'] as IconData,
                        color: project['color'] as Color,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: Branding.spacingL),
                    Expanded(
                      child: Text(
                        project['title'] as String,
                        style: AppTypography.h5.copyWith(
                          color: const Color(0xFF2C2C2C),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Branding.spacingM,
                        vertical: Branding.spacingS,
                      ),
                      decoration: BoxDecoration(
                        color: (project['color'] as Color).withValues(
                          alpha: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(Branding.radiusL),
                      ),
                      child: Text(
                        '2023',
                        style: AppTypography.bodySmall.copyWith(
                          color: project['color'] as Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: Branding.spacingM),

                // Müşteri bilgisi
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Branding.spacingM,
                    vertical: Branding.spacingS,
                  ),
                  decoration: BoxDecoration(
                    color: (project['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Branding.radiusL),
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
                        size: 16,
                      ),
                      const SizedBox(width: Branding.spacingS),
                      Text(
                        'Müşteri: ${project['category']} Holding',
                        style: AppTypography.bodySmall.copyWith(
                          color: project['color'] as Color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: Branding.spacingL),

                // Proje açıklaması
                Expanded(
                  child: Text(
                    project['description'] as String,
                    style: AppTypography.bodyMedium.copyWith(
                      color: const Color(0xFF6B6B6B),
                      height: 1.5,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: Branding.spacingL),

                // Alt bilgi
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Branding.spacingM,
                        vertical: Branding.spacingS,
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
                        borderRadius: BorderRadius.circular(Branding.radiusL),
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
                            size: 16,
                          ),
                          const SizedBox(width: Branding.spacingS),
                          Text(
                            project['category'] as String,
                            style: AppTypography.bodySmall.copyWith(
                              color: project['color'] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Branding.spacingM,
                        vertical: Branding.spacingS,
                      ),
                      decoration: BoxDecoration(
                        color: (project['color'] as Color).withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(Branding.radiusL),
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
                            ),
                          ),
                          const SizedBox(width: Branding.spacingS),
                          Icon(
                            Icons.arrow_forward,
                            color: project['color'] as Color,
                            size: 16,
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
      padding: const EdgeInsets.all(Branding.spacingXL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF), // Beyaz
            const Color(0xFFF8F9FA), // Çok açık gri
          ],
        ),
        borderRadius: BorderRadius.circular(Branding.radiusXL),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profil Fotoğrafı
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6B6B6B).withValues(alpha: 0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Container(
                color: const Color(0xFFE5E7EB),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),

          const SizedBox(width: Branding.spacingXL),

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
                  ),
                ),

                const SizedBox(height: Branding.spacingS),

                Text(
                  'Şebo Ajans Kurucusu',
                  style: AppTypography.h5.copyWith(
                    color: const Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: Branding.spacingL),

                Text(
                  'Dijital dünyada markaların güçlü bir şekilde var olmasını sağlayan yaratıcı ve stratejik düşünceyi birleştiren bir lider.',
                  style: AppTypography.bodyLarge.copyWith(
                    color: const Color(0xFF4A4A4A),
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: Branding.spacingL),

                // LinkedIn Link
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Branding.spacingM,
                    vertical: Branding.spacingS,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0077B5),
                    borderRadius: BorderRadius.circular(Branding.radiusL),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.business, color: Colors.white, size: 16),
                      const SizedBox(width: Branding.spacingS),
                      Text(
                        'LinkedIn Profili',
                        style: AppTypography.bodyMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgencyStory(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Branding.spacingXL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF), // Beyaz
            const Color(0xFFF8F9FA), // Çok açık gri
          ],
        ),
        borderRadius: BorderRadius.circular(Branding.radiusXL),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Şebo Ajans Hikayesi',
            style: AppTypography.h3.copyWith(
              color: const Color(0xFF2C2C2C),
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: Branding.spacingL),

          Text(
            'Kimim, Ne Yapıyoruz, Neden Çalışıyoruz',
            style: AppTypography.h5.copyWith(
              color: const Color(0xFF6B6B6B),
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: Branding.spacingL),

          Text(
            'Şebo Ajans olarak, dijital dünyada markaların güçlü bir şekilde var olmasını sağlıyoruz. Yaratıcılık ve stratejik düşünceyi birleştirerek, müşterilerimizin hedeflerine ulaşmalarına yardımcı oluyoruz.',
            style: AppTypography.bodyLarge.copyWith(
              color: const Color(0xFF4A4A4A),
              height: 1.6,
            ),
          ),

          const SizedBox(height: Branding.spacingL),

          Text(
            'Her proje, bir hikaye anlatır. Biz de bu hikayeleri en güzel şekilde dijital dünyada yaşatmak için çalışıyoruz. Müşterilerimizin başarısı, bizim başarımızdır.',
            style: AppTypography.bodyMedium.copyWith(
              color: const Color(0xFF6B6B6B),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutStats(BuildContext context) {
    final stats = [
      {'number': '150+', 'label': 'Tamamlanan Proje'},
      {'number': '50+', 'label': 'Mutlu Müşteri'},
      {'number': '8+', 'label': 'Yıllık Deneyim'},
      {'number': '24/7', 'label': 'Destek Hizmeti'},
    ];

    return Container(
      padding: const EdgeInsets.all(Branding.spacingXL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFFFFF), // Beyaz
            const Color(0xFFF8F9FA), // Çok açık gri
          ],
        ),
        borderRadius: BorderRadius.circular(Branding.radiusXL),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: stats
            .map(
              (stat) => Padding(
                padding: const EdgeInsets.only(bottom: Branding.spacingXL),
                child: _buildStatItem(context, stat),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, Map<String, String> stat) {
    return Column(
      children: [
        Text(
          stat['number']!,
          style: AppTypography.h2.copyWith(
            color: const Color(0xFF2C2C2C), // Koyu gri
            fontSize: Responsive.responsiveFontSize(
              context,
              mobile: 32,
              tablet: 40,
              desktop: 48,
            ),
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: Branding.spacingS),
        Text(
          stat['label']!,
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFF6B6B6B), // Orta gri
            fontSize: Responsive.responsiveFontSize(
              context,
              mobile: 14,
              tablet: 15,
              desktop: 16,
            ),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildConferencesSection(BuildContext context) {
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
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Yurt Dışı Konferanslar & Etkinlikler',
            style: AppTypography.h2.copyWith(
              color: const Color(0xFF2C2C2C),
              fontSize: Responsive.responsiveFontSize(
                context,
                desktop: 32,
                tablet: 28,
                mobile: 24,
              ),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: Branding.spacingM),

          Text(
            'Uluslararası platformlarda yer aldığımız etkinlikler',
            style: AppTypography.bodyLarge.copyWith(
              color: const Color(0xFF6B6B6B),
              fontSize: Responsive.responsiveFontSize(
                context,
                desktop: 16,
                tablet: 15,
                mobile: 14,
              ),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(
            height: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingXL,
              tablet: Branding.spacingXXL,
              desktop: Branding.spacingXXL + 16,
            ),
          ),

          // Conferences Grid (sadece 2 tane göster)
          _buildMinimalConferencesGrid(context),

          SizedBox(
            height: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingXL,
              tablet: Branding.spacingXXL,
              desktop: Branding.spacingXXL,
            ),
          ),

          // Daha Fazla Butonu
          _buildMoreConferencesButton(context),
        ],
      ),
    );
  }

  Widget _buildMinimalConferencesGrid(BuildContext context) {
    final conferences = [
      {
        'title': 'Vefa Buluşmaları 2025',
        'description':
            'Anadolu Eğitim ve Kültür Vakfı ile İstanbul Aydın Üniversitesi iş birliğiyle düzenlenen etkinlikte, Zeytinburnu Semiha Şakir Huzurevi sakinleriyle bir araya geldi. Fizyoterapi Bölümü akademisyenleri ve öğrencileriyle birlikte, yaşlı bireylerin fiziksel ve sosyal refahını desteklemek amacıyla çeşitli çalışmalar gerçekleştirdi.',
        'location': 'İstanbul, Türkiye',
        'date': 'Ocak 2025',
        'type': 'Etkinlik',
        'icon': Icons.favorite,
        'color': const Color(0xFF6B6B6B),
      },
      {
        'title': 'Avrupa İklim Değişikliği Uyum Konferansı',
        'description':
            'Rimini, İtalya\'da düzenlenen konferansta, uygulayıcılar, hükümetler, araştırmacılar ve paydaşlardan oluşan geniş bir ağın adaptasyon uzmanlığını bir araya getirdi. Pratik deneyimlerin paylaşılması ve Avrupa\'da daha akıllı, hızlı ve sistemik adaptasyona yönelik iş birliğinin teşvik edilmesi amacıyla dinamik bir platform olarak hizmet verdi.',
        'location': 'Rimini, İtalya',
        'date': 'Şubat 2025',
        'type': 'Konferans',
        'icon': Icons.eco,
        'color': const Color(0xFF6B6B6B),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Branding.spacingXXL),
      child: Row(
        children: conferences.map((conference) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Branding.spacingS,
              ),
              child: _buildMinimalConferenceCard(context, conference),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMinimalConferenceCard(
    BuildContext context,
    Map<String, dynamic> conference,
  ) {
    return Container(
      constraints: const BoxConstraints(minHeight: 280),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Branding.radiusL),
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
        padding: const EdgeInsets.all(Branding.spacingXL),
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
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Branding.spacingS,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(Branding.radiusM),
                  ),
                  child: Text(
                    conference['type'] as String,
                    style: AppTypography.bodySmall.copyWith(
                      color: const Color(0xFF6B6B6B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: Branding.spacingL),

            // Tarih ve lokasyon
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: const Color(0xFF6B6B6B),
                  size: 16,
                ),
                const SizedBox(width: Branding.spacingS),
                Expanded(
                  child: Text(
                    conference['location'] as String,
                    style: AppTypography.bodySmall.copyWith(
                      color: const Color(0xFF6B6B6B),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: Branding.spacingS),

            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: const Color(0xFF6B6B6B),
                  size: 16,
                ),
                const SizedBox(width: Branding.spacingS),
                Text(
                  conference['date'] as String,
                  style: AppTypography.bodySmall.copyWith(
                    color: const Color(0xFF6B6B6B),
                  ),
                ),
              ],
            ),

            const SizedBox(height: Branding.spacingL),

            // Açıklama
            Text(
              conference['description'] as String,
              style: AppTypography.bodyMedium.copyWith(
                color: const Color(0xFF6B6B6B),
                height: 1.5,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: Branding.spacingM),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreConferencesButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF6B6B6B), const Color(0xFF4A4A4A)],
        ),
        borderRadius: BorderRadius.circular(Branding.radiusL),
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
          // Tüm konferanslar sayfasına git
          // Navigator.push(context, MaterialPageRoute(builder: (context) => AllConferencesPage()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingXL,
              tablet: Branding.spacingXXL,
              desktop: Branding.spacingXXL + 8,
            ),
            vertical: Branding.spacingL,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Branding.radiusL),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tüm Etkinlikleri Gör',
              style: AppTypography.button.copyWith(
                color: Colors.white,
                fontSize: Responsive.responsiveFontSize(
                  context,
                  mobile: 14,
                  tablet: 15,
                  desktop: 16,
                ),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: Branding.spacingS),
            const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
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

// Footer Widget
class _FooterWidget extends StatelessWidget {
  const _FooterWidget(this.context);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
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
      decoration: const BoxDecoration(
        color: Color(0xFF131B2E), // Dark blue-grey
      ),
      child: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileFooter(context),
        tablet: _buildDesktopFooter(context),
        desktop: _buildDesktopFooter(context),
      ),
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      children: [
        _buildFooterLogo(),
        const SizedBox(height: Branding.spacingXL),
        _buildFooterLinks(),
        const SizedBox(height: Branding.spacingXL),
        _buildFooterContact(),
        const SizedBox(height: Branding.spacingXL),
        _buildFooterBottom(),
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
            const SizedBox(width: Branding.spacingXXL),
            Expanded(flex: 1, child: _buildFooterLinks()),
            const SizedBox(width: Branding.spacingXXL),
            Expanded(flex: 1, child: _buildFooterContact()),
          ],
        ),
        const SizedBox(height: Branding.spacingXXL),
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
                horizontal: 20.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Text(
                'ŞEBO',
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFE0E0E0),
                    width: 1.5,
                  ),
                ),
              ),
              child: const Text(
                'creative agency',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  letterSpacing: 1.2,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: Branding.spacingL),

        // Açıklama
        Text(
          'Yaratıcı ve yenilikçi çözümler sunan premium dijital ajans olarak, müşterilerimize en iyi hizmeti sunmayı hedefliyoruz.',
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFFB0B0B0),
            height: 1.6,
          ),
        ),

        const SizedBox(height: Branding.spacingL),

        // Sosyal medya
        Row(
          children: [
            _buildSocialIcon(Icons.facebook, 'https://facebook.com'),
            const SizedBox(width: Branding.spacingM),
            _buildSocialIcon(Icons.camera_alt, 'https://instagram.com'),
            const SizedBox(width: Branding.spacingM),
            _buildSocialIcon(Icons.business, 'https://linkedin.com'),
            const SizedBox(width: Branding.spacingM),
            _buildSocialIcon(Icons.chat, 'https://twitter.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(icon, color: const Color(0xFFE0E0E0), size: 20),
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
          ),
        ),
        const SizedBox(height: Branding.spacingL),
        _buildFooterLink('Ana Sayfa'),
        _buildFooterLink('Hakkımızda'),
        _buildFooterLink('Projelerimiz'),
        _buildFooterLink('İletişim'),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Branding.spacingM),
      child: Text(
        text,
        style: AppTypography.bodyMedium.copyWith(
          color: const Color(0xFFB0B0B0),
        ),
      ),
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
          ),
        ),
        const SizedBox(height: Branding.spacingL),
        _buildContactItem(Icons.email, 'info@ajanssebo.com'),
        _buildContactItem(Icons.phone, '+90 (212) 123 45 67'),
        _buildContactItem(Icons.location_on, 'İstanbul, Türkiye'),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Branding.spacingM),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFB0B0B0), size: 16),
          const SizedBox(width: Branding.spacingS),
          Text(
            text,
            style: AppTypography.bodyMedium.copyWith(
              color: const Color(0xFFB0B0B0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBottom() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Branding.spacingL),
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
            ),
          ),
          Text(
            'Geliştirildi ❤️ ile',
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
            ),
          ),
        ],
      ),
    );
  }
}
