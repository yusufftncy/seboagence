import 'dart:convert';
import 'dart:io';

/// 📊 Analytics Manager
/// Analytics ve tracking için ana sınıf

class AnalyticsManager {
  static final AnalyticsManager _instance = AnalyticsManager._internal();
  factory AnalyticsManager() => _instance;
  AnalyticsManager._internal();
  
  static AnalyticsManager get instance => _instance;
  
  // Analytics data
  final List<AnalyticsEvent> _events = [];
  
  // Analytics directory
  Directory? _analyticsDirectory;
  
  // Configuration
  bool _isEnabled = true;
  bool _isDebugMode = false;
  
  /// Analytics'i başlat
  Future<void> initialize({bool debugMode = false}) async {
    _isDebugMode = debugMode;
    _analyticsDirectory = Directory('analytics');
    await _createAnalyticsDirectory();
    
    if (_isDebugMode) {
      // Debug mode'da log yazdır
      // print('📊 Analytics Manager initialized');
    }
  }
  
  /// Analytics dizini oluştur
  Future<void> _createAnalyticsDirectory() async {
    if (_analyticsDirectory != null) {
      final analyticsDir = Directory('${_analyticsDirectory!.path}/analytics');
      if (!await analyticsDir.exists()) {
        await analyticsDir.create(recursive: true);
      }
    }
  }
  
  /// Analytics'i etkinleştir/devre dışı bırak
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }
  
  /// Debug modunu aç/kapat
  void setDebugMode(bool debugMode) {
    _isDebugMode = debugMode;
  }
  
  /// Sayfa ziyaret takibi
  void trackPageView(String pageName, {Map<String, dynamic>? parameters}) {
    if (!_isEnabled) return;
    
    final event = AnalyticsEvent(
      name: 'page_view',
      category: 'navigation',
      action: 'view',
      label: pageName,
      value: null,
      parameters: parameters ?? {},
      timestamp: DateTime.now(),
    );
    
    _addEvent(event);
  }
  
  /// Buton tıklama takibi
  void trackButtonClick(String buttonName, {Map<String, dynamic>? parameters}) {
    if (!_isEnabled) return;
    
    final event = AnalyticsEvent(
      name: 'button_click',
      category: 'interaction',
      action: 'click',
      label: buttonName,
      value: null,
      parameters: parameters ?? {},
      timestamp: DateTime.now(),
    );
    
    _addEvent(event);
  }
  
  /// Form gönderimi takibi
  void trackFormSubmit(String formName, {Map<String, dynamic>? parameters}) {
    if (!_isEnabled) return;
    
    final event = AnalyticsEvent(
      name: 'form_submit',
      category: 'form',
      action: 'submit',
      label: formName,
      value: null,
      parameters: parameters ?? {},
      timestamp: DateTime.now(),
    );
    
    _addEvent(event);
  }
  
  /// API çağrısı takibi
  void trackApiCall(String endpoint, int statusCode, Duration duration, {Map<String, dynamic>? parameters}) {
    if (!_isEnabled) return;
    
    final event = AnalyticsEvent(
      name: 'api_call',
      category: 'api',
      action: 'call',
      label: endpoint,
      value: statusCode,
      parameters: {
        ...parameters ?? {},
        'duration_ms': duration.inMilliseconds,
        'status_code': statusCode,
      },
      timestamp: DateTime.now(),
    );
    
    _addEvent(event);
  }
  
  /// Hata takibi
  void trackError(String errorType, String errorMessage, {Map<String, dynamic>? parameters}) {
    if (!_isEnabled) return;
    
    final event = AnalyticsEvent(
      name: 'error',
      category: 'error',
      action: 'occurred',
      label: errorType,
      value: null,
      parameters: {
        ...parameters ?? {},
        'error_message': errorMessage,
        'error_type': errorType,
      },
      timestamp: DateTime.now(),
    );
    
    _addEvent(event);
  }
  
  /// Kullanıcı etkileşimi takibi
  void trackUserInteraction(String interactionType, {Map<String, dynamic>? parameters}) {
    if (!_isEnabled) return;
    
    final event = AnalyticsEvent(
      name: 'user_interaction',
      category: 'user',
      action: 'interact',
      label: interactionType,
      value: null,
      parameters: parameters ?? {},
      timestamp: DateTime.now(),
    );
    
    _addEvent(event);
  }
  
  /// Özel event takibi
  void trackCustomEvent(String eventName, {
    String? category,
    String? action,
    String? label,
    int? value,
    Map<String, dynamic>? parameters,
  }) {
    if (!_isEnabled) return;
    
    final event = AnalyticsEvent(
      name: eventName,
      category: category ?? 'custom',
      action: action ?? 'trigger',
      label: label,
      value: value,
      parameters: parameters ?? {},
      timestamp: DateTime.now(),
    );
    
    _addEvent(event);
  }
  
  /// Event ekle
  void _addEvent(AnalyticsEvent event) {
    _events.add(event);
    
    if (_isDebugMode) {
      // Debug mode'da log yazdır
      // print('📊 Analytics Event: ${event.name} - ${event.label}');
    }
    
    // Event'i dosyaya kaydet
    _saveEventToFile(event);
  }
  
  /// Event'i dosyaya kaydet
  Future<void> _saveEventToFile(AnalyticsEvent event) async {
    if (_analyticsDirectory == null) return;
    
    try {
      final file = File('${_analyticsDirectory!.path}/analytics/events.json');
      final eventsJson = _events.map((e) => e.toJson()).toList();
      await file.writeAsString(jsonEncode(eventsJson));
    } catch (e) {
      if (_isDebugMode) {
        // Debug mode'da log yazdır
        // print('📊 Analytics save error: $e');
      }
    }
  }
  
  /// Event'leri al
  List<AnalyticsEvent> getEvents() {
    return List.unmodifiable(_events);
  }
  
  /// Event'leri temizle
  void clearEvents() {
    _events.clear();
  }
  
  /// Analytics raporu oluştur
  AnalyticsReport generateReport() {
    final now = DateTime.now();
    final last24Hours = now.subtract(const Duration(hours: 24));
    
    // Son 24 saatteki event'ler
    final recentEvents = _events.where((event) => 
        event.timestamp.isAfter(last24Hours)).toList();
    
    // Kategori bazında sayım
    final categoryCounts = <String, int>{};
    for (final event in recentEvents) {
      categoryCounts[event.category] = (categoryCounts[event.category] ?? 0) + 1;
    }
    
    // En popüler sayfalar
    final pageViews = recentEvents.where((event) => event.name == 'page_view').toList();
    final pageCounts = <String, int>{};
    for (final event in pageViews) {
      pageCounts[event.label ?? ''] = (pageCounts[event.label ?? ''] ?? 0) + 1;
    }
    
    // En popüler butonlar
    final buttonClicks = recentEvents.where((event) => event.name == 'button_click').toList();
    final buttonCounts = <String, int>{};
    for (final event in buttonClicks) {
      buttonCounts[event.label ?? ''] = (buttonCounts[event.label ?? ''] ?? 0) + 1;
    }
    
    // Hata sayısı
    final errorCount = recentEvents.where((event) => event.name == 'error').length;
    
    return AnalyticsReport(
      totalEvents: recentEvents.length,
      categoryCounts: categoryCounts,
      pageCounts: pageCounts,
      buttonCounts: buttonCounts,
      errorCount: errorCount,
      reportDate: now,
    );
  }
  
  /// Analytics verilerini dışa aktar
  Future<String> exportData() async {
    final data = {
      'events': _events.map((e) => e.toJson()).toList(),
      'export_date': DateTime.now().toIso8601String(),
      'total_events': _events.length,
    };
    
    return jsonEncode(data);
  }
  
  /// Analytics verilerini içe aktar
  Future<void> importData(String jsonData) async {
    try {
      final data = jsonDecode(jsonData);
      final eventsJson = data['events'] as List;
      
      _events.clear();
      for (final eventJson in eventsJson) {
        final event = AnalyticsEvent.fromJson(eventJson);
        _events.add(event);
      }
    } catch (e) {
      if (_isDebugMode) {
        // Debug mode'da log yazdır
        // print('📊 Analytics import error: $e');
      }
    }
  }
}

