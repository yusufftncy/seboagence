/// 💾 Storage Service - Depolama servisi
///
/// Bu servis, yerel depolama işlemlerini yönetir.
library;

import 'dart:convert';

class StorageService {
  // Basit in-memory storage
  final Map<String, String> _storage = {};

  /// JSON verisi kaydet
  Future<void> saveJson(String key, Map<String, dynamic> data) async {
    _storage[key] = jsonEncode(data);
  }

  /// JSON verisi al
  Future<Map<String, dynamic>?> getJson(String key) async {
    final data = _storage[key];
    if (data == null) return null;

    try {
      return jsonDecode(data) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// String veri kaydet
  Future<void> saveString(String key, String value) async {
    _storage[key] = value;
  }

  /// String veri al
  Future<String?> getString(String key) async {
    return _storage[key];
  }

  /// Veri sil
  Future<void> remove(String key) async {
    _storage.remove(key);
  }

  /// Tüm verileri temizle
  Future<void> clear() async {
    _storage.clear();
  }

  /// Anahtar var mı kontrol et
  Future<bool> containsKey(String key) async {
    return _storage.containsKey(key);
  }
}

