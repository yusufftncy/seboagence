/// 🚀 App Router - Uygulama router'ı
///
/// Bu sınıf, uygulamanın routing yapısını yönetir.
library;

import 'package:flutter/material.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/about_page.dart';
import '../../presentation/pages/works_page.dart';
import '../../presentation/pages/conferences_page.dart';
import '../../presentation/pages/contact_page.dart';
import '../../presentation/pages/project_detail_page.dart';

class AppRouter {
  static const String home = '/';
  static const String about = '/about';
  static const String works = '/works';
  static const String conferences = '/conferences';
  static const String contact = '/contact';
  static const String projectDetail = '/project';

  /// Sayfa yönlendirme fonksiyonu
  static Widget getPage(String routeName, {String? projectId}) {
    switch (routeName) {
      case home:
        return const HomePage();
      case about:
        return const AboutPage();
      case works:
        return const WorksPage();
      case conferences:
        return const ConferencesPage();
      case contact:
        return const ContactPage();
      case projectDetail:
        return ProjectDetailPage(projectId: projectId ?? '1');
      default:
        return const HomePage();
    }
  }

  /// Sayfa geçiş animasyonu
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String routeName = settings.name ?? home;
    final String? projectId = settings.arguments as String?;

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) {
        return getPage(routeName, projectId: projectId);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Smooth fade transition
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(
        milliseconds: 200,
      ), // Smooth transition
    );
  }
}
