/// 🚀 Get Project By ID Use Case - ID'ye göre proje getirme use case'i
///
/// Bu sınıf, ID'ye göre proje getirme iş mantığını yönetir.
library;

import '../entities/project_entity.dart';
import '../repositories/project_repository.dart';

class GetProjectByIdUseCase {
  final ProjectRepository _repository;

  const GetProjectByIdUseCase(this._repository);

  /// ID'ye göre proje getir
  Future<ProjectEntity> call(String id) async {
    return await _repository.getProjectById(id);
  }
}
