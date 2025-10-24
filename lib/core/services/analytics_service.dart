/// 📊 Analytics Service - Analitik servisi
///
/// Bu servis, kullanıcı etkileşimlerini ve uygulama metriklerini takip eder.
import 'package:flutter/foundation.dart';

class AnalyticsService {
  // Event tracking için basit implementasyon
  final List<Map<String, dynamic>> _events = [];

  /// Event kaydet
  void trackEvent(String eventName, {Map<String, dynamic>? parameters}) {
    final event = {
      'name': eventName,
      'timestamp': DateTime.now().toIso8601String(),
      'parameters': parameters ?? {},
    };

    _events.add(event);

    // Debug için konsola yazdır (sadece debug modunda)
    if (kDebugMode) {
      print('📊 Analytics Event: $eventName');
      if (parameters != null) {
        print('   Parameters: $parameters');
      }
    }
  }

  /// Sayfa görüntüleme takibi
  void trackPageView(String pageName, {Map<String, dynamic>? parameters}) {
    trackEvent(
      'page_view',
      parameters: {'page_name': pageName, ...?parameters},
    );
  }

  /// Buton tıklama takibi
  void trackButtonClick(String buttonName, {Map<String, dynamic>? parameters}) {
    trackEvent(
      'button_click',
      parameters: {'button_name': buttonName, ...?parameters},
    );
  }

  /// Form gönderimi takibi
  void trackFormSubmit(String formName, {Map<String, dynamic>? parameters}) {
    trackEvent(
      'form_submit',
      parameters: {'form_name': formName, ...?parameters},
    );
  }

  /// Proje görüntüleme
  void trackProjectView(String projectId, String projectName) {
    trackEvent(
      'project_view',
      parameters: {'project_id': projectId, 'project_name': projectName},
    );
  }

  /// İletişim formu gönderimi
  void trackContactForm(
    String formType, {
    bool success = true,
    String? errorMessage,
  }) {
    trackEvent(
      'contact_form',
      parameters: {
        'form_type': formType,
        'success': success,
        if (errorMessage != null) 'error_message': errorMessage,
      },
    );
  }

  /// Tüm event'leri al
  List<Map<String, dynamic>> getAllEvents() {
    return List.unmodifiable(_events);
  }

  /// Event'leri temizle
  void clearEvents() {
    _events.clear();
  }

  /// Event sayısını al
  int getEventCount() {
    return _events.length;
  }
}
