import 'package:flutter/material.dart';
import 'validators.dart';
import 'input_sanitizer.dart';

/// 🎯 Form Helpers
/// Form işlemleri için yardımcı fonksiyonlar

/// 📝 Form Field Helper
class FormFieldHelper {
  /// Email field oluştur
  static Widget buildEmailField({
    required TextEditingController controller,
    String? label,
    String? hint,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label ?? 'E-posta',
        hintText: hint ?? 'ornek@email.com',
        prefixIcon: const Icon(Icons.email_outlined),
        border: const OutlineInputBorder(),
      ),
      validator: validator ?? EmailValidator.validate,
      onChanged: (value) {
        // Giriş verilerini temizle
        final sanitizedValue = InputSanitizer.sanitizeText(value);
        if (sanitizedValue != value) {
          controller.text = sanitizedValue;
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: sanitizedValue.length),
          );
        }
        onChanged?.call(sanitizedValue);
      },
    );
  }
  
  /// Telefon field oluştur
  static Widget buildPhoneField({
    required TextEditingController controller,
    String? label,
    String? hint,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label ?? 'Telefon',
        hintText: hint ?? '+90 555 123 45 67',
        prefixIcon: const Icon(Icons.phone_outlined),
        border: const OutlineInputBorder(),
      ),
      validator: validator ?? PhoneValidator.validate,
      onChanged: (value) {
        // Giriş verilerini temizle
        final sanitizedValue = InputSanitizer.sanitizeText(value);
        if (sanitizedValue != value) {
          controller.text = sanitizedValue;
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: sanitizedValue.length),
          );
        }
        onChanged?.call(sanitizedValue);
      },
    );
  }
  
  /// İsim field oluştur
  static Widget buildNameField({
    required TextEditingController controller,
    String? label,
    String? hint,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label ?? 'İsim',
        hintText: hint ?? 'Adınız ve soyadınız',
        prefixIcon: const Icon(Icons.person_outlined),
        border: const OutlineInputBorder(),
      ),
      validator: validator ?? NameValidator.validate,
      onChanged: (value) {
        // Giriş verilerini temizle
        final sanitizedValue = InputSanitizer.sanitizeText(value);
        if (sanitizedValue != value) {
          controller.text = sanitizedValue;
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: sanitizedValue.length),
          );
        }
        onChanged?.call(sanitizedValue);
      },
    );
  }
  
  /// Mesaj field oluştur
  static Widget buildMessageField({
    required TextEditingController controller,
    String? label,
    String? hint,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool enabled = true,
    int maxLines = 5,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label ?? 'Mesaj',
        hintText: hint ?? 'Mesajınızı buraya yazın...',
        prefixIcon: const Icon(Icons.message_outlined),
        border: const OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      validator: validator ?? MessageValidator.validate,
      onChanged: (value) {
        // Giriş verilerini temizle
        final sanitizedValue = InputSanitizer.sanitizeText(value);
        if (sanitizedValue != value) {
          controller.text = sanitizedValue;
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: sanitizedValue.length),
          );
        }
        onChanged?.call(sanitizedValue);
      },
    );
  }
  
  /// Şifre field oluştur
  static Widget buildPasswordField({
    required TextEditingController controller,
    String? label,
    String? hint,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool enabled = true,
    bool obscureText = true,
    void Function()? onToggleVisibility,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: label ?? 'Şifre',
        hintText: hint ?? 'Şifrenizi girin',
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: onToggleVisibility,
        ),
        border: const OutlineInputBorder(),
      ),
      validator: validator ?? PasswordValidator.validate,
      onChanged: (value) {
        // Giriş verilerini temizle
        final sanitizedValue = InputSanitizer.sanitizeText(value);
        if (sanitizedValue != value) {
          controller.text = sanitizedValue;
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: sanitizedValue.length),
          );
        }
        onChanged?.call(sanitizedValue);
      },
    );
  }
}

/// 🎯 Form Controller Helper
class FormControllerHelper {
  /// Form controller'ları oluştur
  static Map<String, TextEditingController> createControllers({
    List<String> fields = const ['name', 'email', 'phone', 'message'],
  }) {
    final controllers = <String, TextEditingController>{};
    
    for (final field in fields) {
      controllers[field] = TextEditingController();
    }
    
    return controllers;
  }
  
  /// Form controller'ları temizle
  static void clearControllers(Map<String, TextEditingController> controllers) {
    for (final controller in controllers.values) {
      controller.clear();
    }
  }
  
  /// Form controller'ları dispose et
  static void disposeControllers(Map<String, TextEditingController> controllers) {
    for (final controller in controllers.values) {
      controller.dispose();
    }
  }
  
  /// Form verilerini al
  static Map<String, String> getFormData(Map<String, TextEditingController> controllers) {
    final data = <String, String>{};
    
    for (final entry in controllers.entries) {
      data[entry.key] = entry.value.text;
    }
    
    return data;
  }
  
  /// Form verilerini set et
  static void setFormData(
    Map<String, TextEditingController> controllers,
    Map<String, String> data,
  ) {
    for (final entry in data.entries) {
      if (controllers.containsKey(entry.key)) {
        controllers[entry.key]!.text = entry.value;
      }
    }
  }
}

/// 🎯 Form Validation Helper
class FormValidationHelper {
  /// Form'u doğrula
  static ValidationResult validateForm(
    Map<String, TextEditingController> controllers,
  ) {
    final formData = FormControllerHelper.getFormData(controllers);
    return FormValidator.validateForm(formData);
  }
  
  /// Tek field doğrula
  static String? validateField(String fieldName, String value) {
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
      default:
        return null;
    }
  }
  
  /// Tüm field'ları doğrula
  static Map<String, String?> validateAllFields(
    Map<String, TextEditingController> controllers,
  ) {
    final errors = <String, String?>{};
    
    for (final entry in controllers.entries) {
      final error = validateField(entry.key, entry.value.text);
      if (error != null) {
        errors[entry.key] = error;
      }
    }
    
    return errors;
  }
}

/// 🎯 Form Sanitization Helper
class FormSanitizationHelper {
  /// Form verilerini temizle
  static Map<String, String> sanitizeFormData(
    Map<String, TextEditingController> controllers,
  ) {
    final sanitizedData = <String, String>{};
    
    for (final entry in controllers.entries) {
      final sanitizedValue = InputSanitizer.sanitizeText(entry.value.text);
      sanitizedData[entry.key] = sanitizedValue;
    }
    
    return sanitizedData;
  }
  
  /// Tek field temizle
  static String sanitizeField(String value) {
    return InputSanitizer.sanitizeText(value);
  }
  
  /// Güvenlik kontrolü yap
  static bool isFormSecure(Map<String, TextEditingController> controllers) {
    for (final controller in controllers.values) {
      if (!InputSanitizer.isSecure(controller.text)) {
        return false;
      }
    }
    return true;
  }
}

/// 🎯 Form State Helper
class FormStateHelper {
  /// Form state'i yönet
  static ValueNotifier<bool> createFormState() {
    return ValueNotifier<bool>(false);
  }
  
  /// Form state'i güncelle
  static void updateFormState(ValueNotifier<bool> formState, bool isValid) {
    formState.value = isValid;
  }
  
  /// Form state'i dinle
  static void listenToFormState(
    ValueNotifier<bool> formState,
    void Function(bool) listener,
  ) {
    formState.addListener(() => listener(formState.value));
  }
}
