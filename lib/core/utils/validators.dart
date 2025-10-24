// 🎯 Form Validators
// Tüm form doğrulama işlemleri için validator'lar

/// 📧 Email Validator
class EmailValidator {
  static const String _emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta adresi zorunludur';
    }

    if (!RegExp(_emailPattern).hasMatch(value)) {
      return 'Geçerli bir e-posta adresi girin';
    }

    return null;
  }

  static bool isValid(String email) {
    return RegExp(_emailPattern).hasMatch(email);
  }
}

/// 📱 Phone Validator
class PhoneValidator {
  static const String _phonePattern = r'^(\+90|0)?[5][0-9]{9}$';

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefon numarası zorunludur';
    }

    // Boşluk ve tire karakterlerini temizle
    final cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (!RegExp(_phonePattern).hasMatch(cleanPhone)) {
      return 'Geçerli bir telefon numarası girin (örn: +90 555 123 45 67)';
    }

    return null;
  }

  static bool isValid(String phone) {
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    return RegExp(_phonePattern).hasMatch(cleanPhone);
  }
}

/// 👤 Name Validator
class NameValidator {
  static const int minLength = 2;
  static const int maxLength = 50;

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'İsim zorunludur';
    }

    if (value.length < minLength) {
      return 'İsim en az $minLength karakter olmalı';
    }

    if (value.length > maxLength) {
      return 'İsim en fazla $maxLength karakter olmalı';
    }

    // Sadece harf, boşluk ve Türkçe karakterlere izin ver
    if (!RegExp(r'^[a-zA-ZçğıöşüÇĞIİÖŞÜ\s]+$').hasMatch(value)) {
      return 'İsim sadece harf içerebilir';
    }

    return null;
  }

  static bool isValid(String name) {
    return name.length >= minLength &&
        name.length <= maxLength &&
        RegExp(r'^[a-zA-ZçğıöşüÇĞIİÖŞÜ\s]+$').hasMatch(name);
  }
}

/// 💬 Message Validator
class MessageValidator {
  static const int minLength = 10;
  static const int maxLength = 1000;

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mesaj zorunludur';
    }

    if (value.length < minLength) {
      return 'Mesaj en az $minLength karakter olmalı';
    }

    if (value.length > maxLength) {
      return 'Mesaj en fazla $maxLength karakter olmalı';
    }

    return null;
  }

  static bool isValid(String message) {
    return message.length >= minLength && message.length <= maxLength;
  }
}

/// 🔒 Password Validator
class PasswordValidator {
  static const int minLength = 8;
  static const int maxLength = 50;

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre zorunludur';
    }

    if (value.length < minLength) {
      return 'Şifre en az $minLength karakter olmalı';
    }

    if (value.length > maxLength) {
      return 'Şifre en fazla $maxLength karakter olmalı';
    }

    // En az bir büyük harf, bir küçük harf ve bir rakam içermeli
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
      return 'Şifre en az bir büyük harf, bir küçük harf ve bir rakam içermeli';
    }

    return null;
  }

  static bool isValid(String password) {
    return password.length >= minLength &&
        password.length <= maxLength &&
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(password);
  }
}

/// 🔗 URL Validator
class UrlValidator {
  static const String _urlPattern =
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';

  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL zorunludur';
    }

    if (!RegExp(_urlPattern).hasMatch(value)) {
      return 'Geçerli bir URL girin (örn: https://example.com)';
    }

    return null;
  }

  static bool isValid(String url) {
    return RegExp(_urlPattern).hasMatch(url);
  }
}

/// 📅 Date Validator
class DateValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tarih zorunludur';
    }

    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return 'Geçerli bir tarih girin (YYYY-MM-DD)';
    }
  }

  static bool isValid(String date) {
    try {
      DateTime.parse(date);
      return true;
    } catch (e) {
      return false;
    }
  }
}

/// 🎯 Custom Validator
class CustomValidator {
  /// Özel doğrulama fonksiyonu
  static String? validate(String? value, String? Function(String?) validator) {
    return validator(value);
  }

  /// Birden fazla validator'ı birleştir
  static String? validateMultiple(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}

/// 📊 Validation Result
class ValidationResult {
  final bool isValid;
  final String? errorMessage;
  final Map<String, dynamic> data;

  ValidationResult({
    required this.isValid,
    this.errorMessage,
    this.data = const {},
  });

  factory ValidationResult.success([Map<String, dynamic>? data]) {
    return ValidationResult(isValid: true, data: data ?? {});
  }

  factory ValidationResult.error(String message) {
    return ValidationResult(isValid: false, errorMessage: message);
  }
}

/// 🎯 Form Validator
class FormValidator {
  /// Tüm form alanlarını doğrula
  static ValidationResult validateForm(Map<String, String> fields) {
    final errors = <String, String>{};

    // Email doğrulama
    if (fields.containsKey('email')) {
      final emailError = EmailValidator.validate(fields['email']);
      if (emailError != null) {
        errors['email'] = emailError;
      }
    }

    // Telefon doğrulama
    if (fields.containsKey('phone')) {
      final phoneError = PhoneValidator.validate(fields['phone']);
      if (phoneError != null) {
        errors['phone'] = phoneError;
      }
    }

    // İsim doğrulama
    if (fields.containsKey('name')) {
      final nameError = NameValidator.validate(fields['name']);
      if (nameError != null) {
        errors['name'] = nameError;
      }
    }

    // Mesaj doğrulama
    if (fields.containsKey('message')) {
      final messageError = MessageValidator.validate(fields['message']);
      if (messageError != null) {
        errors['message'] = messageError;
      }
    }

    if (errors.isEmpty) {
      return ValidationResult.success();
    } else {
      return ValidationResult.error('Form doğrulama hatası');
    }
  }
}

/// 🎯 Validators - Static access to all validators
class Validators {
  /// Email validator
  static String? email(String? value) => EmailValidator.validate(value);

  /// Phone validator
  static String? phone(String? value) => PhoneValidator.validate(value);

  /// Name validator
  static String? name(String? value) => NameValidator.validate(value);

  /// Message validator
  static String? message(String? value) => MessageValidator.validate(value);

  /// Password validator
  static String? password(String? value) => PasswordValidator.validate(value);

  /// URL validator
  static String? url(String? value) => UrlValidator.validate(value);

  /// Date validator
  static String? date(String? value) => DateValidator.validate(value);

  /// Required field validator
  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName zorunludur';
    }
    return null;
  }
}
