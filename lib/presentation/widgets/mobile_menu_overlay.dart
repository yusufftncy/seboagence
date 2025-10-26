/// 📱 Mobile Menu Overlay Widget
///
/// Mobile cihazlar için optimize edilmiş menu overlay widget'ı
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/branding.dart';
import '../../core/services/navigation_service.dart';

class MobileMenuOverlay extends StatefulWidget {
  const MobileMenuOverlay({super.key});

  @override
  State<MobileMenuOverlay> createState() => _MobileMenuOverlayState();
}

class _MobileMenuOverlayState extends State<MobileMenuOverlay>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF131B2E),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHandleBar(),
            _buildHeader(),
            _buildDivider(),
            _buildMenuItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x4DFFFFFF), Color(0x80FFFFFF)],
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0x1AFFFFFF), Color(0x33FFFFFF)],
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.menu,
              color: Branding.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Menü',
            style: TextStyle(
              color: Branding.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.white.withValues(alpha: 0.2),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildMenuItem('Ana Sayfa', Icons.home, () => _navigateToHome()),
          _buildMenuItem('Hakkımızda', Icons.info, () => _navigateToAbout()),
          _buildMenuItem('Hoş İşler', Icons.work, () => _navigateToWorks()),
          _buildMenuItem('Konferanslar', Icons.event, () => _navigateToConferences()),
          _buildMenuItem('İletişim', Icons.contact_phone, () => _navigateToContact()),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
            onTap();
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0x0DFFFFFF), Color(0x26FFFFFF)],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(icon, color: Branding.white, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Branding.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToHome() {
    NavigationService.goToHome();
  }

  void _navigateToAbout() {
    NavigationService.goToAbout();
  }

  void _navigateToWorks() {
    // TODO: Implement works navigation
  }

  void _navigateToConferences() {
    // TODO: Implement conferences navigation
  }

  void _navigateToContact() {
    NavigationService.goToContact();
  }
}
