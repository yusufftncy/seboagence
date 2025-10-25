/// 🏠 Home Page - Ana sayfa
///
/// Bu sayfa, uygulamanın ana sayfasıdır.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';
import '../widgets/error_widget.dart' as custom;
import '../widgets/project_card.dart';
import '../../core/providers/project_providers.dart';

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
    final projectsAsync = ref.watch(projectsProvider);

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
                  // Premium Hero Section
                  _buildPremiumHeroSection(context),

                  // Services Section
                  _buildServicesSection(context),

                  // Projects Section
                  _buildProjectsSection(context, ref, projectsAsync),

                  // About Section
                  _buildAboutSection(context),

                  // Contact Section
                  _buildContactSection(context),
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
                      color: Color(0xFF1A1A1A), // Dark text
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
        _buildNavItem('Ana Sayfa', true),
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
      offset: const Offset(0, 40),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hoş İşler',
              style: AppTypography.bodyMedium.copyWith(
                color: const Color(0xFFE0E0E0),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFFE0E0E0),
              size: 16,
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'vefa',
          child: Row(
            children: [
              const Icon(Icons.business, color: Color(0xFF1A1A1A)),
              const SizedBox(width: 8),
              const Text('Vefa Projesi'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'sefa',
          child: Row(
            children: [
              const Icon(Icons.home, color: Color(0xFF1A1A1A)),
              const SizedBox(width: 8),
              const Text('Sefa Projesi'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'sifa',
          child: Row(
            children: [
              const Icon(Icons.health_and_safety, color: Color(0xFF1A1A1A)),
              const SizedBox(width: 8),
              const Text('Şifa Projesi'),
            ],
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
    return TextButton(
      onPressed: () {
        // Navigation
      },
      style: TextButton.styleFrom(
        foregroundColor: Branding.white,
        padding: const EdgeInsets.symmetric(
          horizontal: Branding.spacingM,
          vertical: Branding.spacingS,
        ),
      ),
      child: Text(
        text,
        style: AppTypography.bodyMedium.copyWith(
          color: isActive ? Branding.accentColor : Branding.white,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildPremiumHeroSection(BuildContext context) {
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
                                'ŞEBNEM YÜCEER',
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
                                  'L\'AGENCE ŞEBO',
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
                                'Lüks Markaların Türkiye\'deki\nStratejik Ortağı',
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
            color: const Color(0xFF1A1A1A), // Dark grey
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

  Widget _buildServicesSection(BuildContext context) {
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
        color: Branding.backgroundSecondary,
        boxShadow: [
          BoxShadow(
            color: Branding.primaryColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Section Header
          Text(
            'Hizmetlerimiz',
            style: AppTypography.h2.copyWith(
              color: Branding.textPrimary,
              fontSize: Responsive.responsiveFontSize(
                context,
                desktop: 48,
                tablet: 36,
                mobile: 28,
              ),
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: Branding.spacingM),

          Text(
            'Dijital dünyada markanızı öne çıkaran çözümler',
            style: AppTypography.h4.copyWith(
              color: Branding.textSecondary,
              fontSize: Responsive.responsiveFontSize(
                context,
                desktop: 20,
                tablet: 18,
                mobile: 16,
              ),
              fontWeight: FontWeight.w300,
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

          // Services Grid
          _buildServicesGrid(context),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {
        'icon': '🌐',
        'title': 'Web Tasarım',
        'description': 'Modern ve responsive web siteleri',
        'color': Branding.primaryColor,
      },
      {
        'icon': '📱',
        'title': 'Mobil Uygulama',
        'description': 'iOS ve Android uygulamaları',
        'color': Branding.secondaryColor,
      },
      {
        'icon': '🛒',
        'title': 'E-Ticaret',
        'description': 'Online mağaza çözümleri',
        'color': Branding.accentColor,
      },
      {
        'icon': '📊',
        'title': 'Dijital Pazarlama',
        'description': 'SEO, SEM ve sosyal medya',
        'color': Branding.success,
      },
      {
        'icon': '🎨',
        'title': 'Marka Kimliği',
        'description': 'Logo ve kurumsal kimlik',
        'color': Branding.warning,
      },
      {
        'icon': '💬',
        'title': 'Danışmanlık',
        'description': 'Dijital dönüşüm rehberliği',
        'color': Branding.error,
      },
    ];

    return Responsive.responsiveWidget(
      context,
      mobile: _buildMobileServicesGrid(context, services),
      tablet: _buildTabletServicesGrid(context, services),
      desktop: _buildDesktopServicesGrid(context, services),
    );
  }

  Widget _buildMobileServicesGrid(
    BuildContext context,
    List<Map<String, dynamic>> services,
  ) {
    return Column(
      children: services
          .map(
            (service) => Padding(
              padding: const EdgeInsets.only(bottom: Branding.spacingL),
              child: _buildServiceCard(context, service),
            ),
          )
          .toList(),
    );
  }

  Widget _buildTabletServicesGrid(
    BuildContext context,
    List<Map<String, dynamic>> services,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Branding.spacingL,
        mainAxisSpacing: Branding.spacingL,
        childAspectRatio: 1.2,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) =>
          _buildServiceCard(context, services[index]),
    );
  }

  Widget _buildDesktopServicesGrid(
    BuildContext context,
    List<Map<String, dynamic>> services,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: Branding.spacingXL,
        mainAxisSpacing: Branding.spacingXL,
        childAspectRatio: 1.1,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) =>
          _buildServiceCard(context, services[index]),
    );
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> service) {
    return Container(
      constraints: const BoxConstraints(minHeight: 200, maxHeight: 300),
      decoration: BoxDecoration(
        color: Branding.white,
        borderRadius: BorderRadius.circular(Branding.radiusXL),
        boxShadow: [
          BoxShadow(
            color: Branding.primaryColor.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Branding.radiusXL),
          onTap: () {
            // Service detail sayfasına git
          },
          child: Padding(
            padding: const EdgeInsets.all(Branding.spacingXL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(Branding.spacingL),
                  decoration: BoxDecoration(
                    color: (service['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Branding.radiusL),
                  ),
                  child: Text(
                    service['icon'] as String,
                    style: TextStyle(
                      fontSize: Responsive.responsiveValue(
                        context,
                        mobile: 32,
                        tablet: 40,
                        desktop: 48,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: Responsive.responsiveValue(
                    context,
                    mobile: Branding.spacingL,
                    tablet: Branding.spacingXL,
                    desktop: Branding.spacingXL,
                  ),
                ),

                Flexible(
                  child: Text(
                    service['title'] as String,
                    style: AppTypography.h5.copyWith(
                      color: Branding.textPrimary,
                      fontSize: Responsive.responsiveFontSize(
                        context,
                        mobile: 18,
                        tablet: 20,
                        desktop: 22,
                      ),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: Branding.spacingS),

                Flexible(
                  child: Text(
                    service['description'] as String,
                    style: AppTypography.bodyMedium.copyWith(
                      color: Branding.textSecondary,
                      fontSize: Responsive.responsiveFontSize(
                        context,
                        mobile: 14,
                        tablet: 15,
                        desktop: 16,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue projectsAsync,
  ) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Center(
            child: Column(
              children: [
                Text(
                  'Projelerimiz',
                  style: AppTypography.h2.copyWith(
                    color: Branding.textPrimary,
                    fontSize: Responsive.responsiveFontSize(
                      context,
                      desktop: 48,
                      tablet: 36,
                      mobile: 28,
                    ),
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: Branding.spacingM),

                Text(
                  'Başarılı projelerimizden örnekler',
                  style: AppTypography.h4.copyWith(
                    color: Branding.textSecondary,
                    fontSize: Responsive.responsiveFontSize(
                      context,
                      desktop: 20,
                      tablet: 18,
                      mobile: 16,
                    ),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingXL,
              tablet: Branding.spacingXXL,
              desktop: Branding.spacingXXL + 16,
            ),
          ),

          // Projects Content
          projectsAsync.when(
            data: (projects) => _buildProjectsGrid(context, projects),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => custom.ErrorWidget(
              message: error.toString(),
              onRetry: () => ref.refresh(projectsProvider),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, List projects) {
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
            return ProjectCard(
              project: projects[index],
              onTap: () {
                // Proje detayına git
              },
            );
          },
        );
      },
    );
  }

  Widget _buildAboutSection(BuildContext context) {
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
          colors: [Branding.backgroundSecondary, Branding.backgroundPrimary],
        ),
        boxShadow: [
          BoxShadow(
            color: Branding.primaryColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
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
        Text(
          'Hakkımızda',
          style: AppTypography.h2.copyWith(
            color: Branding.textPrimary,
            fontSize: Responsive.responsiveFontSize(
              context,
              desktop: 48,
              tablet: 36,
              mobile: 28,
            ),
            fontWeight: FontWeight.w800,
          ),
        ),

        SizedBox(
          height: Responsive.responsiveValue(
            context,
            mobile: Branding.spacingL,
            tablet: Branding.spacingXL,
            desktop: Branding.spacingXL,
          ),
        ),

        Text(
          'Yaratıcı ve yenilikçi çözümler sunan premium dijital ajans olarak, müşterilerimize en iyi hizmeti sunmayı hedefliyoruz.',
          style: AppTypography.bodyLarge.copyWith(
            color: Branding.textSecondary,
            fontSize: Responsive.responsiveFontSize(
              context,
              mobile: 16,
              tablet: 18,
              desktop: 20,
            ),
            height: 1.6,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(
          height: Responsive.responsiveValue(
            context,
            mobile: Branding.spacingL,
            tablet: Branding.spacingXL,
            desktop: Branding.spacingXL,
          ),
        ),

        Text(
          '2015 yılından beri dijital dünyada faaliyet gösteren ajansımız, web tasarımından mobil uygulama geliştirmeye, e-ticaret çözümlerinden dijital pazarlama stratejilerine kadar geniş bir yelpazede hizmet vermektedir.',
          style: AppTypography.bodyMedium.copyWith(
            color: Branding.textSecondary,
            fontSize: Responsive.responsiveFontSize(
              context,
              mobile: 14,
              tablet: 15,
              desktop: 16,
            ),
            height: 1.6,
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(
          height: Responsive.responsiveValue(
            context,
            mobile: Branding.spacingXL,
            tablet: Branding.spacingXL,
            desktop: Branding.spacingXL,
          ),
        ),

        _buildAboutButton(context),
      ],
    );
  }

  Widget _buildAboutButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: Branding.primaryGradient,
        borderRadius: BorderRadius.circular(Branding.radiusXL),
        boxShadow: [
          BoxShadow(
            color: Branding.primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Hakkımızda sayfasına git
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
          'Daha Fazla Bilgi',
          style: AppTypography.button.copyWith(
            color: Branding.white,
            fontSize: Responsive.responsiveFontSize(
              context,
              mobile: 16,
              tablet: 18,
              desktop: 20,
            ),
            fontWeight: FontWeight.w700,
          ),
        ),
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
        color: Branding.white,
        borderRadius: BorderRadius.circular(Branding.radiusXL),
        boxShadow: [
          BoxShadow(
            color: Branding.primaryColor.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
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
            color: Branding.primaryColor,
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
            color: Branding.textSecondary,
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

  Widget _buildContactSection(BuildContext context) {
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
        gradient: Branding.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: Branding.primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'İletişime Geçin',
            style: AppTypography.h2.copyWith(
              color: Branding.white,
              fontSize: Responsive.responsiveFontSize(
                context,
                desktop: 48,
                tablet: 36,
                mobile: 28,
              ),
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: Branding.spacingM),

          Text(
            'Projenizi hayata geçirmek için bizimle iletişime geçin',
            style: AppTypography.h4.copyWith(
              color: Branding.white.withValues(alpha: 0.9),
              fontSize: Responsive.responsiveFontSize(
                context,
                desktop: 20,
                tablet: 18,
                mobile: 16,
              ),
              fontWeight: FontWeight.w300,
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

          _buildContactButtons(context),
        ],
      ),
    );
  }

  Widget _buildContactButtons(BuildContext context) {
    return Responsive.responsiveWidget(
      context,
      mobile: Column(
        children: [
          _buildContactButton(context, 'Proje Başlat', '🚀', () {
            // Proje başlatma formu
          }),
          const SizedBox(height: Branding.spacingM),
          _buildContactButton(context, 'Ücretsiz Danışmanlık', '💬', () {
            // Danışmanlık formu
          }),
        ],
      ),
      tablet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildContactButton(context, 'Proje Başlat', '🚀', () {
            // Proje başlatma formu
          }),
          const SizedBox(width: Branding.spacingL),
          _buildContactButton(context, 'Ücretsiz Danışmanlık', '💬', () {
            // Danışmanlık formu
          }),
        ],
      ),
      desktop: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildContactButton(context, 'Proje Başlat', '🚀', () {
            // Proje başlatma formu
          }),
          const SizedBox(width: Branding.spacingXL),
          _buildContactButton(context, 'Ücretsiz Danışmanlık', '💬', () {
            // Danışmanlık formu
          }),
        ],
      ),
    );
  }

  Widget _buildContactButton(
    BuildContext context,
    String text,
    String icon,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Branding.white,
        borderRadius: BorderRadius.circular(Branding.radiusXL),
        boxShadow: [
          BoxShadow(
            color: Branding.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Branding.radiusXL),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.responsiveValue(
                context,
                mobile: Branding.spacingXL,
                tablet: Branding.spacingXXL,
                desktop: Branding.spacingXXL + 8,
              ),
              vertical: Branding.spacingL,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  icon,
                  style: TextStyle(
                    fontSize: Responsive.responsiveValue(
                      context,
                      mobile: 20,
                      tablet: 24,
                      desktop: 28,
                    ),
                  ),
                ),
                const SizedBox(width: Branding.spacingM),
                Text(
                  text,
                  style: AppTypography.button.copyWith(
                    color: Branding.primaryColor,
                    fontSize: Responsive.responsiveFontSize(
                      context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                    ),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
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
