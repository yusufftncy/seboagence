// 🎨 Loading Widgets
// Yükleme durumları için widget'lar

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/branding.dart';
import '../../theme/typography.dart';
import 'loading_states.dart';

/// 🎯 Loading Widgets
/// Yükleme durumları için widget'lar

/// 📱 Global Loading Overlay
class GlobalLoadingOverlay extends ConsumerWidget {
  final Widget child;
  final String? message;

  const GlobalLoadingOverlay({
    super.key,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(globalLoadingProvider);

    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Branding.darkGrey.withValues(alpha: 0.5),
            child: Center(
              child: _buildLoadingCard(context, message),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingCard(BuildContext context, String? message) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Branding.radiusL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Branding.spacingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Branding.primaryColor),
            ),
            if (message != null) ...[
              const SizedBox(height: Branding.spacingM),
              Text(
                message,
                style: AppTypography.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 📱 Feature Loading Widget
class FeatureLoadingWidget extends ConsumerWidget {
  final String feature;
  final Widget child;
  final String? message;

  const FeatureLoadingWidget({
    super.key,
    required this.feature,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = _getLoadingState(ref, feature);

    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Branding.white.withValues(alpha: 0.8),
            child: Center(
              child: _buildLoadingIndicator(context, message),
            ),
          ),
      ],
    );
  }

  bool _getLoadingState(WidgetRef ref, String feature) {
    switch (feature) {
      case 'projects':
        return ref.watch(projectsLoadingProvider);
      case 'conferences':
        return ref.watch(conferencesLoadingProvider);
      case 'contact':
        return ref.watch(contactLoadingProvider);
      case 'agency':
        return ref.watch(agencyLoadingProvider);
      default:
        return false;
    }
  }

  Widget _buildLoadingIndicator(BuildContext context, String? message) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Branding.primaryColor),
        ),
        if (message != null) ...[
          const SizedBox(height: Branding.spacingM),
          Text(
            message,
            style: AppTypography.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

/// 📱 Form Loading Widget
class FormLoadingWidget extends ConsumerWidget {
  final String form;
  final Widget child;
  final String? message;

  const FormLoadingWidget({
    super.key,
    required this.form,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = _getFormLoadingState(ref, form);

    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Branding.white.withValues(alpha: 0.9),
            child: Center(
              child: _buildFormLoadingIndicator(context, message),
            ),
          ),
      ],
    );
  }

  bool _getFormLoadingState(WidgetRef ref, String form) {
    switch (form) {
      case 'contact':
        return ref.watch(contactFormLoadingProvider);
      case 'newsletter':
        return ref.watch(newsletterFormLoadingProvider);
      default:
        return false;
    }
  }

  Widget _buildFormLoadingIndicator(BuildContext context, String? message) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Branding.primaryColor),
        ),
        if (message != null) ...[
          const SizedBox(height: Branding.spacingM),
          Text(
            message,
            style: AppTypography.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

/// 📱 Loading Button
class LoadingButton extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  final String? loadingText;
  final String? form;

  const LoadingButton({
    super.key,
    required this.text,
    this.onPressed,
    this.loadingText,
    this.form,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = form != null 
        ? _getFormLoadingState(ref, form!)
        : ref.watch(globalLoadingProvider);

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Branding.white),
                  ),
                ),
                const SizedBox(width: Branding.spacingS),
                Text(loadingText ?? 'Yükleniyor...'),
              ],
            )
          : Text(text),
    );
  }

  bool _getFormLoadingState(WidgetRef ref, String form) {
    switch (form) {
      case 'contact':
        return ref.watch(contactFormLoadingProvider);
      case 'newsletter':
        return ref.watch(newsletterFormLoadingProvider);
      default:
        return false;
    }
  }
}

/// 📱 Loading List Tile
class LoadingListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isLoading;

  const LoadingListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : null,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
    );
  }
}
