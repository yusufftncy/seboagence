/// 🧭 Ultra-Optimized Navigation Bar Widget
///
/// Bu widget, maksimum performans ve kullanıcı deneyimi için optimize edilmiş navigation bar'ı içerir.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/branding.dart';
import '../../core/utils/responsive.dart';
import '../../core/services/navigation_service.dart';
import 'optimized_logo.dart';

class OptimizedNavigationBar extends StatefulWidget {
  final bool isSticky;
  final bool showScrollIndicator;
  final VoidCallback? onLogoTap;

  const OptimizedNavigationBar({
    super.key,
    this.isSticky = true,
    this.showScrollIndicator = false,
    this.onLogoTap,
  });

  @override
  State<OptimizedNavigationBar> createState() => _OptimizedNavigationBarState();
}

class _OptimizedNavigationBarState extends State<OptimizedNavigationBar>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // Animation Controllers
  late AnimationController _logoAnimationController;
  late AnimationController _menuAnimationController;
  late AnimationController _scrollAnimationController;

  // Animations
  late Animation<double> _logoAnimation;
  late Animation<double> _menuAnimation;
  late Animation<double> _scrollAnimation;
  late Animation<Offset> _slideAnimation;

  // State
  bool _isMenuOpen = false;
  bool _isScrolled = false;

  // Performance optimizations
  static const Duration _fastAnimation = Duration(milliseconds: 150);
  static const Duration _mediumAnimation = Duration(milliseconds: 300);
  static const Duration _slowAnimation = Duration(milliseconds: 500);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startInitialAnimations();
  }

  void _initializeAnimations() {
    // Logo animation
    _logoAnimationController = AnimationController(
      duration: _slowAnimation,
      vsync: this,
    );

    // Menu animation
    _menuAnimationController = AnimationController(
      duration: _mediumAnimation,
      vsync: this,
    );

    // Scroll animation
    _scrollAnimationController = AnimationController(
      duration: _fastAnimation,
      vsync: this,
    );

    // Logo scale and opacity
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Menu fade in
    _menuAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _menuAnimationController, curve: Curves.easeOut),
    );

    // Scroll-based animations
    _scrollAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scrollAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Slide animation for mobile menu
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _menuAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  void _startInitialAnimations() {
    // Staggered animation start
    _logoAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _menuAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _menuAnimationController.dispose();
    _scrollAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return AnimatedBuilder(
      animation: _scrollAnimation,
      builder: (context, child) {
        return Container(
          height: _getResponsiveHeight(context),
          decoration: _buildDecoration(),
          child: _buildContent(),
        );
      },
    );
  }

  // 📱 FULLY RESPONSIVE HEIGHT CALCULATION
  double _getResponsiveHeight(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    
    // Landscape mode adjustments
    if (orientation == Orientation.landscape && Responsive.isMobile(context)) {
      return Responsive.mobileResponsiveValue(
        context,
        smallMobile: 48.0, // Ultra-compact for landscape
        mediumMobile: 50.0,
        largeMobile: 52.0,
        tablet: 60.0,
        desktop: 70.0,
      );
    }
    
    // Portrait mode - detailed mobile breakpoints
    return Responsive.mobileResponsiveValue(
      context,
      smallMobile: 52.0, // iPhone SE, küçük telefonlar
      mediumMobile: 56.0, // iPhone 12/13/14 standard
      largeMobile: 60.0, // iPhone Plus, büyük telefonlar
      tablet: 70.0, // Tablet
      desktop: 80.0, // Desktop
    );
  }

  BoxDecoration _buildDecoration() {
    final double elevation = _isScrolled ? 8.0 : 2.0;
    final double opacity = _isScrolled ? 0.95 : 1.0;

    return BoxDecoration(
      color: const Color(0xFF131B2E).withValues(alpha: opacity),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF131B2E).withValues(alpha: 0.3),
          blurRadius: elevation,
          offset: Offset(0, elevation / 2),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: _getResponsivePadding(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildOptimizedLogo(), _buildResponsiveNavigation()],
      ),
    );
  }

  // 📱 FULLY RESPONSIVE PADDING CALCULATION
  EdgeInsets _getResponsivePadding(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    
    // Landscape mode adjustments
    if (orientation == Orientation.landscape && Responsive.isMobile(context)) {
      return EdgeInsets.symmetric(
        horizontal: Responsive.mobileResponsiveValue(
          context,
          smallMobile: 6.0, // Ultra-minimal for landscape
          mediumMobile: 8.0,
          largeMobile: 10.0,
          tablet: 12.0,
          desktop: 16.0,
        ),
        vertical: Responsive.mobileResponsiveValue(
          context,
          smallMobile: 2.0, // Ultra-minimal vertical
          mediumMobile: 3.0,
          largeMobile: 4.0,
          tablet: 6.0,
          desktop: 8.0,
        ),
      );
    }
    
    // Portrait mode - detailed mobile breakpoints
    return EdgeInsets.symmetric(
      horizontal: Responsive.mobileResponsiveValue(
        context,
        smallMobile: 8.0, // iPhone SE için minimal
        mediumMobile: 12.0, // iPhone 12/13/14 standard
        largeMobile: 16.0, // iPhone Plus için daha fazla
        tablet: 20.0, // Tablet
        desktop: 24.0, // Desktop
      ),
      vertical: Responsive.mobileResponsiveValue(
        context,
        smallMobile: 4.0, // iPhone SE için minimal
        mediumMobile: 6.0, // iPhone 12/13/14 standard
        largeMobile: 8.0, // iPhone Plus için daha fazla
        tablet: 10.0, // Tablet
        desktop: 12.0, // Desktop
      ),
    );
  }

  Widget _buildOptimizedLogo() {
    return AnimatedBuilder(
      animation: _logoAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * _logoAnimation.value),
          child: Opacity(
            opacity: _logoAnimation.value,
            child: GestureDetector(
              onTap: widget.onLogoTap ?? () => NavigationService.goToHome(),
              child: const OptimizedLogo(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResponsiveNavigation() {
    return Responsive.responsiveWidget(
      context,
      mobile: _buildMobileNavigation(),
      tablet: _buildDesktopNavigation(),
      desktop: _buildDesktopNavigation(),
    );
  }

  Widget _buildMobileNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Scroll indicator - responsive spacing
        if (widget.showScrollIndicator) ...[
          _buildScrollIndicator(),
          SizedBox(
            width: Responsive.mobileResponsiveValue(
              context,
              smallMobile: 8.0, // Minimal spacing for small screens
              mediumMobile: 10.0,
              largeMobile: 12.0,
              tablet: 12.0,
              desktop: 12.0,
            ),
          ),
        ],

        // Fully responsive mobile menu button
        _buildResponsiveMobileMenuButton(),
      ],
    );
  }

  Widget _buildResponsiveMobileMenuButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x0DFFFFFF),
            Color(0x1AFFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(
          Responsive.mobileResponsiveValue(
            context,
            smallMobile: 6.0, // Smaller radius for small screens
            mediumMobile: 8.0,
            largeMobile: 10.0,
            tablet: 12.0,
            desktop: 12.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.05),
            blurRadius: Responsive.mobileResponsiveValue(
              context,
              smallMobile: 1.0, // Subtle shadow for small screens
              mediumMobile: 2.0,
              largeMobile: 3.0,
              tablet: 4.0,
              desktop: 4.0,
            ),
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleMobileMenuWithHaptic,
          borderRadius: BorderRadius.circular(
            Responsive.mobileResponsiveValue(
              context,
              smallMobile: 6.0,
              mediumMobile: 8.0,
              largeMobile: 10.0,
              tablet: 12.0,
              desktop: 12.0,
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(
              Responsive.mobileResponsiveValue(
                context,
                smallMobile: 6.0, // Minimal padding for small screens
                mediumMobile: 8.0,
                largeMobile: 10.0,
                tablet: 12.0,
                desktop: 12.0,
              ),
            ),
            child: AnimatedRotation(
              turns: _isMenuOpen ? 0.125 : 0.0,
              duration: _fastAnimation,
              child: Icon(
                Icons.menu,
                color: Branding.white,
                size: Responsive.mobileResponsiveValue(
                  context,
                  smallMobile: 16.0, // Smaller icon for small screens
                  mediumMobile: 18.0,
                  largeMobile: 20.0,
                  tablet: 22.0,
                  desktop: 24.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildDesktopNavigation() {
    return AnimatedBuilder(
      animation: _menuAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _menuAnimation.value,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Advanced responsive spacing for desktop
              final spacing = _getDesktopSpacing(constraints.maxWidth);
              final isLargeDesktop = constraints.maxWidth > 1400;
              final isMediumDesktop = constraints.maxWidth > 1200;

              return Container(
                constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                child: isLargeDesktop
                    ? _buildLargeDesktopNavigation(spacing)
                    : isMediumDesktop
                    ? _buildMediumDesktopNavigation(spacing)
                    : _buildSmallDesktopNavigation(spacing),
              );
            },
          ),
        );
      },
    );
  }

  double _getDesktopSpacing(double width) {
    // Çok küçük spacing'ler ile overflow'u önle
    if (width > 1600) return 16.0; // Ultra-wide
    if (width > 1400) return 12.0; // Large desktop
    if (width > 1200) return 8.0; // Desktop
    if (width > 1000) return 4.0; // Small desktop
    return 2.0; // Tablet
  }

  Widget _buildLargeDesktopNavigation(double spacing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavItem('Ana Sayfa', false, Icons.home),
        SizedBox(width: spacing),
        _buildNavItem('Hakkımızda', false, Icons.info),
        SizedBox(width: spacing),
        _buildProjectsDropdown(),
        SizedBox(width: spacing),
        _buildConferencesDropdown(),
        SizedBox(width: spacing),
        _buildNavItem('İletişim', false, Icons.contact_phone),
      ],
    );
  }

  Widget _buildMediumDesktopNavigation(double spacing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavItem('Ana Sayfa', false, Icons.home),
        SizedBox(width: spacing),
        _buildNavItem('Hakkımızda', false, Icons.info),
        SizedBox(width: spacing),
        _buildProjectsDropdown(),
        SizedBox(width: spacing),
        _buildConferencesDropdown(),
        SizedBox(width: spacing),
        _buildNavItem('İletişim', false, Icons.contact_phone),
      ],
    );
  }

  Widget _buildSmallDesktopNavigation(double spacing) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNavItem('Ana Sayfa', false, Icons.home),
          SizedBox(width: spacing),
          _buildNavItem('Hakkımızda', false, Icons.info),
          SizedBox(width: spacing),
          _buildProjectsDropdown(),
          SizedBox(width: spacing),
          _buildConferencesDropdown(),
          SizedBox(width: spacing),
          _buildNavItem('İletişim', false, Icons.contact_phone),
        ],
      ),
    );
  }

  Widget _buildNavItem(String text, bool isActive, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1.0), // Reduced margin
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleNavigationWithHaptic(text),
          borderRadius: BorderRadius.circular(
            8.0,
          ), // Smaller radius for minimal look
          hoverColor: Colors.white.withValues(alpha: 0.1),
          focusColor: Colors.white.withValues(alpha: 0.15),
          child: Focus(
            onKeyEvent: (node, event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.enter) {
                _handleNavigationWithHaptic(text);
                return KeyEventResult.handled;
              }
              return KeyEventResult.ignored;
            },
            child: AnimatedContainer(
              duration: _fastAnimation,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.responsiveValue(
                  context,
                  mobile: 4.0, // Even smaller padding for mobile
                  tablet: 6.0,
                  desktop: 8.0,
                ),
                vertical: Responsive.responsiveValue(
                  context,
                  mobile: 6.0, // Smaller vertical padding
                  tablet: 8.0,
                  desktop: 10.0,
                ),
              ),
              decoration: BoxDecoration(
                gradient: _buildNavItemGradient(isActive),
                borderRadius: BorderRadius.circular(8.0), // Smaller radius
                border: isActive ? _buildActiveBorder() : null,
                boxShadow: isActive ? _buildActiveShadow() : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: Responsive.responsiveValue(
                      context,
                      mobile: 12, // Slightly larger for better visibility
                      tablet: 13,
                      desktop: 14,
                    ),
                  ),
                  SizedBox(
                    width: Responsive.responsiveValue(
                      context,
                      mobile: 3, // Slightly larger spacing
                      tablet: 4,
                      desktop: 5,
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      fontSize: Responsive.responsiveValue(
                        context,
                        mobile: 11, // Slightly larger for better readability
                        tablet: 12,
                        desktop: 13,
                      ),
                      letterSpacing: 0.3, // Reduced letter spacing
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BoxShadow> _buildActiveShadow() {
    return [
      BoxShadow(
        color: Colors.white.withValues(alpha: 0.2),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }

  LinearGradient _buildNavItemGradient(bool isActive) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isActive
          ? const [Color(0x26FFFFFF), Color(0x40FFFFFF)]
          : const [Color(0x0DFFFFFF), Color(0x26FFFFFF)],
    );
  }

  Border _buildActiveBorder() {
    return Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1);
  }

  Widget _buildProjectsDropdown() {
    return _buildDropdownMenu('Hoş İşler', Icons.work, [
      _buildDropdownItem('Vefa Projesi', 'vefa', Icons.favorite),
      _buildDropdownItem('Sefa Projesi', 'sefa', Icons.palette),
      _buildDropdownItem('Şifa Projesi', 'sifa', Icons.healing),
    ], _handleProjectNavigation);
  }

  Widget _buildConferencesDropdown() {
    return _buildDropdownMenu('Konferanslar', Icons.event, [
      _buildDropdownItem('Vefa Buluşmaları 2025', 'vefa_bulusma', Icons.event),
      _buildDropdownItem(
        'Avrupa İklim Değişikliği Uyum Konferansı',
        'iklim_konferans',
        Icons.eco,
      ),
      _buildDropdownItem('Tüm Konferanslar', 'tum_konferanslar', Icons.list),
    ], _handleConferenceNavigation);
  }

  Widget _buildDropdownMenu(
    String title,
    IconData icon,
    List<Widget> items,
    Function(String) onSelected,
  ) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ), // Smaller radius
      onOpened: () => HapticFeedback.lightImpact(),
      itemBuilder: (context) => items.cast<PopupMenuEntry<String>>(),
      onSelected: onSelected,
      tooltip: '$title menüsünü aç',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.responsiveValue(
            context,
            mobile: 4, // Even smaller padding for mobile
            tablet: 6,
            desktop: 8,
          ),
          vertical: Responsive.responsiveValue(
            context,
            mobile: 6, // Smaller vertical padding
            tablet: 8,
            desktop: 10,
          ),
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0x0DFFFFFF),
              Color(0x1AFFFFFF),
            ], // More subtle gradient
          ),
          borderRadius: BorderRadius.circular(8.0), // Smaller radius
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: Responsive.responsiveValue(
                context,
                mobile: 12, // Slightly larger for better visibility
                tablet: 13,
                desktop: 14,
              ),
            ),
            SizedBox(
              width: Responsive.responsiveValue(
                context,
                mobile: 3, // Slightly larger spacing
                tablet: 4,
                desktop: 5,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: Responsive.responsiveValue(
                  context,
                  mobile: 11, // Slightly larger for better readability
                  tablet: 12,
                  desktop: 13,
                ),
                letterSpacing: 0.3, // Reduced letter spacing
              ),
            ),
            SizedBox(
              width: Responsive.responsiveValue(
                context,
                mobile: 3, // Slightly larger spacing
                tablet: 4,
                desktop: 5,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: Responsive.responsiveValue(
                context,
                mobile: 14, // Smaller arrow for mobile
                tablet: 15,
                desktop: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownItem(String title, String value, IconData icon) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6B6B6B), size: 16),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF6B6B6B),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollIndicator() {
    return AnimatedBuilder(
      animation: _scrollAnimation,
      builder: (context, child) {
        return Container(
          width: Responsive.mobileResponsiveValue(
            context,
            smallMobile: 2.0, // Ultra-thin for small screens
            mediumMobile: 3.0,
            largeMobile: 3.5,
            tablet: 4.0,
            desktop: 4.0,
          ),
          height: Responsive.mobileResponsiveValue(
            context,
            smallMobile: 14.0, // Shorter for small screens
            mediumMobile: 16.0,
            largeMobile: 18.0,
            tablet: 20.0,
            desktop: 20.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(
              Responsive.mobileResponsiveValue(
                context,
                smallMobile: 1.0, // Smaller radius for small screens
                mediumMobile: 1.5,
                largeMobile: 2.0,
                tablet: 2.0,
                desktop: 2.0,
              ),
            ),
          ),
          child: FractionallySizedBox(
            heightFactor: _scrollAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  Responsive.mobileResponsiveValue(
                    context,
                    smallMobile: 1.0, // Smaller radius for small screens
                    mediumMobile: 1.5,
                    largeMobile: 2.0,
                    tablet: 2.0,
                    desktop: 2.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggleMobileMenuWithHaptic() {
    HapticFeedback.lightImpact();
    _toggleMobileMenu();
  }

  void _toggleMobileMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });

    if (_isMenuOpen) {
      _showMobileMenuOverlay();
    }
  }

  void _showMobileMenuOverlay() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) => _buildMobileMenuOverlay(),
    ).then((_) {
      if (mounted) {
        setState(() {
          _isMenuOpen = false;
        });
      }
    });
  }

  Widget _buildMobileMenuOverlay() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF131B2E),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              Responsive.mobileResponsiveValue(
                context,
                smallMobile: 16.0, // Smaller radius for small screens
                mediumMobile: 18.0,
                largeMobile: 20.0,
                tablet: 22.0,
                desktop: 24.0,
              ),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: Responsive.mobileResponsiveValue(
                context,
                smallMobile: 12.0, // Smaller shadow for small screens
                mediumMobile: 15.0,
                largeMobile: 18.0,
                tablet: 20.0,
                desktop: 24.0,
              ),
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Responsive handle bar
            Container(
              width: Responsive.mobileResponsiveValue(
                context,
                smallMobile: 32.0, // Smaller for small screens
                mediumMobile: 36.0,
                largeMobile: 40.0,
                tablet: 44.0,
                desktop: 48.0,
              ),
              height: Responsive.mobileResponsiveValue(
                context,
                smallMobile: 3.0, // Thinner for small screens
                mediumMobile: 4.0,
                largeMobile: 4.0,
                tablet: 5.0,
                desktop: 5.0,
              ),
              margin: EdgeInsets.symmetric(
                vertical: Responsive.mobileResponsiveValue(
                  context,
                  smallMobile: 8.0, // Minimal margin for small screens
                  mediumMobile: 10.0,
                  largeMobile: 12.0,
                  tablet: 14.0,
                  desktop: 16.0,
                ),
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0x33FFFFFF), Color(0x66FFFFFF)],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Responsive header section
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.mobileResponsiveValue(
                  context,
                  smallMobile: 16.0, // Minimal padding for small screens
                  mediumMobile: 18.0,
                  largeMobile: 20.0,
                  tablet: 22.0,
                  desktop: 24.0,
                ),
                vertical: Responsive.mobileResponsiveValue(
                  context,
                  smallMobile: 8.0, // Minimal vertical padding
                  mediumMobile: 10.0,
                  largeMobile: 12.0,
                  tablet: 14.0,
                  desktop: 16.0,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(
                      Responsive.mobileResponsiveValue(
                        context,
                        smallMobile: 4.0, // Minimal padding for small screens
                        mediumMobile: 5.0,
                        largeMobile: 6.0,
                        tablet: 7.0,
                        desktop: 8.0,
                      ),
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0x0DFFFFFF),
                          Color(0x1AFFFFFF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        Responsive.mobileResponsiveValue(
                          context,
                          smallMobile: 4.0, // Smaller radius for small screens
                          mediumMobile: 5.0,
                          largeMobile: 6.0,
                          tablet: 7.0,
                          desktop: 8.0,
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.menu,
                      color: Branding.white,
                      size: Responsive.mobileResponsiveValue(
                        context,
                        smallMobile: 14.0, // Smaller icon for small screens
                        mediumMobile: 16.0,
                        largeMobile: 18.0,
                        tablet: 20.0,
                        desktop: 22.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Responsive.mobileResponsiveValue(
                      context,
                      smallMobile: 8.0, // Minimal spacing for small screens
                      mediumMobile: 10.0,
                      largeMobile: 12.0,
                      tablet: 14.0,
                      desktop: 16.0,
                    ),
                  ),
                  Text(
                    'Menü',
                    style: TextStyle(
                      color: Branding.white,
                      fontSize: Responsive.mobileResponsiveValue(
                        context,
                        smallMobile: 14.0, // Smaller font for small screens
                        mediumMobile: 16.0,
                        largeMobile: 18.0,
                        tablet: 20.0,
                        desktop: 22.0,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Responsive divider
            Container(
              height: Responsive.mobileResponsiveValue(
                context,
                smallMobile: 0.5, // Thinner for small screens
                mediumMobile: 0.8,
                largeMobile: 1.0,
                tablet: 1.2,
                desktop: 1.5,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: Responsive.mobileResponsiveValue(
                  context,
                  smallMobile: 16.0, // Minimal margin for small screens
                  mediumMobile: 18.0,
                  largeMobile: 20.0,
                  tablet: 22.0,
                  desktop: 24.0,
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // Responsive menu items
            Padding(
              padding: EdgeInsets.all(
                Responsive.mobileResponsiveValue(
                  context,
                  smallMobile: 16.0, // Minimal padding for small screens
                  mediumMobile: 18.0,
                  largeMobile: 20.0,
                  tablet: 22.0,
                  desktop: 24.0,
                ),
              ),
              child: Column(
                children: [
                  _buildResponsiveMobileMenuItem('Ana Sayfa', Icons.home, false),
                  _buildResponsiveMobileMenuItem('Hakkımızda', Icons.info, false),
                  _buildResponsiveMobileMenuItem('Hoş İşler', Icons.work, false),
                  _buildResponsiveMobileMenuItem('Konferanslar', Icons.event, false),
                  _buildResponsiveMobileMenuItem('İletişim', Icons.contact_phone, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveMobileMenuItem(
    String title,
    IconData icon,
    bool isActive,
  ) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Responsive.mobileResponsiveValue(
          context,
          smallMobile: 4.0, // Minimal margin for small screens
          mediumMobile: 6.0,
          largeMobile: 8.0,
          tablet: 10.0,
          desktop: 12.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
            _handleNavigation(title);
          },
          borderRadius: BorderRadius.circular(
            Responsive.mobileResponsiveValue(
              context,
              smallMobile: 8.0, // Smaller radius for small screens
              mediumMobile: 10.0,
              largeMobile: 12.0,
              tablet: 14.0,
              desktop: 16.0,
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.mobileResponsiveValue(
                context,
                smallMobile: 12.0, // Minimal padding for small screens
                mediumMobile: 14.0,
                largeMobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
              ),
              vertical: Responsive.mobileResponsiveValue(
                context,
                smallMobile: 8.0, // Minimal vertical padding
                mediumMobile: 10.0,
                largeMobile: 12.0,
                tablet: 14.0,
                desktop: 16.0,
              ),
            ),
            decoration: BoxDecoration(
              gradient: isActive
                  ? const LinearGradient(
                      colors: [
                        Color(0x0DFFFFFF),
                        Color(0x1AFFFFFF),
                      ],
                    )
                  : null,
              borderRadius: BorderRadius.circular(
                Responsive.mobileResponsiveValue(
                  context,
                  smallMobile: 8.0, // Smaller radius for small screens
                  mediumMobile: 10.0,
                  largeMobile: 12.0,
                  tablet: 14.0,
                  desktop: 16.0,
                ),
              ),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.05),
                width: Responsive.mobileResponsiveValue(
                  context,
                  smallMobile: 0.3, // Thinner border for small screens
                  mediumMobile: 0.4,
                  largeMobile: 0.5,
                  tablet: 0.6,
                  desktop: 0.7,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(
                    Responsive.mobileResponsiveValue(
                      context,
                      smallMobile: 4.0, // Minimal padding for small screens
                      mediumMobile: 5.0,
                      largeMobile: 6.0,
                      tablet: 7.0,
                      desktop: 8.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0x0DFFFFFF),
                        Color(0x1AFFFFFF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(
                      Responsive.mobileResponsiveValue(
                        context,
                        smallMobile: 4.0, // Smaller radius for small screens
                        mediumMobile: 5.0,
                        largeMobile: 6.0,
                        tablet: 7.0,
                        desktop: 8.0,
                      ),
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: Branding.white,
                    size: Responsive.mobileResponsiveValue(
                      context,
                      smallMobile: 14.0, // Smaller icon for small screens
                      mediumMobile: 16.0,
                      largeMobile: 18.0,
                      tablet: 20.0,
                      desktop: 22.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: Responsive.mobileResponsiveValue(
                    context,
                    smallMobile: 8.0, // Minimal spacing for small screens
                    mediumMobile: 10.0,
                    largeMobile: 12.0,
                    tablet: 14.0,
                    desktop: 16.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Branding.white,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      fontSize: Responsive.mobileResponsiveValue(
                        context,
                        smallMobile: 13.0, // Smaller font for small screens
                        mediumMobile: 14.0,
                        largeMobile: 15.0,
                        tablet: 16.0,
                        desktop: 17.0,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withValues(alpha: 0.3),
                  size: Responsive.mobileResponsiveValue(
                    context,
                    smallMobile: 10.0, // Smaller arrow for small screens
                    mediumMobile: 11.0,
                    largeMobile: 12.0,
                    tablet: 13.0,
                    desktop: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _handleNavigationWithHaptic(String route) {
    HapticFeedback.lightImpact();
    _handleNavigation(route);
  }

  void _handleNavigation(String route) {
    switch (route) {
      case 'Ana Sayfa':
        NavigationService.goToHome();
        break;
      case 'Hakkımızda':
        NavigationService.goToAbout();
        break;
      case 'İletişim':
        NavigationService.goToContact();
        break;
    }
  }

  void _handleProjectNavigation(String project) {
    switch (project) {
      case 'vefa':
        NavigationService.goToProject('vefa');
        break;
      case 'sefa':
        NavigationService.goToProject('sefa');
        break;
      case 'sifa':
        NavigationService.goToProject('sifa');
        break;
    }
  }

  void _handleConferenceNavigation(String conference) {
    switch (conference) {
      case 'vefa_bulusma':
        NavigationService.goToConference('vefa_bulusma');
        break;
      case 'iklim_konferans':
        NavigationService.goToConference('iklim_konferans');
        break;
      case 'tum_konferanslar':
        NavigationService.goToAllConferences();
        break;
    }
  }

  // Public methods for external control
  void updateScrollOffset(double offset) {
    if (mounted) {
      setState(() {
        _isScrolled = offset > 50;
      });

      if (_isScrolled) {
        _scrollAnimationController.forward();
      } else {
        _scrollAnimationController.reverse();
      }
    }
  }

  void closeMobileMenu() {
    if (_isMenuOpen) {
      setState(() {
        _isMenuOpen = false;
      });
      Navigator.pop(context);
    }
  }
}

