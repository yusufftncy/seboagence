// 🎨 UI Providers - UI provider'ları
// Bu dosya, UI ile ilgili Riverpod provider'larını içerir.
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tema durumu provider'ı
final themeModeProvider = StateProvider<String>((ref) => 'light');

/// Dil durumu provider'ı
final uiLocaleProvider = StateProvider<String>((ref) => 'tr');

/// Yükleme durumu provider'ı
final globalLoadingProvider = StateProvider<bool>((ref) => false);

/// Hata durumu provider'ı
final globalErrorProvider = StateProvider<String?>((ref) => null);

/// Başarı durumu provider'ı
final globalSuccessProvider = StateProvider<String?>((ref) => null);

/// Navigasyon durumu provider'ı
final navigationIndexProvider = StateProvider<int>((ref) => 0);

/// Mobil menü durumu provider'ı
final mobileMenuOpenProvider = StateProvider<bool>((ref) => false);

/// Arama durumu provider'ı
final searchOpenProvider = StateProvider<bool>((ref) => false);

/// Arama sorgusu provider'ı
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Filtre durumu provider'ı
final filterOpenProvider = StateProvider<bool>((ref) => false);

/// Seçili kategori provider'ı
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// Seçili teknoloji provider'ı
final selectedTechnologyProvider = StateProvider<String?>((ref) => null);

/// Sıralama durumu provider'ı
final sortByProvider = StateProvider<String>((ref) => 'date');

/// Sıralama yönü provider'ı
final sortOrderProvider = StateProvider<String>((ref) => 'desc');

/// Sayfa boyutu provider'ı
final pageSizeProvider = StateProvider<int>((ref) => 20);

/// Mevcut sayfa provider'ı
final currentPageProvider = StateProvider<int>((ref) => 1);

/// Toplam sayfa sayısı provider'ı
final totalPagesProvider = StateProvider<int>((ref) => 1);

/// Sayfa yükleme durumu provider'ı
final pageLoadingProvider = StateProvider<bool>((ref) => false);

/// Sayfa yenileme durumu provider'ı
final pageRefreshingProvider = StateProvider<bool>((ref) => false);

/// Sayfa hata durumu provider'ı
final pageErrorProvider = StateProvider<String?>((ref) => null);

/// Sayfa başarı durumu provider'ı
final pageSuccessProvider = StateProvider<String?>((ref) => null);

/// Sayfa bilgi durumu provider'ı
final pageInfoProvider = StateProvider<String?>((ref) => null);

/// Sayfa uyarı durumu provider'ı
final pageWarningProvider = StateProvider<String?>((ref) => null);

/// Sayfa kritik durumu provider'ı
final pageCriticalProvider = StateProvider<String?>((ref) => null);

/// Sayfa debug durumu provider'ı
final pageDebugProvider = StateProvider<String?>((ref) => null);

/// Sayfa trace durumu provider'ı
final pageTraceProvider = StateProvider<String?>((ref) => null);

/// Sayfa verbose durumu provider'ı
final pageVerboseProvider = StateProvider<String?>((ref) => null);

/// Sayfa info durumu provider'ı
final pageInfoStateProvider = StateProvider<String?>((ref) => null);

/// Sayfa warning durumu provider'ı
final pageWarningStateProvider = StateProvider<String?>((ref) => null);

/// Sayfa error durumu provider'ı
final pageErrorStateProvider = StateProvider<String?>((ref) => null);

/// Sayfa critical durumu provider'ı
final pageCriticalStateProvider = StateProvider<String?>((ref) => null);

/// Sayfa debug durumu provider'ı
final pageDebugStateProvider = StateProvider<String?>((ref) => null);

/// Sayfa trace durumu provider'ı
final pageTraceStateProvider = StateProvider<String?>((ref) => null);

/// Sayfa verbose durumu provider'ı
final pageVerboseStateProvider = StateProvider<String?>((ref) => null);
