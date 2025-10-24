/// 🚀 Project Providers - Proje provider'ları
///
/// Bu dosya, proje ile ilgili Riverpod provider'larını içerir.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/usecases/get_projects.dart';
import '../../domain/usecases/get_project_by_id.dart';
import '../../data/repositories/project_repository_impl.dart';

// Repository provider'ı
final projectRepositoryProvider = Provider((ref) => ProjectRepositoryImpl());

// Use case provider'ları
final getProjectsUseCaseProvider = Provider((ref) {
  final repository = ref.watch(projectRepositoryProvider);
  return GetProjectsUseCase(repository);
});

final getProjectByIdUseCaseProvider = Provider((ref) {
  final repository = ref.watch(projectRepositoryProvider);
  return GetProjectByIdUseCase(repository);
});

// Projeleri getiren provider
final projectsProvider = FutureProvider<List<ProjectEntity>>((ref) async {
  final getProjectsUseCase = ref.watch(getProjectsUseCaseProvider);
  return await getProjectsUseCase();
});

// Belirli bir projeyi getiren provider
final projectByIdProvider = FutureProvider.family<ProjectEntity, String>((
  ref,
  id,
) async {
  final getProjectByIdUseCase = ref.watch(getProjectByIdUseCaseProvider);
  return await getProjectByIdUseCase(id);
});

// Öne çıkan projeleri getiren provider
final featuredProjectsProvider = FutureProvider<List<ProjectEntity>>((
  ref,
) async {
  final projects = await ref.watch(projectsProvider.future);
  return projects.where((project) => project.isFeatured).toList();
});

// Aktif projeleri getiren provider
final activeProjectsProvider = FutureProvider<List<ProjectEntity>>((ref) async {
  final projects = await ref.watch(projectsProvider.future);
  return projects.where((project) => project.isActive).toList();
});

// Kategoriye göre projeleri getiren provider
final projectsByCategoryProvider =
    FutureProvider.family<List<ProjectEntity>, String>((ref, category) async {
      final projects = await ref.watch(projectsProvider.future);
      return projects.where((project) => project.category == category).toList();
    });
