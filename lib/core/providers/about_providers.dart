/// ℹ️ About Providers - Hakkımızda provider'ları
///
/// Bu dosya, hakkımızda ile ilgili Riverpod provider'larını içerir.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/about_entity.dart';
import '../../domain/usecases/get_about_info.dart';
import '../../data/repositories/about_repository_impl.dart';

// Repository provider'ı
final aboutRepositoryProvider = Provider((ref) => AboutRepositoryImpl());

// Use case provider'ı
final getAboutInfoUseCaseProvider = Provider((ref) {
  final repository = ref.watch(aboutRepositoryProvider);
  return GetAboutInfoUseCase(repository);
});

// Hakkımızda bilgilerini getiren provider
final aboutInfoProvider = FutureProvider<AboutEntity>((ref) async {
  final getAboutInfoUseCase = ref.watch(getAboutInfoUseCaseProvider);
  return await getAboutInfoUseCase();
});

