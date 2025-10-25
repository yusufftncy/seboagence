/// 🚀 Project Repository Implementation - Proje repository implementasyonu
///
/// Bu sınıf, proje verilerini yönetir.
library;

import '../../domain/entities/project_entity.dart';
import '../../domain/repositories/project_repository.dart';
import '../models/project_model.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  // Mock data - gerçek uygulamada API'den gelecek
  static final List<ProjectModel> _mockProjects = [
    ProjectModel(
      id: '1',
      title: 'E-ticaret Platformu',
      description: 'Modern e-ticaret platformu geliştirme projesi',
      imageUrl: 'https://via.placeholder.com/400x300',
      category: 'Web Development',
      technologies: ['Flutter', 'Dart', 'Firebase'],
      projectUrl: 'https://example.com',
      githubUrl: 'https://github.com/example',
      clientName: 'ABC Şirketi',
      clientLogo: 'https://via.placeholder.com/100x50',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      isActive: true,
      isFeatured: true,
      sortOrder: 1,
    ),
    ProjectModel(
      id: '2',
      title: 'Mobil Uygulama',
      description: 'iOS ve Android için native mobil uygulama',
      imageUrl: 'https://via.placeholder.com/400x300',
      category: 'Mobile Development',
      technologies: ['Flutter', 'Dart', 'REST API'],
      projectUrl: 'https://example.com',
      githubUrl: 'https://github.com/example',
      clientName: 'XYZ Ltd',
      clientLogo: 'https://via.placeholder.com/100x50',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
      isActive: true,
      isFeatured: false,
      sortOrder: 2,
    ),
  ];

  @override
  Future<List<ProjectEntity>> getProjects() async {
    // Simüle edilmiş network gecikmesi
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockProjects.map((model) => model.toEntity()).toList();
  }

  @override
  Future<ProjectEntity> getProjectById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final project = _mockProjects.firstWhere(
      (project) => project.id == id,
      orElse: () => throw Exception('Proje bulunamadı: $id'),
    );
    return project.toEntity();
  }

  @override
  Future<List<ProjectEntity>> getProjectsByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockProjects
        .where((project) => project.category == category)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<List<ProjectEntity>> getFeaturedProjects() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProjects
        .where((project) => project.isFeatured)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<List<ProjectEntity>> getActiveProjects() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProjects
        .where((project) => project.isActive)
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<void> refreshProjects() async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Gerçek uygulamada API'den yeni veriler çekilecek
  }
}
