import 'package:flutter/material.dart';

/// 🌐 App Localizations
/// Çoklu dil desteği için ana sınıf

class AppLocalizations {
  final Locale locale;
  
  AppLocalizations(this.locale);
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  
  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();
  
  static const List<Locale> supportedLocales = [
    Locale('tr', 'TR'), // Türkçe
    Locale('en', 'US'), // İngilizce
    Locale('de', 'DE'), // Almanca
  ];
  
  // 🏠 Ana Sayfa
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get about => _localizedValues[locale.languageCode]!['about']!;
  String get works => _localizedValues[locale.languageCode]!['works']!;
  String get contact => _localizedValues[locale.languageCode]!['contact']!;
  
  // 🎯 Hero Section
  String get heroTitle => _localizedValues[locale.languageCode]!['heroTitle']!;
  String get heroSubtitle => _localizedValues[locale.languageCode]!['heroSubtitle']!;
  String get heroDescription => _localizedValues[locale.languageCode]!['heroDescription']!;
  String get getStarted => _localizedValues[locale.languageCode]!['getStarted']!;
  String get learnMore => _localizedValues[locale.languageCode]!['learnMore']!;
  
  // 👥 Hakkımızda
  String get aboutTitle => _localizedValues[locale.languageCode]!['aboutTitle']!;
  String get aboutDescription => _localizedValues[locale.languageCode]!['aboutDescription']!;
  String get mission => _localizedValues[locale.languageCode]!['mission']!;
  String get vision => _localizedValues[locale.languageCode]!['vision']!;
  String get missionDescription => _localizedValues[locale.languageCode]!['missionDescription']!;
  String get visionDescription => _localizedValues[locale.languageCode]!['visionDescription']!;
  
  // 🎨 Hoş İşler
  String get worksTitle => _localizedValues[locale.languageCode]!['worksTitle']!;
  String get worksDescription => _localizedValues[locale.languageCode]!['worksDescription']!;
  String get viewProject => _localizedValues[locale.languageCode]!['viewProject']!;
  String get allProjects => _localizedValues[locale.languageCode]!['allProjects']!;
  
  // 📞 İletişim
  String get contactTitle => _localizedValues[locale.languageCode]!['contactTitle']!;
  String get contactDescription => _localizedValues[locale.languageCode]!['contactDescription']!;
  String get name => _localizedValues[locale.languageCode]!['name']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get phone => _localizedValues[locale.languageCode]!['phone']!;
  String get message => _localizedValues[locale.languageCode]!['message']!;
  String get sendMessage => _localizedValues[locale.languageCode]!['sendMessage']!;
  String get messageSent => _localizedValues[locale.languageCode]!['messageSent']!;
  
  // 🎯 Projeler
  String get vefa => _localizedValues[locale.languageCode]!['vefa']!;
  String get sefa => _localizedValues[locale.languageCode]!['sefa']!;
  String get sifa => _localizedValues[locale.languageCode]!['sifa']!;
  String get projectDescription => _localizedValues[locale.languageCode]!['projectDescription']!;
  
  // 🏢 Ajans Bilgileri
  String get agencyName => _localizedValues[locale.languageCode]!['agencyName']!;
  String get agencyTagline => _localizedValues[locale.languageCode]!['agencyTagline']!;
  String get agencyDescription => _localizedValues[locale.languageCode]!['agencyDescription']!;
  
  // 📍 Konum
  String get location => _localizedValues[locale.languageCode]!['location']!;
  String get address => _localizedValues[locale.languageCode]!['address']!;
  
  // 🔗 Sosyal Medya
  String get followUs => _localizedValues[locale.languageCode]!['followUs']!;
  String get linkedin => _localizedValues[locale.languageCode]!['linkedin']!;
  String get instagram => _localizedValues[locale.languageCode]!['instagram']!;
  String get twitter => _localizedValues[locale.languageCode]!['twitter']!;
  String get behance => _localizedValues[locale.languageCode]!['behance']!;
  
  // ❌ Hata Mesajları
  String get notFound => _localizedValues[locale.languageCode]!['notFound']!;
  String get errorOccurred => _localizedValues[locale.languageCode]!['errorOccurred']!;
  String get tryAgain => _localizedValues[locale.languageCode]!['tryAgain']!;
  
