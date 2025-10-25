/// 🚀 Get Projects Use Case - Projeleri getirme use case'i
///
/// Bu sınıf, projeleri getirme iş mantığını yönetir.
library;

import '../entities/project_entity.dart';
import '../repositories/project_repository.dart';

class GetProjectsUseCase {
  final ProjectRepository _repository;

  const GetProjectsUseCase(this._repository);

  /// Tüm projeleri getir
  Future<List<ProjectEntity>> call() async {
    return await _repository.getProjects();
  }
}


