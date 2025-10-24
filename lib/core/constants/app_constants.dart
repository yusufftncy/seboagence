/// 📱 App Constants - Uygulama sabitleri
///
/// Bu dosya, uygulama genelinde kullanılan sabit değerleri içerir.
/// ASLA hardcoded değerler kullanma, buradan al!
class AppConstants {
  // Uygulama Bilgileri
  static const String appName = 'Şebo Agency';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Lüks Markaların Türkiye\'deki Stratejik Ortağı';

  // API Sabitleri
  static const String apiBaseUrl = 'https://api.seboagency.com';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;

  // Cache Sabitleri
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 100; // MB

  // UI Sabitleri
  static const double maxContentWidth = 1200.0;
  static const double mobileBreakpoint = 768.0;
  static const double tabletBreakpoint = 1200.0;
  static const double desktopBreakpoint = 1200.0;

  // Animation Sabitleri
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  // Validation Sabitleri
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int maxNameLength = 100;
  static const int maxDescriptionLength = 500;

  // Error Messages
  static const String networkErrorMessage =
      'İnternet bağlantınızı kontrol edin';
  static const String serverErrorMessage =
      'Sunucu hatası oluştu, lütfen tekrar deneyin';
  static const String unknownErrorMessage = 'Bilinmeyen bir hata oluştu';

  // Success Messages
  static const String successMessage = 'İşlem başarıyla tamamlandı';
  static const String saveSuccessMessage = 'Kayıt başarıyla kaydedildi';
  static const String deleteSuccessMessage = 'Kayıt başarıyla silindi';

  // Private constructor - Bu sınıf instantiate edilemez
  AppConstants._();
}
