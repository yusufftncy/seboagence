// 🎨 Feedback States
// Kullanıcı geri bildirimi için state management

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 🎯 Feedback Types
enum FeedbackType {
  success,
  error,
  warning,
  info,
}

/// 🎯 Feedback Message
class FeedbackMessage {
  final String id;
  final FeedbackType type;
  final String title;
  final String message;
  final Duration? duration;
  final DateTime timestamp;

  FeedbackMessage({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    this.duration,
    required this.timestamp,
  });

  FeedbackMessage copyWith({
    String? id,
    FeedbackType? type,
    String? title,
    String? message,
    Duration? duration,
    DateTime? timestamp,
  }) {
    return FeedbackMessage(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      duration: duration ?? this.duration,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

/// 🎯 Feedback State
class FeedbackState {
  final List<FeedbackMessage> messages;
  final bool isVisible;
  final String? currentMessageId;

  FeedbackState({
    this.messages = const [],
    this.isVisible = false,
    this.currentMessageId,
  });

  FeedbackState copyWith({
    List<FeedbackMessage>? messages,
    bool? isVisible,
    String? currentMessageId,
  }) {
    return FeedbackState(
      messages: messages ?? this.messages,
      isVisible: isVisible ?? this.isVisible,
      currentMessageId: currentMessageId ?? this.currentMessageId,
    );
  }
}

/// 🎯 Feedback Notifier
class FeedbackNotifier extends StateNotifier<FeedbackState> {
  FeedbackNotifier() : super(FeedbackState());

  /// Success mesajı göster
  void showSuccess(String title, String message, {Duration? duration}) {
    _showMessage(
      FeedbackType.success,
      title,
      message,
      duration: duration,
    );
  }

  /// Error mesajı göster
  void showError(String title, String message, {Duration? duration}) {
    _showMessage(
      FeedbackType.error,
      title,
      message,
      duration: duration,
    );
  }

  /// Warning mesajı göster
  void showWarning(String title, String message, {Duration? duration}) {
    _showMessage(
      FeedbackType.warning,
      title,
      message,
      duration: duration,
    );
  }

  /// Info mesajı göster
  void showInfo(String title, String message, {Duration? duration}) {
    _showMessage(
      FeedbackType.info,
      title,
      message,
      duration: duration,
    );
  }

  /// Mesaj göster
  void _showMessage(
    FeedbackType type,
    String title,
    String message, {
    Duration? duration,
  }) {
    final feedbackMessage = FeedbackMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      title: title,
      message: message,
      duration: duration ?? const Duration(seconds: 4),
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, feedbackMessage],
      isVisible: true,
      currentMessageId: feedbackMessage.id,
    );

    // Otomatik kapatma
    Future.delayed(feedbackMessage.duration!, () {
      hideMessage(feedbackMessage.id);
    });
  }

  /// Mesajı gizle
  void hideMessage(String messageId) {
    final updatedMessages = state.messages
        .where((message) => message.id != messageId)
        .toList();

    state = state.copyWith(
      messages: updatedMessages,
      isVisible: updatedMessages.isNotEmpty,
      currentMessageId: updatedMessages.isNotEmpty ? updatedMessages.last.id : null,
    );
  }

  /// Tüm mesajları temizle
  void clearAll() {
    state = FeedbackState();
  }

  /// Mevcut mesajı gizle
  void hideCurrent() {
    if (state.currentMessageId != null) {
      hideMessage(state.currentMessageId!);
    }
  }
}

/// 🎯 Feedback Provider
final feedbackProvider = StateNotifierProvider<FeedbackNotifier, FeedbackState>((ref) {
  return FeedbackNotifier();
});

/// 🎯 Feedback Manager
class FeedbackManager {
  /// Success mesajı göster
  static void showSuccess(WidgetRef ref, String title, String message, {Duration? duration}) {
    ref.read(feedbackProvider.notifier).showSuccess(title, message, duration: duration);
  }

  /// Error mesajı göster
  static void showError(WidgetRef ref, String title, String message, {Duration? duration}) {
    ref.read(feedbackProvider.notifier).showError(title, message, duration: duration);
  }

  /// Warning mesajı göster
  static void showWarning(WidgetRef ref, String title, String message, {Duration? duration}) {
    ref.read(feedbackProvider.notifier).showWarning(title, message, duration: duration);
  }

  /// Info mesajı göster
  static void showInfo(WidgetRef ref, String title, String message, {Duration? duration}) {
    ref.read(feedbackProvider.notifier).showInfo(title, message, duration: duration);
  }

  /// Mesajı gizle
  static void hideMessage(WidgetRef ref, String messageId) {
    ref.read(feedbackProvider.notifier).hideMessage(messageId);
  }

  /// Tüm mesajları temizle
  static void clearAll(WidgetRef ref) {
    ref.read(feedbackProvider.notifier).clearAll();
  }

  /// Mevcut mesajı gizle
  static void hideCurrent(WidgetRef ref) {
    ref.read(feedbackProvider.notifier).hideCurrent();
  }
}
