import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

/// 💾 Cache Providers
/// Veri önbellekleme için provider'lar

/// 📱 Cache provider
final cacheProvider = StateNotifierProvider<CacheNotifier, CacheState>((ref) {
  return CacheNotifier();
});

/// 💾 Cache state
class CacheState {
  final Map<String, dynamic> cache;
  final bool isInitialized;
  final String? error;
  
  CacheState({
    this.cache = const {},
    this.isInitialized = false,
    this.error,
  });
  
  CacheState copyWith({
    Map<String, dynamic>? cache,
    bool? isInitialized,
    String? error,
  }) {
    return CacheState(
      cache: cache ?? this.cache,
      isInitialized: isInitialized ?? this.isInitialized,
      error: error ?? this.error,
    );
  }
}

/// 💾 Cache notifier
class CacheNotifier extends StateNotifier<CacheState> {
  CacheNotifier() : super(CacheState());
  
  /// Cache'e veri ekle
  void setCache(String key, dynamic value) {
    final newCache = Map<String, dynamic>.from(state.cache);
    newCache[key] = value;
    state = state.copyWith(cache: newCache);
  }
  
  /// Cache'den veri al
  T? getCache<T>(String key) {
    final value = state.cache[key];
    if (value is T) return value;
    return null;
  }
  
  /// Cache'den veri sil
  void removeCache(String key) {
    final newCache = Map<String, dynamic>.from(state.cache);
    newCache.remove(key);
    state = state.copyWith(cache: newCache);
  }
  
  /// Tüm cache'i temizle
  void clearCache() {
    state = state.copyWith(cache: {});
  }
  
  /// Cache'i JSON'a çevir
  String toJson() {
    return jsonEncode(state.cache);
  }
  
  /// JSON'dan cache'i yükle
  void fromJson(String json) {
    try {
      final cache = jsonDecode(json) as Map<String, dynamic>;
      state = state.copyWith(cache: cache);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
