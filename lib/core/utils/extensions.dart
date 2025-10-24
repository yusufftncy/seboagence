import 'package:flutter/material.dart';
import 'responsive.dart';

/// String uzantıları
extension StringExtensions on String {
  /// İlk harfi büyük yap
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
  
  /// Tüm kelimelerin ilk harfini büyük yap
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }
  
  /// Boşlukları kaldır
  String get removeSpaces => replaceAll(' ', '');
  
  /// E-posta formatını kontrol et
  bool get isValidEmail {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(this);
  }
  
  /// URL formatını kontrol et
  bool get isValidUrl {
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return urlRegex.hasMatch(this);
  }
}

/// BuildContext uzantıları
extension BuildContextExtensions on BuildContext {
  /// Responsive helper'ları
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  bool get isLargeDesktop => Responsive.isLargeDesktop(this);
  
  /// Ekran boyutları
  double get screenWidth => Responsive.screenWidth(this);
  double get screenHeight => Responsive.screenHeight(this);
  
  /// Responsive padding
  EdgeInsets get responsivePadding => Responsive.responsivePadding(this);
  
  /// Tema erişimi
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  
  /// MediaQuery erişimi
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  bool get isKeyboardVisible => viewInsets.bottom > 0;
  
  /// Navigator erişimi
  NavigatorState get navigator => Navigator.of(this);
  
  /// Scaffold erişimi
  ScaffoldState? get scaffold => Scaffold.maybeOf(this);
  
  /// Snackbar göster
  void showSnackBar(String message, {Color? backgroundColor, Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }
  
  /// Dialog göster
  Future<T?> showCustomDialog<T>(Widget dialog) {
    return showDialog<T>(
      context: this,
      builder: (context) => dialog,
    );
  }
  
  /// Bottom sheet göster
  Future<T?> showCustomBottomSheet<T>(Widget bottomSheet) {
    return showModalBottomSheet<T>(
      context: this,
      builder: (context) => bottomSheet,
    );
  }
}

/// List uzantıları
extension ListExtensions<T> on List<T> {
  /// Listeyi chunk'lara böl
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }
  
  /// Boş olmayan elemanları filtrele
  List<T> get nonNull => where((element) => element != null).toList();
  
  /// İlk elemanı al, yoksa null döndür
  T? get firstOrNull => isEmpty ? null : first;
  
  /// Son elemanı al, yoksa null döndür
  T? get lastOrNull => isEmpty ? null : last;
}

/// DateTime uzantıları
extension DateTimeExtensions on DateTime {
  /// Sadece tarih kısmını al
  DateTime get dateOnly => DateTime(year, month, day);
  
  /// Sadece saat kısmını al
  DateTime get timeOnly => DateTime(0, 0, 0, hour, minute, second);
  
  /// Türkçe tarih formatı
  String get toTurkishDate {
    const months = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'
    ];
    return '$day ${months[month - 1]} $year';
  }
  
  /// Kısa tarih formatı
  String get toShortDate => '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  
  /// Bugün mü kontrol et
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
  
  /// Dün mü kontrol et
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }
}

/// Color uzantıları
extension ColorExtensions on Color {
  /// Hex string'e çevir
  String get toHex {
    return '#${toARGB32().toRadixString(16).substring(2).toUpperCase()}';
  }
  
  /// Opacity ekle
  Color withOpacity(double opacity) {
    return Color.fromRGBO((r * 255.0).round() & 0xff, (g * 255.0).round() & 0xff, (b * 255.0).round() & 0xff, opacity);
  }
  
  /// Daha açık renk
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
  
  /// Daha koyu renk
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
