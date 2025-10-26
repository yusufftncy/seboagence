/// 📧 Contact Page - Ultra-Optimized İletişim sayfası
///
/// Bu sayfa, maksimum performans ve kullanıcı deneyimi için optimize edilmiş iletişim bilgilerini gösterir.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/branding.dart';
import '../../core/utils/responsive.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/optimized_navigation_bar.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF131B2E),
      body: Column(
        children: [
          const OptimizedNavigationBar(),
          Expanded(child: _ContactPageContent()),
        ],
      ),
    );
  }
}

/// Optimized Contact Page Content
///
/// Bu widget, performans için ayrılmış ve optimize edilmiş içerik widget'ıdır.
class _ContactPageContent extends StatelessWidget {
  const _ContactPageContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _HeroSection(),
          _ContactCardsSection(),
          _SocialMediaSection(),
          _MapSection(),
          _FooterSection(),
        ],
      ),
    );
  }
}

/// Hero Section - Optimized
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
      decoration: const BoxDecoration(color: Color(0xFF131B2E)),
      child: Column(
        children: [
          Text(
            AppConstants.contactPageTitle,
            style: TextStyle(
              color: Branding.white,
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
          Text(
            AppConstants.contactPageSubtitle,
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.9),
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
          _ContactSummary(),
        ],
      ),
    );
  }
}

/// Contact Summary - Optimized
class _ContactSummary extends StatelessWidget {
  const _ContactSummary();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.all(
        isMobile ? Branding.spacingL : Branding.spacingXL,
      ),
      decoration: BoxDecoration(
        color: Branding.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Branding.borderRadiusL),
        border: Border.all(
          color: Branding.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _SummaryItem(
            icon: Icons.email,
            title: 'E-posta',
            content: AppConstants.companyEmail,
            color: Branding.primary,
            isMobile: isMobile,
          ),
          _SummaryItem(
            icon: Icons.phone,
            title: 'Telefon',
            content: AppConstants.companyPhone,
            color: Branding.secondary,
            isMobile: isMobile,
          ),
          _SummaryItem(
            icon: Icons.location_on,
            title: 'Adres',
            content: AppConstants.companyAddress,
            color: Branding.secondary,
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }
}

/// Summary Item - Optimized
class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.icon,
    required this.title,
    required this.content,
    required this.color,
    required this.isMobile,
  });

  final IconData icon;
  final String title;
  final String content;
  final Color color;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(
            isMobile ? Branding.spacingM : Branding.spacingL,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(Branding.borderRadiusM),
          ),
          child: Icon(icon, color: color, size: isMobile ? 24.0 : 32.0),
        ),
        SizedBox(height: Branding.spacingS),
        Text(
          title,
          style: TextStyle(
            color: Branding.white.withValues(alpha: 0.8),
            fontSize: isMobile ? 12.0 : 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: Branding.spacingXS),
        Text(
          content,
          style: TextStyle(
            color: Branding.white,
            fontSize: isMobile ? 11.0 : 13.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Contact Cards Section - Optimized
class _ContactCardsSection extends StatelessWidget {
  const _ContactCardsSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Padding(
      padding: EdgeInsets.all(
        isMobile ? Branding.spacingL : Branding.spacingXXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppConstants.contactInfoTitle,
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile
                  ? 28.0
                  : isTablet
                  ? 32.0
                  : 36.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            AppConstants.contactInfoSubtitle,
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.7),
              fontSize: isMobile ? 16.0 : 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: isMobile ? Branding.spacingXL : Branding.spacingXXL),
          _ContactCardsGrid(),
        ],
      ),
    );
  }
}

/// Contact Cards Grid - Optimized
class _ContactCardsGrid extends StatelessWidget {
  const _ContactCardsGrid();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    if (isMobile) {
      return const _MobileContactCards();
    } else if (isTablet) {
      return const _TabletContactCards();
    } else {
      return const _DesktopContactCards();
    }
  }
}

