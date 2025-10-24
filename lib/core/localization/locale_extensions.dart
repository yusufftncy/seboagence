import 'package:flutter/material.dart';
import 'app_localizations.dart';

/// 🌐 Localization Extensions
/// Kolay kullanım için extension'lar

/// 📱 BuildContext Extensions
extension LocalizationContextExtension on BuildContext {
  /// AppLocalizations'a erişim
  AppLocalizations get l10n => AppLocalizations.of(this);
  
  /// Mevcut dil
  Locale get currentLocale => Localizations.localeOf(this);
  
  /// Dil kodu
  String get languageCode => currentLocale.languageCode;
  
  /// Türkçe mi?
  bool get isTurkish => languageCode == 'tr';
  
  /// İngilizce mi?
  bool get isEnglish => languageCode == 'en';
  
  /// Almanca mı?
  bool get isGerman => languageCode == 'de';
  
  /// RTL dil mi? (Arapça, İbranice vb.)
  bool get isRTL => currentLocale.languageCode == 'ar' || 
                   currentLocale.languageCode == 'he' ||
                   currentLocale.languageCode == 'fa';
  
  /// LTR dil mi?
  bool get isLTR => !isRTL;
}

/// 🎯 String Extensions
extension LocalizationStringExtension on String {
  /// Çeviri anahtarı mı?
  bool get isTranslationKey => startsWith('l10n.') || startsWith('@');
  
  /// Çeviri anahtarından temizle
  String get cleanTranslationKey {
    if (startsWith('l10n.')) {
      return substring(5);
    }
    if (startsWith('@')) {
      return substring(1);
    }
    return this;
  }
}

/// 📝 Locale Extensions
extension LocaleExtension on Locale {
  /// Dil adı
  String get languageName {
    switch (languageCode) {
      case 'tr':
        return 'Türkçe';
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      case 'fr':
        return 'Français';
      case 'es':
        return 'Español';
      case 'it':
        return 'Italiano';
      case 'pt':
        return 'Português';
      case 'ru':
        return 'Русский';
      case 'ar':
        return 'العربية';
      case 'zh':
        return '中文';
      case 'ja':
        return '日本語';
      case 'ko':
        return '한국어';
      default:
        return languageCode.toUpperCase();
    }
  }
  
  /// Yerel dil adı
  String get nativeLanguageName {
    switch (languageCode) {
      case 'tr':
        return 'Türkçe';
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      case 'fr':
        return 'Français';
      case 'es':
        return 'Español';
      case 'it':
        return 'Italiano';
      case 'pt':
        return 'Português';
      case 'ru':
        return 'Русский';
      case 'ar':
        return 'العربية';
      case 'zh':
        return '中文';
      case 'ja':
        return '日本語';
      case 'ko':
        return '한국어';
      default:
        return languageCode.toUpperCase();
    }
  }
  
  /// Bayrak emoji
  String get flagEmoji {
    switch (languageCode) {
      case 'tr':
        return '🇹🇷';
      case 'en':
        return '🇺🇸';
      case 'de':
        return '🇩🇪';
      case 'fr':
        return '🇫🇷';
      case 'es':
        return '🇪🇸';
      case 'it':
        return '🇮🇹';
      case 'pt':
        return '🇵🇹';
      case 'ru':
        return '🇷🇺';
      case 'ar':
        return '🇸🇦';
      case 'zh':
        return '🇨🇳';
      case 'ja':
        return '🇯🇵';
      case 'ko':
        return '🇰🇷';
      default:
        return '🌐';
    }
  }
  
  /// RTL dil mi?
  bool get isRTL {
    return languageCode == 'ar' || 
           languageCode == 'he' ||
           languageCode == 'fa' ||
           languageCode == 'ur';
  }
  
  /// LTR dil mi?
  bool get isLTR => !isRTL;
}

/// 🎯 Widget Extensions
extension LocalizationWidgetExtension on Widget {
  /// RTL desteği ekle
  Widget withRTLSupport(BuildContext context) {
    return Directionality(
      textDirection: context.isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: this,
    );
  }
  
  /// Dil değişikliği dinleyicisi
  Widget withLocaleListener(VoidCallback onLocaleChanged) {
    return Builder(
      builder: (context) {
        // Locale değişikliğini dinle
        return this;
      },
    );
  }
}

/// 📊 Localization Helper
class LocalizationHelper {
  /// Dil kodu kontrolü
  static bool isValidLanguageCode(String code) {
    return AppLocalizations.supportedLocales.any(
      (locale) => locale.languageCode == code,
    );
  }
  
  /// Varsayılan dil
  static Locale get defaultLocale => const Locale('tr', 'TR');
  
  /// Sistem dilini al
  static Locale getSystemLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }
  
  /// Desteklenen diller
  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;
  
  /// Dil değiştirme
  static void changeLocale(BuildContext context, Locale locale) {
    // Bu fonksiyon provider ile yönetilir
    // LocaleNotifier kullanılmalı
  }
  
  /// Çeviri anahtarı oluştur
  static String createTranslationKey(String key) {
    return 'l10n.$key';
  }
  
  /// Çeviri anahtarından temizle
  static String cleanTranslationKey(String key) {
    if (key.startsWith('l10n.')) {
      return key.substring(5);
    }
    if (key.startsWith('@')) {
      return key.substring(1);
    }
    return key;
  }
}
