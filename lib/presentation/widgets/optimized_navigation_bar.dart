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
          height: 80,
          decoration: _buildDecoration(),
          child: _buildContent(),
        );
      },
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
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveValue(
          context,
          mobile: 16.0,
          tablet: 20.0,
          desktop: 24.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildOptimizedLogo(), _buildResponsiveNavigation()],
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
      children: [
        // Scroll indicator
        if (widget.showScrollIndicator) _buildScrollIndicator(),

        const SizedBox(width: 8),

        // Mobile menu button with haptic feedback
        IconButton(
          onPressed: _toggleMobileMenuWithHaptic,
          icon: AnimatedRotation(
            turns: _isMenuOpen ? 0.125 : 0.0,
            duration: _fastAnimation,
            child: const Icon(Icons.menu, color: Branding.white, size: 24),
          ),
        ),
      ],
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
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleNavigationWithHaptic(text),
          borderRadius: BorderRadius.circular(12.0),
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
                  mobile: 6.0, // Çok küçük padding
                  tablet: 8.0, // Çok küçük padding
                  desktop: 10.0, // Çok küçük padding
                ),
                vertical: 8.0, // Çok küçük vertical padding
              ),
              decoration: BoxDecoration(
                gradient: _buildNavItemGradient(isActive),
                borderRadius: BorderRadius.circular(12.0),
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
                      mobile: 10, // Çok küçük icon
                      tablet: 11, // Çok küçük icon
                      desktop: 12, // Çok küçük icon
                    ),
                  ),
                  SizedBox(
                    width: Responsive.responsiveValue(
                      context,
                      mobile: 2, // Çok küçük spacing
                      tablet: 3, // Çok küçük spacing
                      desktop: 4, // Çok küçük spacing
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      fontSize: Responsive.responsiveValue(
                        context,
                        mobile: 10, // Çok küçük font
                        tablet: 11, // Çok küçük font
                        desktop: 12, // Çok küçük font
                      ),
                      letterSpacing: 0.5,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      onOpened: () => HapticFeedback.lightImpact(),
      itemBuilder: (context) => items.cast<PopupMenuEntry<String>>(),
      onSelected: onSelected,
      tooltip: '$title menüsünü aç',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.responsiveValue(
            context,
            mobile: 6, // Çok küçük padding
            tablet: 8, // Çok küçük padding
            desktop: 10, // Çok küçük padding
          ),
          vertical: 8, // Çok küçük vertical padding
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0x0DFFFFFF), Color(0x26FFFFFF)],
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: Responsive.responsiveValue(
                context,
                mobile: 10, // Çok küçük icon
                tablet: 11, // Çok küçük icon
                desktop: 12, // Çok küçük icon
              ),
            ),
            SizedBox(
              width: Responsive.responsiveValue(
                context,
                mobile: 3, // Çok küçük spacing
                tablet: 4, // Çok küçük spacing
                desktop: 5, // Çok küçük spacing
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: Responsive.responsiveValue(
                  context,
                  mobile: 10, // Çok küçük font
                  tablet: 11, // Çok küçük font
                  desktop: 12, // Çok küçük font
                ),
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(
              width: Responsive.responsiveValue(
                context,
                mobile: 3, // Çok küçük spacing
                tablet: 4, // Çok küçük spacing
                desktop: 5, // Çok küçük spacing
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: Responsive.responsiveValue(
                context,
                mobile: 16,
                tablet: 17,
                desktop: 18,
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
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            heightFactor: _scrollAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
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
        decoration: const BoxDecoration(
          color: Color(0xFF131B2E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Menu items
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildMobileMenuItem('Ana Sayfa', Icons.home, false),
                  _buildMobileMenuItem('Hakkımızda', Icons.info, false),
                  _buildMobileMenuItem('Hoş İşler', Icons.work, false),
                  _buildMobileMenuItem('Konferanslar', Icons.event, false),
                  _buildMobileMenuItem('İletişim', Icons.contact_phone, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem(String title, IconData icon, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
            _handleNavigation(title);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 16,
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
