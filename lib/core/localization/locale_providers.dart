import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_localizations.dart';

/// 🌐 Locale Providers
/// Dil yönetimi için Riverpod provider'lar

/// 📱 Mevcut dil provider
final currentLocaleProvider = StateProvider<Locale>((ref) => const Locale('tr', 'TR'));

/// 🌐 Desteklenen diller provider
final supportedLocalesProvider = Provider<List<Locale>>((ref) {
  return AppLocalizations.supportedLocales;
});

/// 🎯 Dil değiştirme provider
final localeNotifierProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

/// 📝 Dil değiştirme notifier
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('tr', 'TR'));
  
  /// Dil değiştir
  void changeLocale(Locale locale) {
    state = locale;
  }
  
  /// Türkçe'ye geç
  void setTurkish() {
    state = const Locale('tr', 'TR');
  }
  
  /// İngilizce'ye geç
  void setEnglish() {
    state = const Locale('en', 'US');
  }
  
  /// Almanca'ya geç
  void setGerman() {
    state = const Locale('de', 'DE');
  }
  
  /// Dil koduna göre geç
  void setLocaleByCode(String languageCode) {
    switch (languageCode) {
      case 'tr':
        setTurkish();
        break;
      case 'en':
        setEnglish();
        break;
      case 'de':
        setGerman();
        break;
      default:
        setTurkish(); // Varsayılan olarak Türkçe
    }
  }
}

/// 🎯 Dil tercihi provider
final languagePreferenceProvider = StateNotifierProvider<LanguagePreferenceNotifier, LanguagePreference>((ref) {
  return LanguagePreferenceNotifier();
});

/// 📝 Dil tercihi
class LanguagePreference {
  final Locale currentLocale;
  final bool isAutoDetect;
  final String? savedLanguage;
  
  LanguagePreference({
    required this.currentLocale,
    this.isAutoDetect = false,
    this.savedLanguage,
  });
  
  LanguagePreference copyWith({
    Locale? currentLocale,
    bool? isAutoDetect,
    String? savedLanguage,
  }) {
    return LanguagePreference(
      currentLocale: currentLocale ?? this.currentLocale,
      isAutoDetect: isAutoDetect ?? this.isAutoDetect,
      savedLanguage: savedLanguage ?? this.savedLanguage,
    );
  }
}

/// 📝 Dil tercihi notifier
class LanguagePreferenceNotifier extends StateNotifier<LanguagePreference> {
  LanguagePreferenceNotifier() : super(LanguagePreference(currentLocale: const Locale('tr', 'TR')));
  
  /// Dil tercihini güncelle
  void updatePreference({
    Locale? locale,
    bool? autoDetect,
    String? savedLanguage,
  }) {
    state = state.copyWith(
      currentLocale: locale,
      isAutoDetect: autoDetect,
      savedLanguage: savedLanguage,
    );
  }
  
  /// Otomatik dil tespitini aç/kapat
  void toggleAutoDetect() {
    state = state.copyWith(isAutoDetect: !state.isAutoDetect);
  }
  
  /// Dil tercihini kaydet
  void saveLanguagePreference(String languageCode) {
    state = state.copyWith(savedLanguage: languageCode);
  }
}

/// 🎯 Dil seçenekleri provider
final languageOptionsProvider = Provider<List<LanguageOption>>((ref) {
  return [
    LanguageOption(
      locale: const Locale('tr', 'TR'),
      name: 'Türkçe',
      nativeName: 'Türkçe',
      flag: '🇹🇷',
    ),
    LanguageOption(
      locale: const Locale('en', 'US'),
      name: 'English',
      nativeName: 'English',
      flag: '🇺🇸',
    ),
    LanguageOption(
      locale: const Locale('de', 'DE'),
      name: 'Deutsch',
      nativeName: 'Deutsch',
      flag: '🇩🇪',
    ),
  ];
});

/// 📝 Dil seçeneği
class LanguageOption {
  final Locale locale;
  final String name;
  final String nativeName;
  final String flag;
  
  LanguageOption({
    required this.locale,
    required this.name,
    required this.nativeName,
    required this.flag,
  });
}

/// 🎯 Dil değiştirme widget provider
final languageSelectorProvider = Provider<Widget Function(BuildContext)>((ref) {
  return (context) {
    final currentLocale = ref.watch(localeNotifierProvider);
    final languageOptions = ref.watch(languageOptionsProvider);
    final localeNotifier = ref.read(localeNotifierProvider.notifier);
    
    return DropdownButton<Locale>(
      value: currentLocale,
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          localeNotifier.changeLocale(newLocale);
        }
      },
      items: languageOptions.map((LanguageOption option) {
        return DropdownMenuItem<Locale>(
          value: option.locale,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(option.flag, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(option.nativeName),
            ],
          ),
        );
      }).toList(),
    );
  };
});