  // 🎯 Eksik Çeviriler
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get currentLanguage => _localizedValues[locale.languageCode]!['currentLanguage']!;
  String get languageInfo => _localizedValues[locale.languageCode]!['languageInfo']!;
  String get languageInfoDescription => _localizedValues[locale.languageCode]!['languageInfoDescription']!;
  String get whatWeDo => _localizedValues[locale.languageCode]!['whatWeDo']!;
  String get whyWeDo => _localizedValues[locale.languageCode]!['whyWeDo']!;
  String get conferences => _localizedValues[locale.languageCode]!['conferences']!;
  String get contactUs => _localizedValues[locale.languageCode]!['contactUs']!;
  String get send => _localizedValues[locale.languageCode]!['send']!;
  String get socialMedia => _localizedValues[locale.languageCode]!['socialMedia']!;
  String get whoWeAre => _localizedValues[locale.languageCode]!['whoWeAre']!;
  String get ourWorks => _localizedValues[locale.languageCode]!['ourWorks']!;
  String get getInTouch => _localizedValues[locale.languageCode]!['getInTouch']!;
  String get ourMission => _localizedValues[locale.languageCode]!['ourMission']!;
  String get ourVision => _localizedValues[locale.languageCode]!['ourVision']!;
  String get seeAll => _localizedValues[locale.languageCode]!['seeAll']!;
  
  // 📱 Form Mesajları
  String get required => _localizedValues[locale.languageCode]!['required']!;
  String get invalidEmail => _localizedValues[locale.languageCode]!['invalidEmail']!;
  String get invalidPhone => _localizedValues[locale.languageCode]!['invalidPhone']!;
  String get messageTooShort => _localizedValues[locale.languageCode]!['messageTooShort']!;
  String get messageTooLong => _localizedValues[locale.languageCode]!['messageTooLong']!;
  
