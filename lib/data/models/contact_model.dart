/// 📧 Contact Model - İletişim model'i
///
/// Bu sınıf, iletişim verilerini JSON ile dönüştürür.
library;

import '../../domain/entities/contact_entity.dart';

class ContactModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String subject;
  final String message;
  final String? company;
  final String? budget;
  final String? timeline;
  final String? preferredContactMethod;
  final DateTime createdAt;
  final bool isRead;

  const ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.subject,
    required this.message,
    this.company,
    this.budget,
    this.timeline,
    this.preferredContactMethod,
    required this.createdAt,
    required this.isRead,
  });

  /// JSON'dan model oluştur
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      subject: json['subject'] as String,
      message: json['message'] as String,
      company: json['company'] as String?,
      budget: json['budget'] as String?,
      timeline: json['timeline'] as String?,
      preferredContactMethod: json['preferredContactMethod'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool,
    );
  }

  /// Model'i JSON'a çevir
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'subject': subject,
      'message': message,
      'company': company,
      'budget': budget,
      'timeline': timeline,
      'preferredContactMethod': preferredContactMethod,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  /// Entity'ye dönüştür
  ContactEntity toEntity() {
    return ContactEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      subject: subject,
      message: message,
      company: company,
      budget: budget,
      timeline: timeline,
      preferredContactMethod: preferredContactMethod,
      createdAt: createdAt,
      isRead: isRead,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ContactModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ContactModel(id: $id, name: $name, email: $email)';
  }
}


