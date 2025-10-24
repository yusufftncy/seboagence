import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cache_manager.dart';

/// 💾 Cache Providers
/// Cache yönetimi için Riverpod provider'lar

/// 📱 Cache Manager Provider
final cacheManagerProvider = Provider<CacheManager>((ref) {
  return CacheManager.instance;
});

/// 📊 Cache Stats Provider
final cacheStatsProvider = FutureProvider<CacheStats>((ref) async {
  final cacheManager = ref.read(cacheManagerProvider);
  return await cacheManager.getStats();
});

/// 🎯 Cache State Provider
final cacheStateProvider = StateNotifierProvider<CacheStateNotifier, CacheState>((ref) {
  return CacheStateNotifier();
});

/// 📝 Cache State
class CacheState {
  final bool isInitialized;
  final bool isLoading;
  final String? error;
  final CacheStats? stats;
  
  CacheState({
    this.isInitialized = false,
    this.isLoading = false,
    this.error,
    this.stats,
  });
  
  CacheState copyWith({
    bool? isInitialized,
    bool? isLoading,
    String? error,
    CacheStats? stats,
  }) {
    return CacheState(
      isInitialized: isInitialized ?? this.isInitialized,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      stats: stats ?? this.stats,
    );
  }
}

/// 📝 Cache State Notifier
class CacheStateNotifier extends StateNotifier<CacheState> {
  CacheStateNotifier() : super(CacheState());
  
  /// Cache'i başlat
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final cacheManager = CacheManager.instance;
      await cacheManager.initialize();
      
      state = state.copyWith(
        isInitialized: true,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
  
  /// Cache istatistiklerini güncelle
  Future<void> updateStats() async {
    try {
      final cacheManager = CacheManager.instance;
      final stats = await cacheManager.getStats();
      
      state = state.copyWith(stats: stats);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
  
  /// Cache'i temizle
  Future<void> clearCache() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final cacheManager = CacheManager.instance;
      await cacheManager.clear();
      
      await updateStats();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
  
  /// Süresi dolmuş cache'leri temizle
  Future<void> clearExpired() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final cacheManager = CacheManager.instance;
      await cacheManager.clearExpired();
      
      await updateStats();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

/// 🎯 Cache Key Provider
final cacheKeyProvider = Provider<CacheKeyManager>((ref) {
  return CacheKeyManager();
});

/// 📝 Cache Key Manager
class CacheKeyManager {
  static const String _prefix = 'sebo_agency_';
  
  // API Cache Keys
  String get projects => '${_prefix}projects';
  String get conferences => '${_prefix}conferences';
  String get agencyInfo => '${_prefix}agency_info';
  String get contactMessages => '${_prefix}contact_messages';
  
  // User Preferences
  String get userPreferences => '${_prefix}user_preferences';
  String get themeMode => '${_prefix}theme_mode';
  String get language => '${_prefix}language';
  
  // App Data
  String get appVersion => '${_prefix}app_version';
  String get lastUpdate => '${_prefix}last_update';
  String get onboardingCompleted => '${_prefix}onboarding_completed';
  
  // Custom key oluştur
  String custom(String key) => '$_prefix$key';
  
  // API endpoint cache key
  String apiEndpoint(String endpoint) => '${_prefix}api$endpoint';
  
  // User specific cache key
  String userSpecific(String key, String userId) => '$_prefix user$userId$key';
}

/// 🎯 Cache Duration Provider
final cacheDurationProvider = Provider<CacheDurationManager>((ref) {
  return CacheDurationManager();
});

/// 📝 Cache Duration Manager
class CacheDurationManager {
  // API Cache Durations
  Duration get projects => const Duration(hours: 24);
  Duration get conferences => const Duration(hours: 12);
  Duration get agencyInfo => const Duration(days: 7);
  Duration get contactMessages => const Duration(hours: 1);
  
  // User Preferences (Kalıcı)
  Duration get userPreferences => const Duration(days: 365);
  Duration get themeMode => const Duration(days: 365);
  Duration get language => const Duration(days: 365);
  
  // App Data
  Duration get appVersion => const Duration(days: 30);
  Duration get lastUpdate => const Duration(hours: 6);
  Duration get onboardingCompleted => const Duration(days: 365);
  
  // Custom duration
  Duration custom(Duration duration) => duration;
  
  // API endpoint duration
  Duration apiEndpoint(String endpoint) {
    switch (endpoint) {
      case '/projects':
        return projects;
      case '/conferences':
        return conferences;
      case '/agency-info':
        return agencyInfo;
      default:
        return const Duration(hours: 1);
    }
  }
}

/// 🎯 Cache Helper Provider
final cacheHelperProvider = Provider<CacheHelper>((ref) {
  return CacheHelper();
});

/// 📝 Cache Helper
class CacheHelper {
  /// Veri kaydet
  Future<void> set<T>(
    String key,
    T value, {
    Duration? duration,
  }) async {
    final cacheManager = CacheManager.instance;
    await cacheManager.set(key, value, duration: duration);
  }
  
  /// Veri al
  Future<T?> get<T>(String key) async {
    final cacheManager = CacheManager.instance;
    return await cacheManager.get<T>(key);
  }
  
  /// Veri var mı?
  Future<bool> has(String key) async {
    final cacheManager = CacheManager.instance;
    return await cacheManager.has(key);
  }
  
  /// Veri sil
  Future<void> remove(String key) async {
    final cacheManager = CacheManager.instance;
    await cacheManager.remove(key);
  }
  
  /// Tüm cache'i temizle
  Future<void> clear() async {
    final cacheManager = CacheManager.instance;
    await cacheManager.clear();
  }
  
  /// Süresi dolmuş cache'leri temizle
  Future<void> clearExpired() async {
    final cacheManager = CacheManager.instance;
    await cacheManager.clearExpired();
  }
  
  /// Cache boyutunu al
  Future<int> getCacheSize() async {
    final cacheManager = CacheManager.instance;
    return await cacheManager.getCacheSize();
  }
  
  /// Cache istatistikleri
  Future<CacheStats> getStats() async {
    final cacheManager = CacheManager.instance;
    return await cacheManager.getStats();
  }
}
