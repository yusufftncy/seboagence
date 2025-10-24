// 🎨 Feedback Widgets
// Kullanıcı geri bildirimi için widget'lar

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/branding.dart';
import '../../theme/typography.dart';
import 'feedback_states.dart';

/// 🎯 Feedback Widgets
/// Kullanıcı geri bildirimi için widget'lar

/// 📱 Feedback Overlay
class FeedbackOverlay extends ConsumerWidget {
  final Widget child;

  const FeedbackOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackState = ref.watch(feedbackProvider);

    return Stack(
      children: [
        child,
        if (feedbackState.isVisible && feedbackState.messages.isNotEmpty)
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: _buildFeedbackMessages(context, ref, feedbackState),
          ),
      ],
    );
  }

  Widget _buildFeedbackMessages(
    BuildContext context,
    WidgetRef ref,
    FeedbackState feedbackState,
  ) {
    return Column(
      children: feedbackState.messages.map((message) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildFeedbackCard(context, ref, message),
        );
      }).toList(),
    );
  }

  Widget _buildFeedbackCard(
    BuildContext context,
    WidgetRef ref,
    FeedbackMessage message,
  ) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Branding.radiusM),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Branding.radiusM),
          color: _getBackgroundColor(message.type),
        ),
        child: ListTile(
          leading: _getIcon(message.type),
          title: Text(
            message.title,
            style: AppTypography.bodyMedium.copyWith(
              color: _getTextColor(message.type),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            message.message,
            style: AppTypography.bodySmall.copyWith(
              color: _getTextColor(message.type),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.close,
              color: _getTextColor(message.type),
            ),
            onPressed: () {
              ref.read(feedbackProvider.notifier).hideMessage(message.id);
            },
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(FeedbackType type) {
    switch (type) {
      case FeedbackType.success:
        return Colors.green.shade50;
      case FeedbackType.error:
        return Colors.red.shade50;
      case FeedbackType.warning:
        return Colors.orange.shade50;
      case FeedbackType.info:
        return Colors.blue.shade50;
    }
  }

  Color _getTextColor(FeedbackType type) {
    switch (type) {
      case FeedbackType.success:
        return Colors.green.shade800;
      case FeedbackType.error:
        return Colors.red.shade800;
      case FeedbackType.warning:
        return Colors.orange.shade800;
      case FeedbackType.info:
        return Colors.blue.shade800;
    }
  }

  Icon _getIcon(FeedbackType type) {
    switch (type) {
      case FeedbackType.success:
        return const Icon(Icons.check_circle, color: Colors.green);
      case FeedbackType.error:
        return const Icon(Icons.error, color: Colors.red);
      case FeedbackType.warning:
        return const Icon(Icons.warning, color: Colors.orange);
      case FeedbackType.info:
        return const Icon(Icons.info, color: Colors.blue);
    }
  }
}

/// 📱 Toast Feedback
class ToastFeedback extends ConsumerWidget {
  final Widget child;

  const ToastFeedback({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackState = ref.watch(feedbackProvider);

    return Stack(
      children: [
        child,
        if (feedbackState.isVisible && feedbackState.messages.isNotEmpty)
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 16,
            left: 16,
            right: 16,
            child: _buildToastMessage(context, ref, feedbackState.messages.last),
          ),
      ],
    );
  }

  Widget _buildToastMessage(
    BuildContext context,
    WidgetRef ref,
    FeedbackMessage message,
  ) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Branding.radiusM),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Branding.radiusM),
          color: _getBackgroundColor(message.type),
        ),
        child: ListTile(
          leading: _getIcon(message.type),
          title: Text(
            message.title,
            style: AppTypography.bodyMedium.copyWith(
              color: _getTextColor(message.type),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            message.message,
            style: AppTypography.bodySmall.copyWith(
              color: _getTextColor(message.type),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.close,
              color: _getTextColor(message.type),
            ),
            onPressed: () {
              ref.read(feedbackProvider.notifier).hideMessage(message.id);
            },
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(FeedbackType type) {
    switch (type) {
      case FeedbackType.success:
        return Colors.green.shade50;
      case FeedbackType.error:
        return Colors.red.shade50;
      case FeedbackType.warning:
        return Colors.orange.shade50;
      case FeedbackType.info:
        return Colors.blue.shade50;
    }
  }

  Color _getTextColor(FeedbackType type) {
    switch (type) {
      case FeedbackType.success:
        return Colors.green.shade800;
      case FeedbackType.error:
        return Colors.red.shade800;
      case FeedbackType.warning:
        return Colors.orange.shade800;
      case FeedbackType.info:
        return Colors.blue.shade800;
    }
  }

  Icon _getIcon(FeedbackType type) {
    switch (type) {
      case FeedbackType.success:
        return const Icon(Icons.check_circle, color: Colors.green);
      case FeedbackType.error:
        return const Icon(Icons.error, color: Colors.red);
      case FeedbackType.warning:
        return const Icon(Icons.warning, color: Colors.orange);
      case FeedbackType.info:
        return const Icon(Icons.info, color: Colors.blue);
    }
  }
}

/// 📱 Snackbar Feedback
class SnackbarFeedback {
  /// Success snackbar göster
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Error snackbar göster
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Warning snackbar göster
  static void showWarning(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Info snackbar göster
  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

/// 📱 Dialog Feedback
class DialogFeedback {
  /// Success dialog göster
  static void showSuccess(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  /// Error dialog göster
  static void showError(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error, color: Colors.red, size: 48),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  /// Warning dialog göster
  static void showWarning(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.warning, color: Colors.orange, size: 48),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  /// Info dialog göster
  static void showInfo(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.info, color: Colors.blue, size: 48),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}
