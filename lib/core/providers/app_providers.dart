import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 🎯 Ana uygulama providers
/// Tüm global state'ler burada tanımlanır

/// 📱 Tema provider
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

/// 🌐 Dil provider  
final localeProvider = StateProvider<Locale>((ref) => const Locale('tr', 'TR'));

/// 📊 Loading state provider
final loadingProvider = StateProvider<bool>((ref) => false);

/// 🎨 Responsive provider
final responsiveProvider = Provider<ResponsiveInfo>((ref) {
  // Bu provider responsive bilgileri sağlar
  return ResponsiveInfo();
});

/// 📱 Responsive bilgi sınıfı
class ResponsiveInfo {
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;
  final bool isLargeDesktop;
  
  ResponsiveInfo({
    this.isMobile = false,
    this.isTablet = false,
    this.isDesktop = false,
    this.isLargeDesktop = false,
  });
}
