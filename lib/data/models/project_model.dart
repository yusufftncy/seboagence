/// 🚀 Project Model - Proje model'i
///
/// Bu sınıf, proje verilerini JSON ile dönüştürür.
library;

import '../../domain/entities/project_entity.dart';

class ProjectModel {
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

  const ProjectModel({
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

  /// JSON'dan model oluştur
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      projectUrl: json['projectUrl'] as String,
      githubUrl: json['githubUrl'] as String,
      clientName: json['clientName'] as String,
      clientLogo: json['clientLogo'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isActive: json['isActive'] as bool,
      isFeatured: json['isFeatured'] as bool,
      sortOrder: json['sortOrder'] as int,
    );
  }

  /// Model'i JSON'a çevir
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'technologies': technologies,
      'projectUrl': projectUrl,
      'githubUrl': githubUrl,
      'clientName': clientName,
      'clientLogo': clientLogo,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
      'isFeatured': isFeatured,
      'sortOrder': sortOrder,
    };
  }

  /// Entity'ye dönüştür
  ProjectEntity toEntity() {
    return ProjectEntity(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      category: category,
      technologies: technologies,
      projectUrl: projectUrl,
      githubUrl: githubUrl,
      clientName: clientName,
      clientLogo: clientLogo,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isActive: isActive,
      isFeatured: isFeatured,
      sortOrder: sortOrder,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProjectModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ProjectModel(id: $id, title: $title, category: $category)';
  }
}


