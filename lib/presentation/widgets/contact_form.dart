/// 📧 Contact Form - İletişim formu widget'ı
///
/// Bu widget, iletişim formunu gösterir.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/utils/responsive.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/contact_providers.dart';

class ContactForm extends ConsumerWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(contactFormStateProvider);
    final formNotifier = ref.read(contactFormStateProvider.notifier);

    return Container(
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
            Branding.white.withValues(alpha: 0.05),
            Branding.white.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(Branding.borderRadiusL),
        border: Border.all(
          color: Branding.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Branding.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık
          Text(
            AppConstants.contactFormTitle,
            style: TextStyle(
              color: Branding.white,
              fontSize: Responsive.responsiveValue(
                context,
                mobile: 24.0,
                tablet: 28.0,
                desktop: 32.0,
              ),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: Branding.spacingS),
          Text(
            AppConstants.contactFormSubtitle,
            style: TextStyle(
              color: Branding.white.withValues(alpha: 0.7),
              fontSize: Responsive.responsiveValue(
                context,
                mobile: 14.0,
                tablet: 16.0,
                desktop: 18.0,
              ),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingXL,
              tablet: Branding.spacingXXL,
              desktop: Branding.spacingXXL,
            ),
          ),

          // Form alanları
          _buildTextField(
            context,
            label: 'Ad Soyad *',
            value: formState.name,
            onChanged: (value) => formNotifier.updateField(name: value),
            icon: Icons.person,
          ),
          SizedBox(
            height: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingL,
              tablet: Branding.spacingXL,
              desktop: Branding.spacingXL,
            ),
          ),

          _buildTextField(
            context,
            label: 'E-posta *',
            value: formState.email,
            onChanged: (value) => formNotifier.updateField(email: value),
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingL,
              tablet: Branding.spacingXL,
              desktop: Branding.spacingXL,
            ),
          ),

          _buildTextField(
            context,
            label: 'Telefon *',
            value: formState.phone,
            onChanged: (value) => formNotifier.updateField(phone: value),
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(
            height: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingL,
              tablet: Branding.spacingXL,
              desktop: Branding.spacingXL,
            ),
          ),

          _buildTextField(
            context,
            label: 'Konu *',
            value: formState.subject,
            onChanged: (value) => formNotifier.updateField(subject: value),
            icon: Icons.subject,
          ),
          SizedBox(
            height: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingL,
              tablet: Branding.spacingXL,
              desktop: Branding.spacingXL,
            ),
          ),

          _buildTextField(
            context,
            label: 'Mesaj *',
            value: formState.message,
            onChanged: (value) => formNotifier.updateField(message: value),
            icon: Icons.message,
            maxLines: 4,
          ),
          SizedBox(
            height: Responsive.responsiveValue(
              context,
              mobile: Branding.spacingL,
              tablet: Branding.spacingXL,
              desktop: Branding.spacingXL,
            ),
          ),

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
                      style: TextStyle(
                        color: Branding.error,
                        fontSize: Responsive.responsiveValue(
                          context,
                          mobile: 14.0,
                          tablet: 16.0,
                          desktop: 16.0,
                        ),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
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
                      style: TextStyle(
                        color: Branding.success,
                        fontSize: Responsive.responsiveValue(
                          context,
                          mobile: 14.0,
                          tablet: 16.0,
                          desktop: 16.0,
                        ),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
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
          ],

          // Gönder butonu
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: formState.isLoading
                  ? null
                  : () => formNotifier.submitForm(),
              icon: formState.isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Branding.white,
                        ),
                      ),
                    )
                  : const Icon(Icons.send),
              label: Text(
                formState.isLoading ? 'Gönderiliyor...' : 'Mesaj Gönder',
                style: TextStyle(
                  fontSize: Responsive.responsiveValue(
                    context,
                    mobile: 16.0,
                    tablet: 18.0,
                    desktop: 18.0,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Branding.primary,
                foregroundColor: Branding.white,
                padding: EdgeInsets.symmetric(
                  vertical: Responsive.responsiveValue(
                    context,
                    mobile: Branding.spacingM,
                    tablet: Branding.spacingL,
                    desktop: Branding.spacingL,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Branding.borderRadiusM),
                ),
                elevation: 8,
                shadowColor: Branding.primary.withValues(alpha: 0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
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
          style: TextStyle(
            color: Branding.white.withValues(alpha: 0.9),
            fontSize: Responsive.responsiveValue(
              context,
              mobile: 14.0,
              tablet: 16.0,
              desktop: 16.0,
            ),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: Branding.spacingS),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(
            color: Branding.white,
            fontSize: Responsive.responsiveValue(
              context,
              mobile: 16.0,
              tablet: 18.0,
              desktop: 18.0,
            ),
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Branding.white.withValues(alpha: 0.7),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Branding.borderRadiusM),
              borderSide: BorderSide(
                color: Branding.white.withValues(alpha: 0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Branding.borderRadiusM),
              borderSide: BorderSide(
                color: Branding.white.withValues(alpha: 0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Branding.borderRadiusM),
              borderSide: BorderSide(color: Branding.primary, width: 2),
            ),
            filled: true,
            fillColor: Branding.white.withValues(alpha: 0.05),
            hintStyle: TextStyle(color: Branding.white.withValues(alpha: 0.5)),
          ),
        ),
      ],
    );
  }
}
