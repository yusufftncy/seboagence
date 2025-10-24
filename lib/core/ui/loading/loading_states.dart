// 📱 Loading States
// Yükleme durumları için state management

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 🎯 Loading States
/// Tüm yükleme durumları için merkezi yönetim

/// 📊 Global Loading Provider
final globalLoadingProvider = StateProvider<bool>((ref) => false);

/// 📊 Feature Loading Providers
final projectsLoadingProvider = StateProvider<bool>((ref) => false);
final conferencesLoadingProvider = StateProvider<bool>((ref) => false);
final contactLoadingProvider = StateProvider<bool>((ref) => false);
final agencyLoadingProvider = StateProvider<bool>((ref) => false);

/// 📊 Form Loading Providers
final contactFormLoadingProvider = StateProvider<bool>((ref) => false);
final newsletterFormLoadingProvider = StateProvider<bool>((ref) => false);

/// 📊 API Loading Providers
final apiLoadingProvider = StateProvider<bool>((ref) => false);
final imageLoadingProvider = StateProvider<bool>((ref) => false);

/// 📊 Loading State Manager
class LoadingStateManager {
  /// Global loading durumunu değiştir
  static void setGlobalLoading(WidgetRef ref, bool isLoading) {
    ref.read(globalLoadingProvider.notifier).state = isLoading;
  }

  /// Feature loading durumunu değiştir
  static void setFeatureLoading(WidgetRef ref, String feature, bool isLoading) {
    switch (feature) {
      case 'projects':
        ref.read(projectsLoadingProvider.notifier).state = isLoading;
        break;
      case 'conferences':
        ref.read(conferencesLoadingProvider.notifier).state = isLoading;
        break;
      case 'contact':
        ref.read(contactLoadingProvider.notifier).state = isLoading;
        break;
      case 'agency':
        ref.read(agencyLoadingProvider.notifier).state = isLoading;
        break;
    }
  }

  /// Form loading durumunu değiştir
  static void setFormLoading(WidgetRef ref, String form, bool isLoading) {
    switch (form) {
      case 'contact':
        ref.read(contactFormLoadingProvider.notifier).state = isLoading;
        break;
      case 'newsletter':
        ref.read(newsletterFormLoadingProvider.notifier).state = isLoading;
        break;
    }
  }

  /// API loading durumunu değiştir
  static void setApiLoading(WidgetRef ref, bool isLoading) {
    ref.read(apiLoadingProvider.notifier).state = isLoading;
  }

  /// Image loading durumunu değiştir
  static void setImageLoading(WidgetRef ref, bool isLoading) {
    ref.read(imageLoadingProvider.notifier).state = isLoading;
  }

  /// Tüm loading durumlarını sıfırla
  static void resetAllLoading(WidgetRef ref) {
    ref.read(globalLoadingProvider.notifier).state = false;
    ref.read(projectsLoadingProvider.notifier).state = false;
    ref.read(conferencesLoadingProvider.notifier).state = false;
    ref.read(contactLoadingProvider.notifier).state = false;
    ref.read(agencyLoadingProvider.notifier).state = false;
    ref.read(contactFormLoadingProvider.notifier).state = false;
    ref.read(newsletterFormLoadingProvider.notifier).state = false;
    ref.read(apiLoadingProvider.notifier).state = false;
    ref.read(imageLoadingProvider.notifier).state = false;
  }

  /// Herhangi bir loading durumu var mı?
  static bool hasAnyLoading(WidgetRef ref) {
    return ref.read(globalLoadingProvider) ||
           ref.read(projectsLoadingProvider) ||
           ref.read(conferencesLoadingProvider) ||
           ref.read(contactLoadingProvider) ||
           ref.read(agencyLoadingProvider) ||
           ref.read(contactFormLoadingProvider) ||
           ref.read(newsletterFormLoadingProvider) ||
           ref.read(apiLoadingProvider) ||
           ref.read(imageLoadingProvider);
  }
}
