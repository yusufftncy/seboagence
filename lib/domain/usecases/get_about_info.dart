/// ℹ️ Get About Info Use Case - Hakkımızda bilgilerini getirme use case'i
///
/// Bu sınıf, hakkımızda bilgilerini getirme iş mantığını yönetir.
library;

import '../entities/about_entity.dart';
import '../repositories/about_repository.dart';

class GetAboutInfoUseCase {
  final AboutRepository _repository;

  const GetAboutInfoUseCase(this._repository);

  /// Hakkımızda bilgilerini getir
  Future<AboutEntity> call() async {
    return await _repository.getAboutInfo();
  }
}

