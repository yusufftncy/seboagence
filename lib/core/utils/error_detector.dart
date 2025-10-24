// 🔍 Hata Tespit Sistemi
// Hataları otomatik tespit eden sistem

class ErrorDetector {
  /// 🚨 Hata türleri
  static const List<String> errorTypes = [
    'Undefined name',
    'The method',
    'isn\'t defined',
    'Unused import',
    'deprecated',
    'TODO:',
    'FIXME:',
    'Missing required',
    'Expected',
    'Found',
  ];

  /// ⚠️ Uyarı türleri
  static const List<String> warningTypes = [
    'Unused import',
    'Unused variable',
    'Unused parameter',
    'Dead code',
    'Unnecessary',
    'Missing required',
    'Expected',
    'Found',
    'deprecated',
    'TODO:',
    'FIXME:',
  ];

  /// 🔍 Hata tespit et
  static List<String> detectErrors(String content) {
    final errors = <String>[];
    
    for (final errorType in errorTypes) {
      if (content.contains(errorType)) {
        errors.add(errorType);
      }
    }
    
    // Yorum hatalarını da tespit et
    final todoFixmeErrors = detectTodoAndFixmeErrors(content);
    errors.addAll(todoFixmeErrors);
    
    return errors;
  }

  /// 📝 Yorum hatalarını tespit et
  static List<String> detectTodoAndFixmeErrors(String content) {
    final errors = <String>[];
    
    // Yorum pattern'lerini tespit et
    final todoPatterns = [
      'TODO:',
      '// TODO:',
      'TODO:',
      'FIXME:',
      '// FIXME:',
      'FIXME:',
    ];
    
    for (final pattern in todoPatterns) {
      if (content.contains(pattern)) {
        errors.add('$pattern hatası tespit edildi');
      }
    }
    
    return errors;
  }

  /// ⚠️ Uyarı tespit et
  static List<String> detectWarnings(String content) {
    final warnings = <String>[];
    
    for (final warningType in warningTypes) {
      if (content.contains(warningType)) {
        warnings.add(warningType);
      }
    }
    
    // Yorum uyarılarını da tespit et
    final todoFixmeWarnings = detectTodoAndFixmeWarnings(content);
    warnings.addAll(todoFixmeWarnings);
    
    return warnings;
  }

  /// 📝 Yorum uyarılarını tespit et
  static List<String> detectTodoAndFixmeWarnings(String content) {
    final warnings = <String>[];
    
    // Yorum pattern'lerini tespit et
    final todoPatterns = [
      'TODO:',
      '// TODO:',
      'TODO:',
      'FIXME:',
      '// FIXME:',
      'FIXME:',
    ];
    
    for (final pattern in todoPatterns) {
      if (content.contains(pattern)) {
        warnings.add('$pattern uyarısı tespit edildi');
      }
    }
    
    return warnings;
  }

  /// 🎯 Hata önceliği belirle
  static int getErrorPriority(String error) {
    if (error.contains('Undefined name')) return 1;
    if (error.contains('isn\'t defined')) return 2;
    if (error.contains('deprecated')) return 3;
    if (error.contains('Unused import')) return 4;
    if (error.contains('TODO:')) return 5;
    
    return 6;
  }

  /// 🔧 Hata düzeltme önerisi
  static String getFixSuggestion(String error) {
    if (error.contains('withOpacity')) {
      return 'withOpacity yerine withValues(alpha: kullan';
    }
    if (error.contains('Color.value')) {
      return 'Color.value yerine toARGB32() kullan';
    }
    if (error.contains('textScaleFactor')) {
      return 'textScaleFactor yerine textScaler.scale(1.0) kullan';
    }
    if (error.contains('Unused import')) {
      return 'Kullanılmayan import\'u kaldır';
    }
    if (error.contains('Unused variable')) {
      return 'Kullanılmayan değişkeni kaldır';
    }
    if (error.contains('Unused parameter')) {
      return 'Kullanılmayan parametreyi kaldır';
    }
    if (error.contains('Dead code')) {
      return 'Ölü kodu kaldır';
    }
    if (error.contains('Unnecessary')) {
      return 'Gereksiz kodu kaldır';
    }
    if (error.contains('Missing required')) {
      return 'Eksik gerekli parametreyi ekle';
    }
    if (error.contains('Expected')) {
      return 'Beklenen değeri ekle';
    }
    if (error.contains('Found')) {
      return 'Bulunan değeri düzelt';
    }
    if (error.contains('deprecated')) {
      return 'Deprecated API\'yi güncelle';
    }
    if (error.contains('TODO:')) {
      return 'TODO yorumunu düzelt';
    }
    if (error.contains('FIXME:')) {
      return 'FIXME yorumunu düzelt';
    }
    
    return 'Hata türü tespit edilemedi';
  }
}
