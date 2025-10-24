/// 📧 Contact Page - İletişim sayfası
///
/// Bu sayfa, iletişim formunu gösterir.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';
import '../widgets/contact_form.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Branding.backgroundPrimary,
      appBar: AppBar(
        title: const Text('İletişim'),
        backgroundColor: Branding.primary,
        foregroundColor: Branding.textOnPrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              // Başlık
              Text(
                'İletişim',
                style: AppTypography.h1.copyWith(color: Branding.textPrimary),
              ),
              const SizedBox(height: Branding.spacingS),
              Text(
                'Projeleriniz için bizimle iletişime geçin',
                style: AppTypography.h3.copyWith(color: Branding.textSecondary),
              ),
              const SizedBox(height: Branding.spacingXL),

              // İletişim bilgileri
              _buildContactInfo(context),
              const SizedBox(height: Branding.spacingXL),

              // İletişim formu
              const ContactForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Branding.shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Branding.borderRadiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Branding.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'İletişim Bilgileri',
              style: AppTypography.h4.copyWith(
                color: Branding.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: Branding.spacingL),

            // E-posta
            _buildContactItem(
              icon: Icons.email,
              title: 'E-posta',
              content: 'info@ajanssebo.com',
            ),

            // Telefon
            _buildContactItem(
              icon: Icons.phone,
              title: 'Telefon',
              content: '+90 (212) 123 45 67',
            ),

            // Adres
            _buildContactItem(
              icon: Icons.location_on,
              title: 'Adres',
              content: 'İstanbul, Türkiye',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Branding.spacingM),
      child: Row(
        children: [
          Icon(icon, color: Branding.primary, size: 24),
          const SizedBox(width: Branding.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelMedium.copyWith(
                    color: Branding.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  content,
                  style: AppTypography.bodyLarge.copyWith(
                    color: Branding.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
