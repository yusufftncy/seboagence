import 'dart:convert';
import 'dart:io';

/// 💾 Cache Manager
/// Önbellek yönetimi için ana sınıf

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();
  
  static CacheManager get instance => _instance;
  
  // Memory cache
  final Map<String, CacheItem> _memoryCache = {};
  
  // Cache directory
  Directory? _cacheDirectory;
  
  /// Cache'i başlat
  Future<void> initialize() async {
    _cacheDirectory = Directory('cache');
    await _createCacheDirectory();
  }
  
  /// Cache dizini oluştur
  Future<void> _createCacheDirectory() async {
    if (_cacheDirectory != null) {
      final cacheDir = Directory('${_cacheDirectory!.path}/sebo_agency_cache');
      if (!await cacheDir.exists()) {
        await cacheDir.create(recursive: true);
      }
    }
  }
  
  /// Veri kaydet
  Future<void> set(String key, dynamic value, {Duration? duration}) async {
    final cacheItem = CacheItem(
      data: value,
      timestamp: DateTime.now(),
      duration: duration ?? const Duration(hours: 24),
    );
    
    // Memory cache'e kaydet
    _memoryCache[key] = cacheItem;
    
    // Disk cache'e kaydet
    await _saveToDisk(key, cacheItem);
  }
  
  /// Veri al
  Future<T?> get<T>(String key) async {
    // Önce memory cache'den kontrol et
    if (_memoryCache.containsKey(key)) {
      final item = _memoryCache[key]!;
      if (!item.isExpired) {
        return item.data as T?;
      } else {
        _memoryCache.remove(key);
      }
    }
    
    // Disk cache'den kontrol et
    final diskItem = await _loadFromDisk(key);
    if (diskItem != null && !diskItem.isExpired) {
      // Memory cache'e geri yükle
      _memoryCache[key] = diskItem;
      return diskItem.data as T?;
    }
    
    return null;
  }
  
  /// Veri var mı?
  Future<bool> has(String key) async {
    final value = await get(key);
    return value != null;
  }
  
  /// Veri sil
  Future<void> remove(String key) async {
    _memoryCache.remove(key);
    await _removeFromDisk(key);
  }
  
  /// Tüm cache'i temizle
  Future<void> clear() async {
    _memoryCache.clear();
    if (_cacheDirectory != null) {
      final cacheDir = Directory('${_cacheDirectory!.path}/sebo_agency_cache');
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
        await cacheDir.create();
      }
    }
  }
  
  /// Süresi dolmuş cache'leri temizle
  Future<void> clearExpired() async {
    // final now = DateTime.now(); // Unused variable removed
    
    // Memory cache'den süresi dolmuş olanları sil
    _memoryCache.removeWhere((key, item) => item.isExpired);
    
    // Disk cache'den süresi dolmuş olanları sil
    if (_cacheDirectory != null) {
      final cacheDir = Directory('${_cacheDirectory!.path}/sebo_agency_cache');
      if (await cacheDir.exists()) {
        final files = await cacheDir.list().toList();
        for (final file in files.whereType<File>()) {
          final item = await _loadFromDisk(file.path.split('/').last);
          if (item != null && item.isExpired) {
            await file.delete();
          }
        }
      }
    }
  }
  
  /// Cache boyutunu al
  Future<int> getCacheSize() async {
    int totalSize = 0;
    
    if (_cacheDirectory != null) {
      final cacheDir = Directory('${_cacheDirectory!.path}/sebo_agency_cache');
      if (await cacheDir.exists()) {
        final files = await cacheDir.list().toList();
        for (final file in files.whereType<File>()) {
          totalSize += await file.length();
        }
      }
    }
    
    return totalSize;
  }
  
  /// Cache istatistikleri
  Future<CacheStats> getStats() async {
    final memoryCount = _memoryCache.length;
    final diskCount = await _getDiskCacheCount();
    final totalSize = await getCacheSize();
    
    return CacheStats(
      memoryItemCount: memoryCount,
      diskItemCount: diskCount,
      totalSizeBytes: totalSize,
    );
  }
  
  /// Disk cache'den yükle
  Future<CacheItem?> _loadFromDisk(String key) async {
    if (_cacheDirectory == null) return null;
    
    try {
      final file = File('${_cacheDirectory!.path}/sebo_agency_cache/$key.json');
      if (await file.exists()) {
        final content = await file.readAsString();
        final json = jsonDecode(content);
        return CacheItem.fromJson(json);
      }
    } catch (e) {
      // Hata durumunda null döndür
    }
    
    return null;
  }
  
  /// Disk cache'e kaydet
  Future<void> _saveToDisk(String key, CacheItem item) async {
    if (_cacheDirectory == null) return;
    
    try {
      final file = File('${_cacheDirectory!.path}/sebo_agency_cache/$key.json');
      final json = item.toJson();
      await file.writeAsString(jsonEncode(json));
    } catch (e) {
      // Hata durumunda sessizce geç
    }
  }
  
  /// Disk cache'den sil
  Future<void> _removeFromDisk(String key) async {
    if (_cacheDirectory == null) return;
    
    try {
      final file = File('${_cacheDirectory!.path}/sebo_agency_cache/$key.json');
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Hata durumunda sessizce geç
    }
  }
  
  /// Disk cache item sayısı
  Future<int> _getDiskCacheCount() async {
    if (_cacheDirectory == null) return 0;
    
    try {
      final cacheDir = Directory('${_cacheDirectory!.path}/sebo_agency_cache');
      if (await cacheDir.exists()) {
        final files = await cacheDir.list().toList();
        return files.whereType<File>().length;
      }
    } catch (e) {
      // Hata durumunda 0 döndür
    }
    
    return 0;
  }
}

/// 📝 Cache Item
class CacheItem {
  final dynamic data;
  final DateTime timestamp;
  final Duration duration;
  
  CacheItem({
    required this.data,
    required this.timestamp,
    required this.duration,
  });
  
  /// Süresi dolmuş mu?
  bool get isExpired {
    return DateTime.now().difference(timestamp) > duration;
  }
  
  /// JSON'a çevir
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'timestamp': timestamp.toIso8601String(),
      'duration': duration.inMilliseconds,
    };
  }
  
  /// JSON'dan oluştur
  factory CacheItem.fromJson(Map<String, dynamic> json) {
    return CacheItem(
      data: json['data'],
      timestamp: DateTime.parse(json['timestamp']),
      duration: Duration(milliseconds: json['duration']),
    );
  }
}

/// 📊 Cache Stats
class CacheStats {
  final int memoryItemCount;
  final int diskItemCount;
  final int totalSizeBytes;
  
  CacheStats({
    required this.memoryItemCount,
    required this.diskItemCount,
    required this.totalSizeBytes,
  });
  
  /// Toplam item sayısı
  int get totalItemCount => memoryItemCount + diskItemCount;
  
  /// Toplam boyut (MB)
  double get totalSizeMB => totalSizeBytes / (1024 * 1024);
  
  /// Toplam boyut (KB)
  double get totalSizeKB => totalSizeBytes / 1024;
  
  /// İnsan okunabilir boyut
  String get humanReadableSize {
    if (totalSizeBytes < 1024) {
      return '$totalSizeBytes B';
    } else if (totalSizeBytes < 1024 * 1024) {
      return '${totalSizeKB.toStringAsFixed(1)} KB';
    } else {
      return '${totalSizeMB.toStringAsFixed(1)} MB';
    }
  }
}
