import 'package:flutter/material.dart';
import 'validators.dart';
import 'input_sanitizer.dart';

/// 🎯 Validation Extensions
/// Form validation için extension'lar

/// 📝 TextEditingController Extensions
extension TextEditingControllerValidation on TextEditingController {
  /// Email doğrulama
  String? validateEmail() {
    return EmailValidator.validate(text);
  }
  
  /// Telefon doğrulama
  String? validatePhone() {
    return PhoneValidator.validate(text);
  }
  
  /// İsim doğrulama
  String? validateName() {
    return NameValidator.validate(text);
  }
  
  /// Mesaj doğrulama
  String? validateMessage() {
    return MessageValidator.validate(text);
  }
  
  /// Şifre doğrulama
  String? validatePassword() {
    return PasswordValidator.validate(text);
  }
  
  /// URL doğrulama
  String? validateUrl() {
    return UrlValidator.validate(text);
  }
  
  /// Tarih doğrulama
  String? validateDate() {
    return DateValidator.validate(text);
  }
  
  /// Metni temizle
  void sanitizeText() {
    final sanitized = InputSanitizer.sanitizeText(text);
    if (sanitized != text) {
      text = sanitized;
      selection = TextSelection.fromPosition(
        TextPosition(offset: sanitized.length),
      );
    }
  }
  
  /// Güvenlik kontrolü
  bool get isSecure => InputSanitizer.isSecure(text);
  
  /// Boş mu?
  bool get isEmpty => text.trim().isEmpty;
  
  /// Dolu mu?
  bool get isNotEmpty => text.trim().isNotEmpty;
}

/// 🎯 String Extensions
extension StringValidation on String {
  /// Email geçerli mi?
  bool get isValidEmail => EmailValidator.isValid(this);
  
  /// Telefon geçerli mi?
  bool get isValidPhone => PhoneValidator.isValid(this);
  
  /// İsim geçerli mi?
  bool get isValidName => NameValidator.isValid(this);
  
  /// Mesaj geçerli mi?
  bool get isValidMessage => MessageValidator.isValid(this);
  
  /// Şifre geçerli mi?
  bool get isValidPassword => PasswordValidator.isValid(this);
  
  /// URL geçerli mi?
  bool get isValidUrl => UrlValidator.isValid(this);
  
  /// Tarih geçerli mi?
  bool get isValidDate => DateValidator.isValid(this);
  
  /// Metni temizle
  String get sanitized => InputSanitizer.sanitizeText(this);
  
  /// HTML'i temizle
  String get sanitizedHtml => InputSanitizer.sanitizeHtml(this);
  
  /// Güvenli mi?
  bool get isSecure => InputSanitizer.isSecure(this);
  
  /// Boş mu?
  bool get isEmpty => trim().isEmpty;
  
  /// Dolu mu?
  bool get isNotEmpty => trim().isNotEmpty;
}

/// 🎯 FormField Extensions
extension FormFieldValidation on FormField<String> {
  /// Email field oluştur
  static FormField<String> email({
    required String initialValue,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    bool enabled = true,
  }) {
    return FormField<String>(
      initialValue: initialValue,
      enabled: enabled,
      validator: validator ?? EmailValidator.validate,
      onSaved: onSaved,
      builder: (field) => TextFormField(
        initialValue: initialValue,
        enabled: enabled,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'E-posta',
          hintText: 'ornek@email.com',
          prefixIcon: const Icon(Icons.email_outlined),
          border: const OutlineInputBorder(),
          errorText: field.errorText,
        ),
        onChanged: (value) => field.didChange(value),
      ),
    );
  }
  
  /// Telefon field oluştur
  static FormField<String> phone({
    required String initialValue,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    bool enabled = true,
  }) {
    return FormField<String>(
      initialValue: initialValue,
      enabled: enabled,
      validator: validator ?? PhoneValidator.validate,
      onSaved: onSaved,
      builder: (field) => TextFormField(
        initialValue: initialValue,
        enabled: enabled,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'Telefon',
          hintText: '+90 555 123 45 67',
          prefixIcon: const Icon(Icons.phone_outlined),
          border: const OutlineInputBorder(),
          errorText: field.errorText,
        ),
        onChanged: (value) => field.didChange(value),
      ),
    );
  }
  
  /// İsim field oluştur
  static FormField<String> name({
    required String initialValue,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    bool enabled = true,
  }) {
    return FormField<String>(
      initialValue: initialValue,
      enabled: enabled,
      validator: validator ?? NameValidator.validate,
      onSaved: onSaved,
      builder: (field) => TextFormField(
        initialValue: initialValue,
        enabled: enabled,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'İsim',
          hintText: 'Adınız ve soyadınız',
          prefixIcon: const Icon(Icons.person_outlined),
          border: const OutlineInputBorder(),
          errorText: field.errorText,
        ),
        onChanged: (value) => field.didChange(value),
      ),
    );
  }
  
  /// Mesaj field oluştur
  static FormField<String> message({
    required String initialValue,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    bool enabled = true,
    int maxLines = 5,
  }) {
    return FormField<String>(
      initialValue: initialValue,
      enabled: enabled,
      validator: validator ?? MessageValidator.validate,
      onSaved: onSaved,
      builder: (field) => TextFormField(
        initialValue: initialValue,
        enabled: enabled,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: 'Mesaj',
          hintText: 'Mesajınızı buraya yazın...',
          prefixIcon: const Icon(Icons.message_outlined),
          border: const OutlineInputBorder(),
          alignLabelWithHint: true,
          errorText: field.errorText,
        ),
        onChanged: (value) => field.didChange(value),
      ),
    );
  }
}

/// 🎯 GlobalKey FormState Extensions
extension FormStateValidation on GlobalKey<FormState> {
  /// Form'u doğrula
  bool validateForm() {
    return currentState?.validate() ?? false;
  }
  
  /// Form'u kaydet
  void saveForm() {
    currentState?.save();
  }
  
  /// Form'u sıfırla
  void resetForm() {
    currentState?.reset();
  }
  
  /// Form'u doğrula ve kaydet
  bool validateAndSaveForm() {
    if (validateForm()) {
      saveForm();
      return true;
    }
    return false;
  }
}

/// 🎯 BuildContext Extensions
extension BuildContextValidation on BuildContext {
  /// Form field'ı doğrula
  String? validateField(String fieldName, String value) {
    switch (fieldName) {
      case 'email':
        return EmailValidator.validate(value);
      case 'phone':
        return PhoneValidator.validate(value);
      case 'name':
        return NameValidator.validate(value);
      case 'message':
        return MessageValidator.validate(value);
      case 'password':
        return PasswordValidator.validate(value);
      case 'url':
        return UrlValidator.validate(value);
      case 'date':
        return DateValidator.validate(value);
      default:
        return null;
    }
  }
  
  /// Form field'ı temizle
  String sanitizeField(String value) {
    return InputSanitizer.sanitizeText(value);
  }
  
  /// Güvenlik kontrolü
  bool isFieldSecure(String value) {
    return InputSanitizer.isSecure(value);
  }
}