  // 🎨 Çeviriler
  static final Map<String, Map<String, String>> _localizedValues = {
    'tr': {
      // Ana Sayfa
      'home': 'Ana Sayfa',
      'about': 'Hakkımızda',
      'works': 'Hoş İşler',
      'contact': 'İletişim',
      
      // Hero Section
      'heroTitle': 'Yaratıcı Ajans',
      'heroSubtitle': 'Markanızı Hayata Geçiriyoruz',
      'heroDescription': 'Dijital dünyada fark yaratan çözümlerle markanızı öne çıkarıyoruz.',
      'getStarted': 'Başlayalım',
      'learnMore': 'Daha Fazla Bilgi',
      
      // Hakkımızda
      'aboutTitle': 'Hakkımızda',
      'aboutDescription': 'Yaratıcılık ve teknolojiyi birleştirerek markaların dijital dönüşümüne öncülük ediyoruz.',
      'mission': 'Misyonumuz',
      'vision': 'Vizyonumuz',
      'missionDescription': 'Markaların dijital dünyada güçlü bir varlık oluşturmasına yardımcı olmak.',
      'visionDescription': 'Yaratıcılık ve teknolojinin buluştuğu bir gelecek inşa etmek.',
      
      // Hoş İşler
      'worksTitle': 'Hoş İşler',
      'worksDescription': 'Yaratıcılığımızın en güzel örnekleri.',
      'viewProject': 'Projeyi Gör',
      'allProjects': 'Tüm Projeler',
      
      // İletişim
      'contactTitle': 'İletişim',
      'contactDescription': 'Projeleriniz için bizimle iletişime geçin.',
      'name': 'İsim',
      'email': 'E-posta',
      'phone': 'Telefon',
      'message': 'Mesaj',
      'sendMessage': 'Mesaj Gönder',
      'messageSent': 'Mesajınız başarıyla gönderildi!',
      
      // Projeler
      'vefa': 'Vefa',
      'sefa': 'Sefa',
      'sifa': 'Şifa',
      'projectDescription': 'Yaratıcı çözümlerle markaların dijital dönüşümü.',
      
      // Ajans Bilgileri
      'agencyName': 'Ajans Şebo',
      'agencyTagline': 'Yaratıcı Ajans',
      'agencyDescription': 'Dijital dünyada fark yaratan çözümler.',
      
      // Konum
      'location': 'Konum',
      'address': 'İstanbul, Türkiye',
      
      // Sosyal Medya
      'followUs': 'Bizi Takip Edin',
      'linkedin': 'LinkedIn',
      'instagram': 'Instagram',
      'twitter': 'Twitter',
      'behance': 'Behance',
      
      // Hata Mesajları
      'notFound': 'Sayfa Bulunamadı',
      'errorOccurred': 'Bir hata oluştu',
      'tryAgain': 'Tekrar Deneyin',
      
      // Form Mesajları
      'required': 'Bu alan zorunludur',
      'invalidEmail': 'Geçerli bir e-posta adresi girin',
      'invalidPhone': 'Geçerli bir telefon numarası girin',
      'messageTooShort': 'Mesaj çok kısa',
      'messageTooLong': 'Mesaj çok uzun',
      
      // Eksik Çeviriler
      'language': 'Dil',
      'currentLanguage': 'Mevcut Dil',
      'languageInfo': 'Dil Bilgisi',
      'languageInfoDescription': 'Dil değişikliği uygulamanın tüm metinlerini etkiler. Değişiklik anında uygulanır.',
      'whatWeDo': 'Ne Yapıyoruz',
      'whyWeDo': 'Neden Yapıyoruz',
      'conferences': 'Konferanslar',
      'contactUs': 'İletişime Geçin',
      'send': 'Gönder',
      'socialMedia': 'Sosyal Medya',
      'whoWeAre': 'Biz Kimiz',
      'ourWorks': 'İşlerimiz',
      'getInTouch': 'İletişime Geçin',
      'ourMission': 'Misyonumuz',
      'ourVision': 'Vizyonumuz',
      'seeAll': 'Tümünü Gör',
    },
    'en': {
      // Ana Sayfa
      'home': 'Home',
      'about': 'About',
      'works': 'Works',
      'contact': 'Contact',
      
      // Hero Section
      'heroTitle': 'Creative Agency',
      'heroSubtitle': 'Bringing Your Brand to Life',
      'heroDescription': 'We make your brand stand out with creative solutions in the digital world.',
      'getStarted': 'Get Started',
      'learnMore': 'Learn More',
      
      // Hakkımızda
      'aboutTitle': 'About Us',
      'aboutDescription': 'We lead the digital transformation of brands by combining creativity and technology.',
      'mission': 'Our Mission',
      'vision': 'Our Vision',
      'missionDescription': 'To help brands create a strong presence in the digital world.',
      'visionDescription': 'To build a future where creativity and technology meet.',
      
      // Hoş İşler
      'worksTitle': 'Our Works',
      'worksDescription': 'The finest examples of our creativity.',
      'viewProject': 'View Project',
      'allProjects': 'All Projects',
      
      // İletişim
      'contactTitle': 'Contact',
      'contactDescription': 'Get in touch with us for your projects.',
      'name': 'Name',
      'email': 'Email',
      'phone': 'Phone',
      'message': 'Message',
      'sendMessage': 'Send Message',
      'messageSent': 'Your message has been sent successfully!',
      
      // Projeler
      'vefa': 'Vefa',
      'sefa': 'Sefa',
      'sifa': 'Sifa',
      'projectDescription': 'Digital transformation of brands with creative solutions.',
      
      // Ajans Bilgileri
      'agencyName': 'Sebo Agency',
      'agencyTagline': 'Creative Agency',
      'agencyDescription': 'Creative solutions that make a difference in the digital world.',
      
      // Konum
      'location': 'Location',
      'address': 'Istanbul, Turkey',
      
      // Sosyal Medya
      'followUs': 'Follow Us',
      'linkedin': 'LinkedIn',
      'instagram': 'Instagram',
      'twitter': 'Twitter',
      'behance': 'Behance',
      
      // Hata Mesajları
      'notFound': 'Page Not Found',
      'errorOccurred': 'An error occurred',
      'tryAgain': 'Try Again',
      
      // Form Mesajları
      'required': 'This field is required',
      'invalidEmail': 'Please enter a valid email address',
      'invalidPhone': 'Please enter a valid phone number',
      'messageTooShort': 'Message is too short',
      'messageTooLong': 'Message is too long',
      
      // Eksik Çeviriler
      'language': 'Language',
      'currentLanguage': 'Current Language',
      'languageInfo': 'Language Info',
      'languageInfoDescription': 'Language changes affect all texts in the application. Changes are applied immediately.',
      'whatWeDo': 'What We Do',
      'whyWeDo': 'Why We Do',
      'conferences': 'Conferences',
      'contactUs': 'Contact Us',
      'send': 'Send',
      'socialMedia': 'Social Media',
      'whoWeAre': 'Who We Are',
      'ourWorks': 'Our Works',
      'getInTouch': 'Get In Touch',
      'ourMission': 'Our Mission',
      'ourVision': 'Our Vision',
      'seeAll': 'See All',
    },
    'de': {
      // Ana Sayfa
      'home': 'Startseite',
      'about': 'Über uns',
      'works': 'Arbeiten',
      'contact': 'Kontakt',
      
      // Hero Section
      'heroTitle': 'Kreative Agentur',
      'heroSubtitle': 'Ihre Marke zum Leben erwecken',
      'heroDescription': 'Wir lassen Ihre Marke mit kreativen Lösungen in der digitalen Welt hervorstechen.',
      'getStarted': 'Loslegen',
      'learnMore': 'Mehr erfahren',
      
      // Hakkımızda
      'aboutTitle': 'Über uns',
      'aboutDescription': 'Wir führen die digitale Transformation von Marken durch die Verbindung von Kreativität und Technologie.',
      'mission': 'Unsere Mission',
      'vision': 'Unsere Vision',
      'missionDescription': 'Marken dabei zu helfen, eine starke Präsenz in der digitalen Welt zu schaffen.',
      'visionDescription': 'Eine Zukunft zu schaffen, in der Kreativität und Technologie aufeinandertreffen.',
      
      // Hoş İşler
      'worksTitle': 'Unsere Arbeiten',
      'worksDescription': 'Die besten Beispiele unserer Kreativität.',
      'viewProject': 'Projekt ansehen',
      'allProjects': 'Alle Projekte',
      
      // İletişim
      'contactTitle': 'Kontakt',
      'contactDescription': 'Kontaktieren Sie uns für Ihre Projekte.',
      'name': 'Name',
      'email': 'E-Mail',
      'phone': 'Telefon',
      'message': 'Nachricht',
      'sendMessage': 'Nachricht senden',
      'messageSent': 'Ihre Nachricht wurde erfolgreich gesendet!',
      
      // Projeler
      'vefa': 'Vefa',
      'sefa': 'Sefa',
      'sifa': 'Sifa',
      'projectDescription': 'Digitale Transformation von Marken mit kreativen Lösungen.',
      
      // Ajans Bilgileri
      'agencyName': 'Sebo Agentur',
      'agencyTagline': 'Kreative Agentur',
      'agencyDescription': 'Kreative Lösungen, die in der digitalen Welt einen Unterschied machen.',
      
      // Konum
      'location': 'Standort',
      'address': 'Istanbul, Türkei',
      
      // Sosyal Medya
      'followUs': 'Folgen Sie uns',
      'linkedin': 'LinkedIn',
      'instagram': 'Instagram',
      'twitter': 'Twitter',
      'behance': 'Behance',
      
      // Hata Mesajları
      'notFound': 'Seite nicht gefunden',
      'errorOccurred': 'Ein Fehler ist aufgetreten',
      'tryAgain': 'Erneut versuchen',
      
      // Form Mesajları
      'required': 'Dieses Feld ist erforderlich',
      'invalidEmail': 'Bitte geben Sie eine gültige E-Mail-Adresse ein',
      'invalidPhone': 'Bitte geben Sie eine gültige Telefonnummer ein',
      'messageTooShort': 'Nachricht ist zu kurz',
      'messageTooLong': 'Nachricht ist zu lang',
      
      // Eksik Çeviriler
      'language': 'Sprache',
      'currentLanguage': 'Aktuelle Sprache',
      'languageInfo': 'Sprachinformationen',
      'languageInfoDescription': 'Sprachänderungen betreffen alle Texte in der Anwendung. Änderungen werden sofort angewendet.',
      'whatWeDo': 'Was Wir Tun',
      'whyWeDo': 'Warum Wir Tun',
      'conferences': 'Konferenzen',
      'contactUs': 'Kontaktieren Sie Uns',
      'send': 'Senden',
      'socialMedia': 'Soziale Medien',
      'whoWeAre': 'Wer Wir Sind',
      'ourWorks': 'Unsere Arbeiten',
      'getInTouch': 'Kontakt Aufnehmen',
      'ourMission': 'Unsere Mission',
      'ourVision': 'Unsere Vision',
      'seeAll': 'Alle Anzeigen',
    },
  };
}

/// 🌐 App Localizations Delegate
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any((supportedLocale) =>
        supportedLocale.languageCode == locale.languageCode);
  }
  
  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }
  
  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}