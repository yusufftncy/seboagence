import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'analytics_manager.dart';

/// 📊 Analytics Providers
/// Analytics yönetimi için Riverpod provider'lar

/// 📱 Analytics Manager Provider
final analyticsManagerProvider = Provider<AnalyticsManager>((ref) {
  return AnalyticsManager.instance;
});

/// 🎯 Analytics State Provider
final analyticsStateProvider = StateNotifierProvider<AnalyticsStateNotifier, AnalyticsState>((ref) {
  return AnalyticsStateNotifier();
});

/// 📝 Analytics State
class AnalyticsState {
  final bool isEnabled;
  final bool isDebugMode;
  final bool isInitialized;
  final String? error;
  final AnalyticsReport? report;
  
  AnalyticsState({
    this.isEnabled = true,
    this.isDebugMode = false,
    this.isInitialized = false,
    this.error,
    this.report,
  });
  
  AnalyticsState copyWith({
    bool? isEnabled,
    bool? isDebugMode,
    bool? isInitialized,
    String? error,
    AnalyticsReport? report,
  }) {
    return AnalyticsState(
      isEnabled: isEnabled ?? this.isEnabled,
      isDebugMode: isDebugMode ?? this.isDebugMode,
      isInitialized: isInitialized ?? this.isInitialized,
      error: error ?? this.error,
      report: report ?? this.report,
    );
  }
}

/// 📝 Analytics State Notifier
class AnalyticsStateNotifier extends StateNotifier<AnalyticsState> {
  AnalyticsStateNotifier() : super(AnalyticsState());
  
  /// Analytics'i başlat
  Future<void> initialize({bool debugMode = false}) async {
    try {
      final analyticsManager = AnalyticsManager.instance;
      await analyticsManager.initialize(debugMode: debugMode);
      
      state = state.copyWith(
        isInitialized: true,
        isDebugMode: debugMode,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
      );
    }
  }
  
  /// Analytics'i etkinleştir/devre dışı bırak
  void setEnabled(bool enabled) {
    final analyticsManager = AnalyticsManager.instance;
    analyticsManager.setEnabled(enabled);
    
    state = state.copyWith(isEnabled: enabled);
  }
  
  /// Debug modunu aç/kapat
  void setDebugMode(bool debugMode) {
    final analyticsManager = AnalyticsManager.instance;
    analyticsManager.setDebugMode(debugMode);
    
    state = state.copyWith(isDebugMode: debugMode);
  }
  
  /// Rapor oluştur
  void generateReport() {
    final analyticsManager = AnalyticsManager.instance;
    final report = analyticsManager.generateReport();
    
    state = state.copyWith(report: report);
  }
  
  /// Event'leri temizle
  void clearEvents() {
    final analyticsManager = AnalyticsManager.instance;
    analyticsManager.clearEvents();
  }
}

/// 🎯 Analytics Event Provider
final analyticsEventProvider = StateNotifierProvider<AnalyticsEventNotifier, List<AnalyticsEvent>>((ref) {
  return AnalyticsEventNotifier();
});

/// 📝 Analytics Event Notifier
class AnalyticsEventNotifier extends StateNotifier<List<AnalyticsEvent>> {
  AnalyticsEventNotifier() : super([]);
  
  /// Event ekle
  void addEvent(AnalyticsEvent event) {
    state = [...state, event];
  }
  
  /// Event'leri temizle
  void clearEvents() {
    state = [];
  }
  
  /// Event'leri güncelle
  void updateEvents(List<AnalyticsEvent> events) {
    state = events;
  }
}

/// 🎯 Analytics Tracking Provider
final analyticsTrackingProvider = Provider<AnalyticsTracking>((ref) {
  return AnalyticsTracking();
});

/// 📝 Analytics Tracking
class AnalyticsTracking {
  /// Sayfa ziyaret takibi
  void trackPageView(String pageName, {Map<String, dynamic>? parameters}) {
    AnalyticsManager.instance.trackPageView(pageName, parameters: parameters);
  }
  
  /// Buton tıklama takibi
  void trackButtonClick(String buttonName, {Map<String, dynamic>? parameters}) {
    AnalyticsManager.instance.trackButtonClick(buttonName, parameters: parameters);
  }
  
  /// Form gönderimi takibi
  void trackFormSubmit(String formName, {Map<String, dynamic>? parameters}) {
    AnalyticsManager.instance.trackFormSubmit(formName, parameters: parameters);
  }
  
  /// API çağrısı takibi
  void trackApiCall(String endpoint, int statusCode, Duration duration, {Map<String, dynamic>? parameters}) {
    AnalyticsManager.instance.trackApiCall(endpoint, statusCode, duration, parameters: parameters);
  }
  
  /// Hata takibi
  void trackError(String errorType, String errorMessage, {Map<String, dynamic>? parameters}) {
    AnalyticsManager.instance.trackError(errorType, errorMessage, parameters: parameters);
  }
  
  /// Kullanıcı etkileşimi takibi
  void trackUserInteraction(String interactionType, {Map<String, dynamic>? parameters}) {
    AnalyticsManager.instance.trackUserInteraction(interactionType, parameters: parameters);
  }
  
  /// Özel event takibi
  void trackCustomEvent(String eventName, {
    String? category,
    String? action,
    String? label,
    int? value,
    Map<String, dynamic>? parameters,
  }) {
    AnalyticsManager.instance.trackCustomEvent(
      eventName,
      category: category,
      action: action,
      label: label,
      value: value,
      parameters: parameters,
    );
  }
}

/// 🎯 Analytics Helper Provider
final analyticsHelperProvider = Provider<AnalyticsHelper>((ref) {
  return AnalyticsHelper();
});

/// 📝 Analytics Helper
class AnalyticsHelper {
  /// Event'leri al
  List<AnalyticsEvent> getEvents() {
    return AnalyticsManager.instance.getEvents();
  }
  
  /// Rapor oluştur
  AnalyticsReport generateReport() {
    return AnalyticsManager.instance.generateReport();
  }
  
  /// Verileri dışa aktar
  Future<String> exportData() async {
    return await AnalyticsManager.instance.exportData();
  }
  
  /// Verileri içe aktar
  Future<void> importData(String jsonData) async {
    await AnalyticsManager.instance.importData(jsonData);
  }
  
  /// Event'leri temizle
  void clearEvents() {
    AnalyticsManager.instance.clearEvents();
  }
  
  /// Analytics'i etkinleştir
  void enable() {
    AnalyticsManager.instance.setEnabled(true);
  }
  
  /// Analytics'i devre dışı bırak
  void disable() {
    AnalyticsManager.instance.setEnabled(false);
  }
  
  /// Debug modunu aç
  void enableDebugMode() {
    AnalyticsManager.instance.setDebugMode(true);
  }
  
  /// Debug modunu kapat
  void disableDebugMode() {
    AnalyticsManager.instance.setDebugMode(false);
  }
}