/// Mobile Contact Cards - Optimized
class _MobileContactCards extends StatelessWidget {
  const _MobileContactCards();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ContactCard(
          title: 'E-posta Adresimiz',
          content: AppConstants.companyEmail,
          description: 'Projeleriniz için bizimle iletişime geçin',
          icon: Icons.email,
          color: Branding.primary,
          actionText: 'E-posta Gönder',
          onTap: _launchEmail,
        ),
        SizedBox(height: Branding.spacingL),
        _ContactCard(
          title: 'Telefon Numaramız',
          content: AppConstants.companyPhone,
          description: 'Hemen arayın, size yardımcı olalım',
          icon: Icons.phone,
          color: Branding.secondary,
          actionText: 'Hemen Ara',
          onTap: _launchPhone,
        ),
        SizedBox(height: Branding.spacingL),
        _ContactCard(
          title: 'Ofis Adresimiz',
          content: AppConstants.companyAddress,
          description: 'Ofisimizi ziyaret edebilirsiniz',
          icon: Icons.location_on,
          color: Branding.secondary,
          actionText: 'Haritada Gör',
          onTap: _launchMap,
        ),
      ],
    );
  }
}

/// Tablet Contact Cards - Optimized
class _TabletContactCards extends StatelessWidget {
  const _TabletContactCards();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _ContactCard(
                title: 'E-posta Adresimiz',
                content: AppConstants.companyEmail,
                description: 'Projeleriniz için bizimle iletişime geçin',
                icon: Icons.email,
                color: Branding.primary,
                actionText: 'E-posta Gönder',
                onTap: _launchEmail,
              ),
            ),
            SizedBox(width: Branding.spacingL),
            Expanded(
              child: _ContactCard(
                title: 'Telefon Numaramız',
                content: AppConstants.companyPhone,
                description: 'Hemen arayın, size yardımcı olalım',
                icon: Icons.phone,
                color: Branding.secondary,
                actionText: 'Hemen Ara',
                onTap: _launchPhone,
              ),
            ),
          ],
        ),
        SizedBox(height: Branding.spacingL),
        _ContactCard(
          title: 'Ofis Adresimiz',
          content: AppConstants.companyAddress,
          description: 'Ofisimizi ziyaret edebilirsiniz',
          icon: Icons.location_on,
          color: Branding.secondary,
          actionText: 'Haritada Gör',
          onTap: _launchMap,
        ),
      ],
    );
  }
}

/// Desktop Contact Cards - Optimized
class _DesktopContactCards extends StatelessWidget {
  const _DesktopContactCards();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ContactCard(
            title: 'E-posta Adresimiz',
            content: AppConstants.companyEmail,
            description: 'Projeleriniz için bizimle iletişime geçin',
            icon: Icons.email,
            color: Branding.primary,
            actionText: 'E-posta Gönder',
            onTap: _launchEmail,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _ContactCard(
            title: 'Telefon Numaramız',
            content: AppConstants.companyPhone,
            description: 'Hemen arayın, size yardımcı olalım',
            icon: Icons.phone,
            color: Branding.secondary,
            actionText: 'Hemen Ara',
            onTap: _launchPhone,
          ),
        ),
        SizedBox(width: Branding.spacingL),
        Expanded(
          child: _ContactCard(
            title: 'Ofis Adresimiz',
            content: AppConstants.companyAddress,
            description: 'Ofisimizi ziyaret edebilirsiniz',
            icon: Icons.location_on,
            color: Branding.secondary,
            actionText: 'Haritada Gör',
            onTap: _launchMap,
          ),
        ),
      ],
    );
  }
}

/// Contact Card - Ultra-Optimized
class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.title,
    required this.content,
    required this.description,
    required this.icon,
    required this.color,
    required this.actionText,
    required this.onTap,
  });

  final String title;
  final String content;
  final String description;
  final IconData icon;
  final Color color;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Branding.spacingXL),
      decoration: BoxDecoration(
        color: Branding.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Branding.borderRadiusL),
        border: Border.all(
          color: Branding.white.withValues(alpha: 0.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Branding.white.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(Branding.spacingM),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(Branding.borderRadiusM),
                ),
                child: Icon(icon, color: color, size: 28.0),
              ),
              SizedBox(width: Branding.spacingM),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Branding.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Branding.spacingL),
          Text(
            content,
            style: const TextStyle(
              color: Branding.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            description,
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.7),
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              height: 1.4,
            ),
          ),
          SizedBox(height: Branding.spacingXL),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_forward, size: 18.0),
              label: Text(actionText),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Branding.white,
                padding: EdgeInsets.symmetric(
                  vertical: Branding.spacingM,
                  horizontal: Branding.spacingL,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Branding.borderRadiusM),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Social Media Section - Optimized
