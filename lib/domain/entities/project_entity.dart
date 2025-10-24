/// 🚀 Project Entity - Proje entity'si
///
/// Bu sınıf, proje verilerini temsil eder.
class ProjectEntity {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final List<String> technologies;
  final String projectUrl;
  final String githubUrl;
  final String clientName;
  final String clientLogo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final bool isFeatured;
  final int sortOrder;

  const ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.technologies,
    required this.projectUrl,
    required this.githubUrl,
    required this.clientName,
    required this.clientLogo,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isFeatured,
    required this.sortOrder,
  });

  /// Entity'yi kopyala
  ProjectEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? category,
    List<String>? technologies,
    String? projectUrl,
    String? githubUrl,
    String? clientName,
    String? clientLogo,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isFeatured,
    int? sortOrder,
  }) {
    return ProjectEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      technologies: technologies ?? this.technologies,
      projectUrl: projectUrl ?? this.projectUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      clientName: clientName ?? this.clientName,
      clientLogo: clientLogo ?? this.clientLogo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProjectEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ProjectEntity(id: $id, title: $title, category: $category)';
  }
}
