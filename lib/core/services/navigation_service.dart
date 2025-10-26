/// 🧭 Navigation Service
///
/// Bu servis, uygulama genelinde navigation işlemlerini yönetir.
library;

import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = 
      GlobalKey<NavigatorState>();

  static NavigatorState? get currentState => navigatorKey.currentState;

  static BuildContext? get currentContext => currentState?.context;

  /// Ana sayfaya git
  static void goToHome() {
    if (currentState != null) {
      currentState!.pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  /// Hakkımızda sayfasına git
  static void goToAbout() {
    if (currentState != null) {
      currentState!.pushNamed('/about');
    }
  }

  /// İletişim sayfasına git
  static void goToContact() {
    if (currentState != null) {
      currentState!.pushNamed('/contact');
    }
  }

  /// Proje detayına git
  static void goToProject(String projectId) {
    if (currentState != null) {
      currentState!.pushNamed('/project/$projectId');
    }
  }

  /// Konferans detayına git
  static void goToConference(String conferenceId) {
    if (currentState != null) {
      currentState!.pushNamed('/conference/$conferenceId');
    }
  }

  /// Tüm konferanslar sayfasına git
  static void goToAllConferences() {
    if (currentState != null) {
      currentState!.pushNamed('/conferences');
    }
  }

  /// Geri git
  static void goBack() {
    if (currentState != null && currentState!.canPop()) {
      currentState!.pop();
    }
  }

  /// Modal göster
  static Future<T?> showModal<T>(Widget modal) {
    if (currentContext != null) {
      return showModalBottomSheet<T>(
        context: currentContext!,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => modal,
      );
    }
    return Future.value(null);
  }

  /// Dialog göster
  static Future<T?> showCustomDialog<T>(Widget dialog) {
    if (currentContext != null) {
      return showDialog<T>(
        context: currentContext!,
        builder: (context) => dialog,
      );
    }
    return Future.value(null);
  }

  /// Snackbar göster
  static void showSnackBar(String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (currentContext != null) {
      ScaffoldMessenger.of(currentContext!).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          duration: duration,
        ),
      );
    }
  }
}