class _SocialMediaSection extends StatelessWidget {
  const _SocialMediaSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? Branding.spacingL : Branding.spacingXXL,
      ),
      decoration: BoxDecoration(color: Branding.white.withValues(alpha: 0.08)),
      child: Column(
        children: [
          Text(
            'Sosyal Medyada Takip Edin',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 24.0 : 28.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Güncel projelerimizi ve haberlerimizi takip edin',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.7),
              fontSize: isMobile ? 14.0 : 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: Branding.spacingXL),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SocialButton(
                icon: Icons.link,
                title: 'Website',
                url: AppConstants.companyWebsite,
                color: Branding.primary,
              ),
              SizedBox(width: Branding.spacingL),
              _SocialButton(
                icon: Icons.business,
                title: 'LinkedIn',
                url: AppConstants.companyLinkedIn,
                color: Branding.secondary,
              ),
              SizedBox(width: Branding.spacingL),
              _SocialButton(
                icon: Icons.camera_alt,
                title: 'Instagram',
                url: AppConstants.companyInstagram,
                color: Branding.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Social Button - Optimized
class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.title,
    required this.url,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String url;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Branding.spacingL),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Branding.borderRadiusM),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32.0),
          SizedBox(height: Branding.spacingS),
          Text(
            title,
            style: const TextStyle(
              color: Branding.white,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Map Section - Optimized
class _MapSection extends StatelessWidget {
  const _MapSection();

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
            'Konumumuz',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 24.0 : 28.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: Branding.spacingL),
          Container(
            height: isMobile ? 200.0 : 300.0,
            decoration: BoxDecoration(
              color: Branding.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Branding.borderRadiusL),
              border: Border.all(
                color: Branding.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    color: Branding.white.withValues(alpha: 0.5),
                    size: 48.0,
                  ),
                  SizedBox(height: Branding.spacingM),
                  Text(
                    'Harita Yükleniyor...',
                    style: TextStyle(
                      color: Branding.white.withValues(alpha: 0.7),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Footer Section - Optimized
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        isMobile ? Branding.spacingL : Branding.spacingXXL,
      ),
      decoration: const BoxDecoration(color: Color(0xFF1A237E)),
      child: Column(
        children: [
          Text(
            'İletişime Geçin',
            style: TextStyle(
              color: Branding.white,
              fontSize: isMobile ? 20.0 : 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: Branding.spacingS),
          Text(
            'Projeleriniz için bizimle iletişime geçmekten çekinmeyin',
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.8),
              fontSize: isMobile ? 14.0 : 16.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Branding.spacingXL),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _launchEmail,
                icon: const Icon(Icons.email),
                label: const Text('E-posta Gönder'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Branding.primary,
                  foregroundColor: Branding.white,
                  padding: EdgeInsets.symmetric(
                    vertical: Branding.spacingM,
                    horizontal: Branding.spacingL,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Branding.borderRadiusM),
                  ),
                ),
              ),
              SizedBox(width: Branding.spacingL),
              ElevatedButton.icon(
                onPressed: _launchPhone,
                icon: const Icon(Icons.phone),
                label: const Text('Hemen Ara'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Branding.secondary,
                  foregroundColor: Branding.white,
                  padding: EdgeInsets.symmetric(
                    vertical: Branding.spacingM,
                    horizontal: Branding.spacingL,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Branding.borderRadiusM),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Utility Functions - Optimized
void _launchEmail() async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: AppConstants.companyEmail,
    query: 'subject=İletişim&body=Merhaba,',
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  }
}

void _launchPhone() async {
  final Uri phoneUri = Uri(scheme: 'tel', path: AppConstants.companyPhone);

  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  }
}

void _launchMap() async {
  final Uri mapUri = Uri.parse(AppConstants.companyAddress);

  if (await canLaunchUrl(mapUri)) {
    await launchUrl(mapUri);
  }
}
