import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'locale_providers.dart';
import 'locale_extensions.dart';

/// 🌐 Localization Widgets
/// Dil yönetimi için özel widget'lar

/// 📱 Dil Seçici Widget
class LanguageSelector extends ConsumerWidget {
  final bool showFlags;
  final bool showNativeNames;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  
  const LanguageSelector({
    super.key,
    this.showFlags = true,
    this.showNativeNames = true,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);
    final languageOptions = ref.watch(languageOptionsProvider);
    final localeNotifier = ref.read(localeNotifierProvider.notifier);
    
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: DropdownButton<Locale>(
        value: currentLocale,
        onChanged: (Locale? newLocale) {
          if (newLocale != null) {
            localeNotifier.changeLocale(newLocale);
          }
        },
        underline: const SizedBox.shrink(),
        isExpanded: true,
        items: languageOptions.map((LanguageOption option) {
          return DropdownMenuItem<Locale>(
            value: option.locale,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showFlags) ...[
                  Text(
                    option.flag,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  showNativeNames ? option.nativeName : option.name,
                  style: TextStyle(
                    color: textColor ?? Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// 🎯 Dil Değiştirme Butonu
class LanguageToggleButton extends ConsumerWidget {
  final IconData? icon;
  final String? tooltip;
  final VoidCallback? onChanged;
  
  const LanguageToggleButton({
    super.key,
    this.icon,
    this.tooltip,
    this.onChanged,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);
    final localeNotifier = ref.read(localeNotifierProvider.notifier);
    
    return IconButton(
      icon: Icon(icon ?? Icons.language),
      tooltip: tooltip ?? 'Dil Değiştir',
      onPressed: () {
        _showLanguageDialog(context, ref, currentLocale, localeNotifier);
        onChanged?.call();
      },
    );
  }
  
  void _showLanguageDialog(
    BuildContext context,
    WidgetRef ref,
    Locale currentLocale,
    LocaleNotifier localeNotifier,
  ) {
    final languageOptions = ref.read(languageOptionsProvider);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languageOptions.map((option) {
            final isSelected = option.locale == currentLocale;
            return ListTile(
              leading: Text(option.flag, style: const TextStyle(fontSize: 24)),
              title: Text(option.nativeName),
              subtitle: Text(option.name),
              trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
              onTap: () {
                localeNotifier.changeLocale(option.locale);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// 📝 Dil Göstergesi
class LanguageIndicator extends ConsumerWidget {
  final bool showFlag;
  final bool showName;
  final TextStyle? textStyle;
  
  const LanguageIndicator({
    super.key,
    this.showFlag = true,
    this.showName = true,
    this.textStyle,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showFlag) ...[
          Text(
            currentLocale.flagEmoji,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 8),
        ],
        if (showName)
          Text(
            currentLocale.nativeLanguageName,
            style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }
}

/// 🎯 RTL Desteği Widget
class RTLWrapper extends ConsumerWidget {
  final Widget child;
  final bool forceRTL;
  final bool forceLTR;
  
  const RTLWrapper({
    super.key,
    required this.child,
    this.forceRTL = false,
    this.forceLTR = false,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);
    
    TextDirection textDirection;
    
    if (forceRTL) {
      textDirection = TextDirection.rtl;
    } else if (forceLTR) {
      textDirection = TextDirection.ltr;
    } else {
      textDirection = currentLocale.isRTL ? TextDirection.rtl : TextDirection.ltr;
    }
    
    return Directionality(
      textDirection: textDirection,
      child: child,
    );
  }
}

/// 📱 Dil Ayarları Sayfası
class LanguageSettingsPage extends ConsumerWidget {
  const LanguageSettingsPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);
    final languageOptions = ref.watch(languageOptionsProvider);
    final localeNotifier = ref.read(localeNotifierProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.language),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Mevcut dil
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: Text(context.l10n.currentLanguage),
              subtitle: Text(currentLocale.nativeLanguageName),
              trailing: Text(currentLocale.flagEmoji, style: const TextStyle(fontSize: 24)),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Dil seçenekleri
          ...languageOptions.map((option) {
            final isSelected = option.locale == currentLocale;
            return Card(
              child: ListTile(
                leading: Text(option.flag, style: const TextStyle(fontSize: 24)),
                title: Text(option.nativeName),
                subtitle: Text(option.name),
                trailing: isSelected 
                    ? const Icon(Icons.check, color: Colors.green)
                    : const Icon(Icons.radio_button_unchecked),
                onTap: () {
                  localeNotifier.changeLocale(option.locale);
                },
              ),
            );
          }),
          
          const SizedBox(height: 32),
          
          // Bilgi kartı
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        context.l10n.languageInfo,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.languageInfoDescription,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 🎯 Dil Test Widget
class LanguageTestWidget extends ConsumerWidget {
  const LanguageTestWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dil Test Widget',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            
            // Test metinleri
            _buildTestItem(context, 'Ana Sayfa', context.l10n.home),
            _buildTestItem(context, 'Hakkımızda', context.l10n.about),
            _buildTestItem(context, 'Hoş İşler', context.l10n.works),
            _buildTestItem(context, 'İletişim', context.l10n.contact),
            _buildTestItem(context, 'E-posta', context.l10n.email),
            _buildTestItem(context, 'Telefon', context.l10n.phone),
            _buildTestItem(context, 'Mesaj', context.l10n.message),
            
            const SizedBox(height: 16),
            
            // Dil bilgileri
            Text(
              'Dil Bilgileri:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text('Mevcut Dil: ${context.languageCode}'),
            Text('RTL: ${context.isRTL ? "Evet" : "Hayır"}'),
            Text('Bayrak: ${context.currentLocale.flagEmoji}'),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTestItem(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
