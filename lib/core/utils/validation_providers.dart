import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'validators.dart';
import 'input_sanitizer.dart';
import 'form_helpers.dart';

/// 🎯 Validation Providers
/// Form validation için Riverpod provider'lar

/// 📝 Form State Provider
final formStateProvider = StateNotifierProvider<FormStateNotifier, FormState>((ref) {
  return FormStateNotifier();
});

/// 📝 Form State
class FormState {
  final Map<String, String> values;
  final Map<String, String?> errors;
  final bool isValid;
  final bool isDirty;
  final bool isSubmitting;
  
  FormState({
    this.values = const {},
    this.errors = const {},
    this.isValid = false,
    this.isDirty = false,
    this.isSubmitting = false,
  });
  
  FormState copyWith({
    Map<String, String>? values,
    Map<String, String?>? errors,
    bool? isValid,
    bool? isDirty,
    bool? isSubmitting,
  }) {
    return FormState(
      values: values ?? this.values,
      errors: errors ?? this.errors,
      isValid: isValid ?? this.isValid,
      isDirty: isDirty ?? this.isDirty,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

/// 📝 Form State Notifier
class FormStateNotifier extends StateNotifier<FormState> {
  FormStateNotifier() : super(FormState());
  
  /// Field değerini güncelle
  void updateField(String fieldName, String value) {
    final sanitizedValue = InputSanitizer.sanitizeText(value);
    final newValues = Map<String, String>.from(state.values);
    newValues[fieldName] = sanitizedValue;
    
    // Hata kontrolü
    final error = _validateField(fieldName, sanitizedValue);
    final newErrors = Map<String, String?>.from(state.errors);
    newErrors[fieldName] = error;
    
    // Form geçerliliği
    final isValid = _validateForm(newValues, newErrors);
    
    state = state.copyWith(
      values: newValues,
      errors: newErrors,
      isValid: isValid,
      isDirty: true,
    );
  }
  
  /// Field'ı temizle
  void clearField(String fieldName) {
    final newValues = Map<String, String>.from(state.values);
    newValues.remove(fieldName);
    
    final newErrors = Map<String, String?>.from(state.errors);
    newErrors.remove(fieldName);
    
    final isValid = _validateForm(newValues, newErrors);
    
    state = state.copyWith(
      values: newValues,
      errors: newErrors,
      isValid: isValid,
      isDirty: true,
    );
  }
  
  /// Tüm form'u temizle
  void clearForm() {
    state = FormState();
  }
  
  /// Form'u doğrula
  void validateForm() {
    final newErrors = <String, String?>{};
    
    for (final entry in state.values.entries) {
      final error = _validateField(entry.key, entry.value);
      if (error != null) {
        newErrors[entry.key] = error;
      }
    }
    
    final isValid = _validateForm(state.values, newErrors);
    
    state = state.copyWith(
      errors: newErrors,
      isValid: isValid,
    );
  }
  
  /// Form'u gönder
  Future<void> submitForm() async {
    if (!state.isValid) {
      validateForm();
      return;
    }
    
    state = state.copyWith(isSubmitting: true);
    
    try {
      // Form gönderme işlemi burada yapılacak
      await Future.delayed(const Duration(seconds: 1)); // Simülasyon
      
      // Başarılı gönderim
      state = FormState(); // Form'u sıfırla
    } catch (e) {
      // Hata durumu
      state = state.copyWith(isSubmitting: false);
    }
  }
  
  /// Field doğrulama
  String? _validateField(String fieldName, String value) {
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
  
  /// Form doğrulama
  bool _validateForm(Map<String, String> values, Map<String, String?> errors) {
    // Tüm gerekli field'lar dolu mu?
    final requiredFields = ['name', 'email', 'message'];
    for (final field in requiredFields) {
      if (!values.containsKey(field) || values[field]!.isEmpty) {
        return false;
      }
    }
    
    // Hata var mı?
    for (final error in errors.values) {
      if (error != null) {
        return false;
      }
    }
    
    return true;
  }
}

/// 📝 Field Provider
final fieldProvider = StateNotifierProvider.family<FieldNotifier, FieldState, String>((ref, fieldName) {
  return FieldNotifier(fieldName);
});

/// 📝 Field State
class FieldState {
  final String value;
  final String? error;
  final bool isValid;
  final bool isDirty;
  final bool isFocused;
  
  FieldState({
    this.value = '',
    this.error,
    this.isValid = false,
    this.isDirty = false,
    this.isFocused = false,
  });
  
  FieldState copyWith({
    String? value,
    String? error,
    bool? isValid,
    bool? isDirty,
    bool? isFocused,
  }) {
    return FieldState(
      value: value ?? this.value,
      error: error ?? this.error,
      isValid: isValid ?? this.isValid,
      isDirty: isDirty ?? this.isDirty,
      isFocused: isFocused ?? this.isFocused,
    );
  }
}

/// 📝 Field Notifier
class FieldNotifier extends StateNotifier<FieldState> {
  final String fieldName;
  
  FieldNotifier(this.fieldName) : super(FieldState());
  
  /// Değer güncelle
  void updateValue(String value) {
    final sanitizedValue = InputSanitizer.sanitizeText(value);
    final error = _validateField(sanitizedValue);
    final isValid = error == null;
    
    state = state.copyWith(
      value: sanitizedValue,
      error: error,
      isValid: isValid,
      isDirty: true,
    );
  }
  
  /// Focus durumu güncelle
  void updateFocus(bool isFocused) {
    state = state.copyWith(isFocused: isFocused);
  }
  
  /// Field'ı temizle
  void clear() {
    state = FieldState();
  }
  
  /// Field doğrulama
  String? _validateField(String value) {
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
}

/// 📝 Validation Rules Provider
final validationRulesProvider = Provider<Map<String, ValidationRule>>((ref) {
  return {
    'email': ValidationRule(
      validator: EmailValidator.validate,
      sanitizer: InputSanitizer.sanitizeText,
      required: true,
    ),
    'phone': ValidationRule(
      validator: PhoneValidator.validate,
      sanitizer: InputSanitizer.sanitizeText,
      required: true,
    ),
    'name': ValidationRule(
      validator: NameValidator.validate,
      sanitizer: InputSanitizer.sanitizeText,
      required: true,
    ),
    'message': ValidationRule(
      validator: MessageValidator.validate,
      sanitizer: InputSanitizer.sanitizeText,
      required: true,
    ),
    'password': ValidationRule(
      validator: PasswordValidator.validate,
      sanitizer: InputSanitizer.sanitizeText,
      required: true,
    ),
    'url': ValidationRule(
      validator: UrlValidator.validate,
      sanitizer: InputSanitizer.sanitizeText,
      required: false,
    ),
    'date': ValidationRule(
      validator: DateValidator.validate,
      sanitizer: InputSanitizer.sanitizeText,
      required: false,
    ),
  };
});

/// 📝 Validation Rule
class ValidationRule {
  final String? Function(String?) validator;
  final String Function(String) sanitizer;
  final bool required;
  
  ValidationRule({
    required this.validator,
    required this.sanitizer,
    this.required = false,
  });
}

/// 📝 Form Controller Provider
final formControllerProvider = Provider<Map<String, TextEditingController>>((ref) {
  return FormControllerHelper.createControllers();
});

/// 📝 Form Validation Provider
final formValidationProvider = Provider<FormValidationHelper>((ref) {
  return FormValidationHelper();
});

/// 📝 Form Sanitization Provider
final formSanitizationProvider = Provider<FormSanitizationHelper>((ref) {
  return FormSanitizationHelper();
});
