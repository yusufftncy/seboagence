/// 📧 Send Contact Message Use Case - İletişim mesajı gönderme use case'i
///
/// Bu sınıf, iletişim mesajı gönderme iş mantığını yönetir.
library;

import '../entities/contact_entity.dart';
import '../repositories/contact_repository.dart';

class SendContactMessageUseCase {
  final ContactRepository _repository;

  const SendContactMessageUseCase(this._repository);

  /// İletişim mesajı gönder
  Future<void> call(ContactEntity contact) async {
    return await _repository.sendContactMessage(contact);
  }
}
