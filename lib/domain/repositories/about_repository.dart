/// ℹ️ About Repository Interface - Hakkımızda repository interface'i
///
/// Bu interface, hakkımızda verilerini yönetir.
import '../entities/about_entity.dart';

abstract class AboutRepository {
  /// Hakkımızda bilgilerini getir
  Future<AboutEntity> getAboutInfo();

  /// Hakkımızda bilgilerini yenile
  Future<void> refreshAboutInfo();
}
