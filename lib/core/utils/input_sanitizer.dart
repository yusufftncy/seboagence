// 🛡️ Input Sanitizer
// Giriş verilerini temizleyen ve güvenli hale getiren sistem

/// 🧹 Text Sanitizer
class TextSanitizer {
  /// Metni temizle
  static String sanitize(String input) {
    if (input.isEmpty) return input;
    
    // HTML etiketlerini kaldır
    String cleaned = _removeHtmlTags(input);
    
    // XSS saldırılarını engelle
    cleaned = _preventXSS(cleaned);
    
    // SQL injection saldırılarını engelle
    cleaned = _preventSQLInjection(cleaned);
    
    // Özel karakterleri temizle
    cleaned = _cleanSpecialCharacters(cleaned);
    
    // Boşlukları normalize et
    cleaned = _normalizeWhitespace(cleaned);
    
    return cleaned.trim();
  }
  
  /// HTML etiketlerini kaldır
  static String _removeHtmlTags(String input) {
    return input.replaceAll(RegExp(r'<[^>]*>'), '');
  }
  
  /// XSS saldırılarını engelle
  static String _preventXSS(String input) {
    // Script etiketlerini kaldır
    input = input.replaceAll(RegExp(r'<script[^>]*>.*?</script>', caseSensitive: false), '');
    
    // JavaScript event handler'larını kaldır
    input = input.replaceAll(RegExp(r'\bon\w+\s*=', caseSensitive: false), '');
    
    // JavaScript: protokolünü kaldır
    input = input.replaceAll(RegExp(r'javascript:', caseSensitive: false), '');
    
    // Data: protokolünü kaldır
    input = input.replaceAll(RegExp(r'data:', caseSensitive: false), '');
    
    return input;
  }
  
  /// SQL injection saldırılarını engelle
  static String _preventSQLInjection(String input) {
    // SQL komutlarını kaldır
    final sqlKeywords = [
      'SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'CREATE', 'ALTER',
      'UNION', 'WHERE', 'FROM', 'INTO', 'VALUES', 'SET', 'AND', 'OR',
      'EXEC', 'EXECUTE', 'DECLARE', 'CAST', 'CONVERT'
    ];
    
    for (final keyword in sqlKeywords) {
      input = input.replaceAll(RegExp(keyword, caseSensitive: false), '');
    }
    
    // SQL injection karakterlerini temizle
    input = input.replaceAll(RegExp(r'[;]'), '');
    input = input.replaceAll('--', '');
    
    return input;
  }
  
  /// Özel karakterleri temizle
  static String _cleanSpecialCharacters(String input) {
    // Kontrol karakterlerini kaldır
    input = input.replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]'), '');
    
    // Null karakterlerini kaldır
    input = input.replaceAll('\x00', '');
    
    return input;
  }
  
  /// Boşlukları normalize et
  static String _normalizeWhitespace(String input) {
    // Çoklu boşlukları tek boşluğa çevir
    input = input.replaceAll(RegExp(r'\s+'), ' ');
    
    // Başta ve sonda boşlukları kaldır
    return input.trim();
  }
}

/// 🔒 HTML Sanitizer
class HtmlSanitizer {
  /// HTML'i güvenli hale getir
  static String sanitizeHtml(String input) {
    if (input.isEmpty) return input;
    
    // Basit HTML temizleme
    return TextSanitizer.sanitize(input);
  }
}

/// 🔐 Security Sanitizer
class SecuritySanitizer {
  /// Güvenlik açıklarını tespit et
  static List<String> detectSecurityIssues(String input) {
    final issues = <String>[];
    
    // XSS tespiti
    if (_hasXSSPatterns(input)) {
      issues.add('XSS saldırısı tespit edildi');
    }
    
    // SQL injection tespiti
    if (_hasSQLInjectionPatterns(input)) {
      issues.add('SQL injection saldırısı tespit edildi');
    }
    
    // Script injection tespiti
    if (_hasScriptInjectionPatterns(input)) {
      issues.add('Script injection saldırısı tespit edildi');
    }
    
    return issues;
  }
  
  /// XSS pattern'lerini tespit et
  static bool _hasXSSPatterns(String input) {
    final xssPatterns = [
      RegExp(r'<script[^>]*>', caseSensitive: false),
      RegExp(r'javascript:', caseSensitive: false),
      RegExp(r'data:', caseSensitive: false),
      RegExp(r'\bon\w+\s*=', caseSensitive: false),
    ];
    
    for (final pattern in xssPatterns) {
      if (pattern.hasMatch(input)) {
        return true;
      }
    }
    
    return false;
  }
  
  /// SQL injection pattern'lerini tespit et
  static bool _hasSQLInjectionPatterns(String input) {
    final sqlPatterns = [
      RegExp(r'[;]', caseSensitive: false),
      RegExp(r'--', caseSensitive: false),
      RegExp(r'(SELECT|INSERT|UPDATE|DELETE|DROP|CREATE|ALTER)', caseSensitive: false),
    ];
    
    for (final pattern in sqlPatterns) {
      if (pattern.hasMatch(input)) {
        return true;
      }
    }
    
    return false;
  }
  
  /// Script injection pattern'lerini tespit et
  static bool _hasScriptInjectionPatterns(String input) {
    final scriptPatterns = [
      RegExp(r'<script[^>]*>.*?</script>', caseSensitive: false),
      RegExp(r'<iframe[^>]*>.*?</iframe>', caseSensitive: false),
      RegExp(r'<object[^>]*>.*?</object>', caseSensitive: false),
      RegExp(r'<embed[^>]*>', caseSensitive: false),
    ];
    
    for (final pattern in scriptPatterns) {
      if (pattern.hasMatch(input)) {
        return true;
      }
    }
    
    return false;
  }
}

/// 🎯 Input Sanitizer
class InputSanitizer {
  /// Tüm giriş verilerini temizle
  static String sanitizeAll(String input) {
    if (input.isEmpty) return input;
    
    // 1. Güvenlik açıklarını tespit et
    final securityIssues = SecuritySanitizer.detectSecurityIssues(input);
    if (securityIssues.isNotEmpty) {
      // Güvenlik açığı tespit edildi, metni tamamen temizle
      return TextSanitizer.sanitize(input);
    }
    
    // 2. HTML'i güvenli hale getir
    final htmlSanitized = HtmlSanitizer.sanitizeHtml(input);
    
    // 3. Metni temizle
    final textSanitized = TextSanitizer.sanitize(htmlSanitized);
    
    return textSanitized;
  }
  
  /// Sadece metin temizleme
  static String sanitizeText(String input) {
    return TextSanitizer.sanitize(input);
  }
  
  /// HTML temizleme
  static String sanitizeHtml(String input) {
    return HtmlSanitizer.sanitizeHtml(input);
  }
  
  /// Güvenlik kontrolü
  static bool isSecure(String input) {
    final securityIssues = SecuritySanitizer.detectSecurityIssues(input);
    return securityIssues.isEmpty;
  }
}
