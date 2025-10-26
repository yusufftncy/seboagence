/// 🧭 Optimized Navigation Bar Widget
///
/// Bu widget, tüm sayfalar için optimize edilmiş navigation bar'ı içerir.
library;

import 'package:flutter/material.dart';
import '../../core/theme/branding.dart';
import '../../core/utils/responsive.dart';
import '../../core/services/navigation_service.dart';
import 'optimized_logo.dart';

class OptimizedNavigationBar extends StatefulWidget {
  const OptimizedNavigationBar({super.key});

  @override
  State<OptimizedNavigationBar> createState() => _OptimizedNavigationBarState();
}

class _OptimizedNavigationBarState extends State<OptimizedNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _menuAnimationController;

  late Animation<double> _logoAnimation;
  late Animation<double> _menuAnimation;

  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();

    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _menuAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _menuAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _menuAnimationController, curve: Curves.easeOut),
    );

    // Start animations
    _logoAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _menuAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _menuAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFF131B2E), // Dark blue-grey
        boxShadow: [
          BoxShadow(
            color: Color(0xFF131B2E),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Optimized Logo Section
            _buildOptimizedLogo(context),

            // Responsive Navigation Menu
            Responsive.responsiveWidget(
              context,
              mobile: _buildMobileNavigation(context),
              tablet: _buildDesktopNavigation(context),
              desktop: _buildDesktopNavigation(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptimizedLogo(BuildContext context) {
    return AnimatedBuilder(
      animation: _logoAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (0.2 * _logoAnimation.value),
          child: Opacity(
            opacity: _logoAnimation.value,
            child: const OptimizedLogo(),
          ),
        );
      },
    );
  }

  Widget _buildMobileNavigation(BuildContext context) {
    return Row(
      children: [
        // Mobile Menu Button
        IconButton(
          onPressed: () => _toggleMobileMenu(),
          icon: AnimatedRotation(
            turns: _isMenuOpen ? 0.125 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.menu, color: Branding.white, size: 24),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopNavigation(BuildContext context) {
    return AnimatedBuilder(
      animation: _menuAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _menuAnimation.value,
          child: Row(
            children: [
              _buildOptimizedNavItem('Ana Sayfa', true),
              const SizedBox(width: Branding.spacingL),
              _buildOptimizedNavItem('Hakkımızda', false),
              const SizedBox(width: Branding.spacingL),
              _buildOptimizedDropdownMenu(context),
              const SizedBox(width: Branding.spacingL),
              _buildOptimizedConferencesDropdown(context),
              const SizedBox(width: Branding.spacingL),
              _buildOptimizedNavItem('İletişim', false),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptimizedNavItem(String text, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleNavigation(text),
          borderRadius: BorderRadius.circular(12.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isActive
                    ? [
                        Colors.white.withValues(alpha: 0.15),
                        Colors.white.withValues(alpha: 0.25),
                      ]
                    : [
                        Colors.white.withValues(alpha: 0.05),
                        Colors.white.withValues(alpha: 0.15),
                      ],
              ),
              borderRadius: BorderRadius.circular(12.0),
              border: isActive
                  ? Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1,
                    )
                  : null,
            ),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptimizedDropdownMenu(BuildContext context) {
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
              Colors.white.withValues(alpha: 0.05),
              Colors.white.withValues(alpha: 0.15),
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
          child: _buildOptimizedMenuItem(
            'Vefa Projesi',
            'vefa',
            Icons.favorite,
          ),
        ),
        PopupMenuItem<String>(
          value: 'sefa',
          child: _buildOptimizedMenuItem('Sefa Projesi', 'sefa', Icons.palette),
        ),
        PopupMenuItem<String>(
          value: 'sifa',
          child: _buildOptimizedMenuItem('Şifa Projesi', 'sifa', Icons.healing),
        ),
      ],
      onSelected: (String value) => _handleProjectNavigation(value),
    );
  }

  Widget _buildOptimizedConferencesDropdown(BuildContext context) {
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
              Colors.white.withValues(alpha: 0.05),
              Colors.white.withValues(alpha: 0.15),
            ],
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Konferanslar',
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
          value: 'vefa_bulusma',
          child: _buildOptimizedMenuItem(
            'Vefa Buluşmaları 2025',
            'vefa_bulusma',
            Icons.event,
          ),
        ),
        PopupMenuItem<String>(
          value: 'iklim_konferans',
          child: _buildOptimizedMenuItem(
            'Avrupa İklim Değişikliği Uyum Konferansı',
            'iklim_konferans',
            Icons.eco,
          ),
        ),
        PopupMenuItem<String>(
          value: 'tum_konferanslar',
          child: _buildOptimizedMenuItem(
            'Tüm Konferanslar',
            'tum_konferanslar',
            Icons.list,
          ),
        ),
      ],
      onSelected: (String value) => _handleConferenceNavigation(value),
    );
  }

  Widget _buildOptimizedMenuItem(String title, String value, IconData icon) {
    return Row(
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
    );
  }

  void _toggleMobileMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });

    // Show mobile menu overlay
    if (_isMenuOpen) {
      _showMobileMenuOverlay();
    }
  }

  void _showMobileMenuOverlay() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildMobileMenuOverlay(),
    ).then((_) {
      setState(() {
        _isMenuOpen = false;
      });
    });
  }

  Widget _buildMobileMenuOverlay() {
    return Container(
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
                _buildMobileMenuItem('Ana Sayfa', Icons.home, true),
                _buildMobileMenuItem('Hakkımızda', Icons.info, false),
                _buildMobileMenuItem('Hoş İşler', Icons.work, false),
                _buildMobileMenuItem('Konferanslar', Icons.event, false),
                _buildMobileMenuItem('İletişim', Icons.contact_phone, false),
              ],
            ),
          ),
        ],
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

  void _handleNavigation(String route) {
    // Handle navigation logic
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
    // Handle project navigation
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
    // Handle conference navigation
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
}