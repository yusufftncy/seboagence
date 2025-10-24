// 🎨 Theme Providers - Tema provider'ları
// Bu dosya, tema ile ilgili Riverpod provider'larını içerir.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Tema modu provider'ı
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

/// Tema provider'ı
final themeProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeModeProvider);

  switch (themeMode) {
    case ThemeMode.light:
      return AppTheme.lightTheme;
    case ThemeMode.dark:
      return AppTheme.darkTheme;
    case ThemeMode.system:
      return AppTheme.lightTheme; // Sistem teması için varsayılan
  }
});

/// Tema değiştirme provider'ı
final themeToggleProvider =
    StateNotifierProvider<ThemeToggleNotifier, ThemeMode>((ref) {
      return ThemeToggleNotifier();
    });

/// Tema değiştirme notifier'ı
class ThemeToggleNotifier extends StateNotifier<ThemeMode> {
  ThemeToggleNotifier() : super(ThemeMode.light);

  /// Tema modunu değiştir
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  /// Açık temaya geç
  void setLightTheme() {
    state = ThemeMode.light;
  }

  /// Koyu temaya geç
  void setDarkTheme() {
    state = ThemeMode.dark;
  }

  /// Sistem temasına geç
  void setSystemTheme() {
    state = ThemeMode.system;
  }
}

/// Tema durumu provider'ı
final themeStateProvider =
    StateNotifierProvider<ThemeStateNotifier, ThemeState>((ref) {
      return ThemeStateNotifier();
    });

/// Tema durumu
class ThemeState {
  final ThemeMode mode;
  final bool isDark;
  final bool isLight;
  final bool isSystem;

  const ThemeState({
    this.mode = ThemeMode.light,
    this.isDark = false,
    this.isLight = true,
    this.isSystem = false,
  });

  ThemeState copyWith({
    ThemeMode? mode,
    bool? isDark,
    bool? isLight,
    bool? isSystem,
  }) {
    return ThemeState(
      mode: mode ?? this.mode,
      isDark: isDark ?? this.isDark,
      isLight: isLight ?? this.isLight,
      isSystem: isSystem ?? this.isSystem,
    );
  }
}

/// Tema durumu notifier'ı
class ThemeStateNotifier extends StateNotifier<ThemeState> {
  ThemeStateNotifier() : super(const ThemeState());

  /// Tema modunu güncelle
  void updateThemeMode(ThemeMode mode) {
    state = state.copyWith(
      mode: mode,
      isDark: mode == ThemeMode.dark,
      isLight: mode == ThemeMode.light,
      isSystem: mode == ThemeMode.system,
    );
  }

  /// Tema durumunu güncelle
  void updateThemeState({
    ThemeMode? mode,
    bool? isDark,
    bool? isLight,
    bool? isSystem,
  }) {
    state = state.copyWith(
      mode: mode,
      isDark: isDark,
      isLight: isLight,
      isSystem: isSystem,
    );
  }
}
