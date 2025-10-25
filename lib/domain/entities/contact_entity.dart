/// 📧 Contact Entity - İletişim entity'si
///
/// Bu sınıf, iletişim verilerini temsil eder.
class ContactEntity {
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

  const ContactEntity({
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

  /// Entity'yi kopyala
  ContactEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? subject,
    String? message,
    String? company,
    String? budget,
    String? timeline,
    String? preferredContactMethod,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return ContactEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      company: company ?? this.company,
      budget: budget ?? this.budget,
      timeline: timeline ?? this.timeline,
      preferredContactMethod:
          preferredContactMethod ?? this.preferredContactMethod,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ContactEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ContactEntity(id: $id, name: $name, email: $email)';
  }
}


