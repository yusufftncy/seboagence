/// 📧 Contact Repository Implementation - İletişim repository implementasyonu
///
/// Bu sınıf, iletişim formu işlemlerini yönetir.
library;

import '../../domain/entities/contact_entity.dart';
import '../../domain/repositories/contact_repository.dart';
import '../models/contact_model.dart';

class ContactRepositoryImpl implements ContactRepository {
  // Mock data - gerçek uygulamada API'ye gönderilecek
  static final List<ContactModel> _mockContacts = [];

  @override
  Future<void> sendContactMessage(ContactEntity contact) async {
    // Simüle edilmiş network gecikmesi
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock olarak listeye ekle
    final model = ContactModel(
      id: contact.id,
      name: contact.name,
      email: contact.email,
      phone: contact.phone,
      subject: contact.subject,
      message: contact.message,
      company: contact.company,
      budget: contact.budget,
      timeline: contact.timeline,
      preferredContactMethod: contact.preferredContactMethod,
      createdAt: contact.createdAt,
      isRead: false,
    );

    _mockContacts.add(model);
  }

  @override
  Future<List<ContactEntity>> getContactMessages() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockContacts.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> markAsRead(String contactId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _mockContacts.indexWhere(
      (contact) => contact.id == contactId,
    );
    if (index != -1) {
      final contact = _mockContacts[index];
      _mockContacts[index] = ContactModel(
        id: contact.id,
        name: contact.name,
        email: contact.email,
        phone: contact.phone,
        subject: contact.subject,
        message: contact.message,
        company: contact.company,
        budget: contact.budget,
        timeline: contact.timeline,
        preferredContactMethod: contact.preferredContactMethod,
        createdAt: contact.createdAt,
        isRead: true,
      );
    }
  }
}


