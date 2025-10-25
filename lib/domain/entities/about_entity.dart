/// ℹ️ About Entity - Hakkımızda entity'si
///
/// Bu sınıf, hakkımızda verilerini temsil eder.
class AboutEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String mission;
  final String vision;
  final String values;
  final List<String> achievements;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AboutEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.mission,
    required this.vision,
    required this.values,
    required this.achievements,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Entity'yi kopyala
  AboutEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? mission,
    String? vision,
    String? values,
    List<String>? achievements,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AboutEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      mission: mission ?? this.mission,
      vision: vision ?? this.vision,
      values: values ?? this.values,
      achievements: achievements ?? this.achievements,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AboutEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AboutEntity(id: $id, title: $title)';
  }
}



