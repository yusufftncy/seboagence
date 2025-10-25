/// 📧 Contact Form - İletişim formu widget'ı
///
/// Bu widget, iletişim formunu gösterir.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';
import '../../core/providers/contact_providers.dart';

class ContactForm extends ConsumerWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(contactFormStateProvider);
    final formNotifier = ref.read(contactFormStateProvider.notifier);

    return Card(
      elevation: 4,
      shadowColor: Branding.shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Branding.borderRadiusL),
      ),
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
              'İletişim Formu',
              style: AppTypography.h3.copyWith(
                color: Branding.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: Branding.spacingS),
            Text(
              'Projeleriniz için bizimle iletişime geçin',
              style: AppTypography.bodyMedium.copyWith(
                color: Branding.textSecondary,
              ),
            ),
            const SizedBox(height: Branding.spacingXL),

            // Form alanları
            _buildTextField(
              label: 'Ad Soyad *',
              value: formState.name,
              onChanged: (value) => formNotifier.updateField(name: value),
              icon: Icons.person,
            ),
            const SizedBox(height: Branding.spacingL),

            _buildTextField(
              label: 'E-posta *',
              value: formState.email,
              onChanged: (value) => formNotifier.updateField(email: value),
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: Branding.spacingL),

            _buildTextField(
              label: 'Telefon *',
              value: formState.phone,
              onChanged: (value) => formNotifier.updateField(phone: value),
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: Branding.spacingL),

            _buildTextField(
              label: 'Konu *',
              value: formState.subject,
              onChanged: (value) => formNotifier.updateField(subject: value),
              icon: Icons.subject,
            ),
            const SizedBox(height: Branding.spacingL),

            _buildTextField(
              label: 'Mesaj *',
              value: formState.message,
              onChanged: (value) => formNotifier.updateField(message: value),
              icon: Icons.message,
              maxLines: 4,
            ),
            const SizedBox(height: Branding.spacingL),

            // Hata mesajı
            if (formState.errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(Branding.spacingM),
                decoration: BoxDecoration(
                  color: Branding.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Branding.borderRadiusM),
                  border: Border.all(
                    color: Branding.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Branding.error, size: 20),
                    const SizedBox(width: Branding.spacingS),
                    Expanded(
                      child: Text(
                        formState.errorMessage!,
                        style: AppTypography.bodySmall.copyWith(
                          color: Branding.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Branding.spacingL),
            ],

            // Başarı mesajı
            if (formState.isSuccess) ...[
              Container(
                padding: const EdgeInsets.all(Branding.spacingM),
                decoration: BoxDecoration(
                  color: Branding.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Branding.borderRadiusM),
                  border: Border.all(
                    color: Branding.success.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Branding.success, size: 20),
                    const SizedBox(width: Branding.spacingS),
                    Expanded(
                      child: Text(
                        'Mesajınız başarıyla gönderildi!',
                        style: AppTypography.bodySmall.copyWith(
                          color: Branding.success,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Branding.spacingL),
            ],

            // Gönder butonu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: formState.isLoading
                    ? null
                    : () => formNotifier.submitForm(),
                icon: formState.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  formState.isLoading ? 'Gönderiliyor...' : 'Mesaj Gönder',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFFB8B8B8,
                  ), // rgba(184, 184, 184)
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: Branding.spacingM,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: Branding.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: Branding.spacingS),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Branding.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Branding.borderRadiusM),
              borderSide: BorderSide(color: Branding.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Branding.borderRadiusM),
              borderSide: BorderSide(color: Branding.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Branding.borderRadiusM),
              borderSide: BorderSide(color: Branding.primary, width: 2),
            ),
            filled: true,
            fillColor: Branding.surfaceLight,
          ),
        ),
      ],
    );
  }
}
