// 🎨 App Theme - Uygulama teması
// Bu dosya, uygulama genelinde kullanılan tema ayarlarını içerir.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'branding.dart';
import 'typography.dart';
import '../constants/theme_constants.dart';

class AppTheme {
  /// Açık tema
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      textButtonTheme: _textButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme,
      chipTheme: _chipTheme,
      dividerTheme: _dividerTheme,
      iconTheme: _iconTheme,
      scaffoldBackgroundColor: Branding.backgroundLight,
    );
  }

  /// Koyu tema
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      textButtonTheme: _textButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      cardTheme: _cardTheme,
      chipTheme: _chipTheme,
      dividerTheme: _dividerTheme,
      iconTheme: _iconTheme,
      scaffoldBackgroundColor: Branding.backgroundDark,
    );
  }

  /// Açık renk şeması
  static ColorScheme get _lightColorScheme {
    return const ColorScheme.light(
      primary: Branding.primary,
      secondary: Branding.secondary,
      tertiary: Branding.accentColor,
      surface: Branding.backgroundLight,
      error: Branding.error,
      onPrimary: Branding.textOnPrimary,
      onSecondary: Branding.textOnSecondary,
      onTertiary: Branding.textOnAccent,
      onSurface: Branding.textPrimary,
      onError: Branding.textOnError,
    );
  }

  /// Koyu renk şeması
  static ColorScheme get _darkColorScheme {
    return const ColorScheme.dark(
      primary: Branding.primary,
      secondary: Branding.secondary,
      tertiary: Branding.accentColor,
      surface: Branding.backgroundDark,
      error: Branding.error,
      onPrimary: Branding.textOnPrimary,
      onSecondary: Branding.textOnSecondary,
      onTertiary: Branding.textOnAccent,
      onSurface: Branding.textPrimary,
      onError: Branding.textOnError,
    );
  }

  /// Metin teması
  static TextTheme get _textTheme {
    return GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      displaySmall: AppTypography.displaySmall,
      headlineLarge: AppTypography.headlineLarge,
      headlineMedium: AppTypography.headlineMedium,
      headlineSmall: AppTypography.headlineSmall,
      titleLarge: AppTypography.titleLarge,
      titleMedium: AppTypography.titleMedium,
      titleSmall: AppTypography.titleSmall,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelLarge: AppTypography.labelLarge,
      labelMedium: AppTypography.labelMedium,
      labelSmall: AppTypography.labelSmall,
    );
  }

  /// AppBar teması
  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      backgroundColor: Branding.surfaceLight,
      foregroundColor: Branding.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: AppTypography.h6,
      iconTheme: const IconThemeData(color: Branding.textPrimary, size: 24),
    );
  }

  /// Elevated Button teması
  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Branding.primary,
        foregroundColor: Branding.textOnPrimary,
        elevation: 2,
        shadowColor: Branding.primary.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.radiusM),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeConstants.spacingL,
          vertical: ThemeConstants.spacingM,
        ),
        textStyle: AppTypography.button,
      ),
    );
  }

  /// Text Button teması
  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Branding.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.radiusM),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeConstants.spacingL,
          vertical: ThemeConstants.spacingM,
        ),
        textStyle: AppTypography.button,
      ),
    );
  }

  /// Outlined Button teması
  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Branding.primary,
        side: const BorderSide(color: Branding.primary, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConstants.radiusM),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeConstants.spacingL,
          vertical: ThemeConstants.spacingM,
        ),
        textStyle: AppTypography.button,
      ),
    );
  }

  /// Input Decoration teması
  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: Branding.surfaceLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.radiusM),
        borderSide: const BorderSide(color: Branding.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.radiusM),
        borderSide: const BorderSide(color: Branding.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.radiusM),
        borderSide: const BorderSide(color: Branding.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.radiusM),
        borderSide: const BorderSide(color: Branding.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.radiusM),
        borderSide: const BorderSide(color: Branding.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: ThemeConstants.spacingM,
        vertical: ThemeConstants.spacingM,
      ),
      labelStyle: AppTypography.bodyMedium.copyWith(
        color: Branding.textSecondary,
      ),
      hintStyle: AppTypography.bodyMedium.copyWith(
        color: Branding.textSecondary,
      ),
    );
  }

  /// Card teması
  static CardThemeData get _cardTheme {
    return CardThemeData(
      color: Branding.surfaceLight,
      elevation: 2,
      shadowColor: Branding.shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.radiusL),
      ),
      margin: const EdgeInsets.all(ThemeConstants.spacingS),
    );
  }

  /// Chip teması
  static ChipThemeData get _chipTheme {
    return ChipThemeData(
      backgroundColor: Branding.surfaceLight,
      selectedColor: Branding.primary,
      labelStyle: AppTypography.bodySmall,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ThemeConstants.radiusL),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConstants.spacingM,
        vertical: ThemeConstants.spacingS,
      ),
    );
  }

  /// Divider teması
  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: Branding.borderLight,
      thickness: 1,
      space: 1,
    );
  }

  /// Icon teması
  static IconThemeData get _iconTheme {
    return const IconThemeData(color: Branding.textPrimary, size: 24);
  }
}
