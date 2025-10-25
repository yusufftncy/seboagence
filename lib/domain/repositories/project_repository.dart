/// 🚀 Project Repository Interface - Proje repository interface'i
///
/// Bu interface, proje verilerini yönetir.
library;

import '../entities/project_entity.dart';

abstract class ProjectRepository {
  /// Tüm projeleri getir
  Future<List<ProjectEntity>> getProjects();

  /// ID'ye göre proje getir
  Future<ProjectEntity> getProjectById(String id);

  /// Kategoriye göre projeleri getir
  Future<List<ProjectEntity>> getProjectsByCategory(String category);

  /// Öne çıkan projeleri getir
  Future<List<ProjectEntity>> getFeaturedProjects();

  /// Aktif projeleri getir
  Future<List<ProjectEntity>> getActiveProjects();

  /// Projeleri yenile
  Future<void> refreshProjects();
}



