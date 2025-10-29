import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Firebase servislerini yöneten sınıf
class FirebaseService {
  static FirebaseService? _instance;
  static FirebaseService get instance => _instance ??= FirebaseService._();

  FirebaseService._();

  // Firebase servisleri
  FirebaseAnalytics? _analytics;
  FirebaseFirestore? _firestore;

  // Getters
  FirebaseAnalytics get analytics => _analytics!;
  FirebaseFirestore get firestore => _firestore!;

  /// Firebase'i başlat
  Future<void> initialize() async {
    try {
      // Firebase Core'u başlat
      await Firebase.initializeApp();

      // Servisleri başlat (sadece Analytics ve Firestore)
      _analytics = FirebaseAnalytics.instance;
      _firestore = FirebaseFirestore.instance;

      print('Firebase başarıyla başlatıldı (Analytics + Firestore)');
    } catch (e) {
      print('Firebase başlatma hatası: $e');
      rethrow;
    }
  }

  /// Firestore'dan veri okuma
  Future<QuerySnapshot> getCollection(String collection) async {
    return await _firestore!.collection(collection).get();
  }

  /// Firestore'dan belirli bir dokümanı okuma
  Future<DocumentSnapshot> getDocument(String collection, String docId) async {
    return await _firestore!.collection(collection).doc(docId).get();
  }

  /// Analytics event gönder
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    await _analytics?.logEvent(name: name, parameters: parameters);
  }

  /// Sayfa görüntüleme eventi gönder
  Future<void> logPageView(String pageName) async {
    await _analytics?.logScreenView(screenName: pageName);
  }
}