/// 📝 Analytics Event
class AnalyticsEvent {
  final String name;
  final String category;
  final String action;
  final String? label;
  final int? value;
  final Map<String, dynamic> parameters;
  final DateTime timestamp;
  
  AnalyticsEvent({
    required this.name,
    required this.category,
    required this.action,
    this.label,
    this.value,
    required this.parameters,
    required this.timestamp,
  });
  
  /// JSON'a çevir
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'action': action,
      'label': label,
      'value': value,
      'parameters': parameters,
      'timestamp': timestamp.toIso8601String(),
    };
  }
  
  /// JSON'dan oluştur
  factory AnalyticsEvent.fromJson(Map<String, dynamic> json) {
    return AnalyticsEvent(
      name: json['name'],
      category: json['category'],
      action: json['action'],
      label: json['label'],
      value: json['value'],
      parameters: Map<String, dynamic>.from(json['parameters']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

/// 📊 Analytics Report
class AnalyticsReport {
  final int totalEvents;
  final Map<String, int> categoryCounts;
  final Map<String, int> pageCounts;
  final Map<String, int> buttonCounts;
  final int errorCount;
  final DateTime reportDate;
  
  AnalyticsReport({
    required this.totalEvents,
    required this.categoryCounts,
    required this.pageCounts,
    required this.buttonCounts,
    required this.errorCount,
    required this.reportDate,
  });
  
  /// En popüler kategori
  String get topCategory {
    if (categoryCounts.isEmpty) return 'N/A';
    return categoryCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }
  
  /// En popüler sayfa
  String get topPage {
    if (pageCounts.isEmpty) return 'N/A';
    return pageCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }
  
  /// En popüler buton
  String get topButton {
    if (buttonCounts.isEmpty) return 'N/A';
    return buttonCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }
}
