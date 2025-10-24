/// 📧 Contact Repository Interface - İletişim repository interface'i
///
/// Bu interface, iletişim verilerini yönetir.
import '../entities/contact_entity.dart';

abstract class ContactRepository {
  /// İletişim mesajı gönder
  Future<void> sendContactMessage(ContactEntity contact);

  /// İletişim mesajlarını getir
  Future<List<ContactEntity>> getContactMessages();

  /// Mesajı okundu olarak işaretle
  Future<void> markAsRead(String contactId);
}
