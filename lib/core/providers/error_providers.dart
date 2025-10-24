import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 🚨 Error Providers
/// Hata yönetimi için provider'lar

/// 📊 Error provider
final errorProvider = StateNotifierProvider<ErrorNotifier, ErrorState>((ref) {
  return ErrorNotifier();
});

/// 🚨 Error state
class ErrorState {
  final List<AppError> errors;
  final bool hasError;
  final String? lastError;
  
  ErrorState({
    this.errors = const [],
    this.hasError = false,
    this.lastError,
  });
  
  ErrorState copyWith({
    List<AppError>? errors,
    bool? hasError,
    String? lastError,
  }) {
    return ErrorState(
      errors: errors ?? this.errors,
      hasError: hasError ?? this.hasError,
      lastError: lastError ?? this.lastError,
    );
  }
}

/// 🚨 App error sınıfı
class AppError {
  final String message;
  final String? code;
  final DateTime timestamp;
  final ErrorType type;
  final StackTrace? stackTrace;
  
  AppError({
    required this.message,
    this.code,
    required this.timestamp,
    this.type = ErrorType.unknown,
    this.stackTrace,
  });
}

/// 🚨 Error types
enum ErrorType {
  network,
  server,
  validation,
  authentication,
  permission,
  unknown,
}

/// 🚨 Error notifier
class ErrorNotifier extends StateNotifier<ErrorState> {
  ErrorNotifier() : super(ErrorState());
  
  /// Hata ekle
  void addError(AppError error) {
    final newErrors = List<AppError>.from(state.errors);
    newErrors.add(error);
    state = state.copyWith(
      errors: newErrors,
      hasError: true,
      lastError: error.message,
    );
  }
  
  /// Hata temizle
  void clearErrors() {
    state = state.copyWith(
      errors: [],
      hasError: false,
      lastError: null,
    );
  }
  
  /// Son hatayı temizle
  void clearLastError() {
    if (state.errors.isNotEmpty) {
      final newErrors = List<AppError>.from(state.errors);
      newErrors.removeLast();
      state = state.copyWith(
        errors: newErrors,
        hasError: newErrors.isNotEmpty,
        lastError: newErrors.isNotEmpty ? newErrors.last.message : null,
      );
    }
  }
  
  /// Network hatası ekle
  void addNetworkError(String message, {String? code}) {
    addError(AppError(
      message: message,
      code: code,
      timestamp: DateTime.now(),
      type: ErrorType.network,
    ));
  }
  
  /// Server hatası ekle
  void addServerError(String message, {String? code}) {
    addError(AppError(
      message: message,
      code: code,
      timestamp: DateTime.now(),
      type: ErrorType.server,
    ));
  }
  
  /// Validation hatası ekle
  void addValidationError(String message, {String? code}) {
    addError(AppError(
      message: message,
      code: code,
      timestamp: DateTime.now(),
      type: ErrorType.validation,
    ));
  }
}
