/// ℹ️ About Model - Hakkımızda model'i
///
/// Bu sınıf, hakkımızda verilerini JSON ile dönüştürür.
import '../../domain/entities/about_entity.dart';

class AboutModel {
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

  const AboutModel({
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

  /// JSON'dan model oluştur
  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      mission: json['mission'] as String,
      vision: json['vision'] as String,
      values: json['values'] as String,
      achievements: List<String>.from(json['achievements'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Model'i JSON'a çevir
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'mission': mission,
      'vision': vision,
      'values': values,
      'achievements': achievements,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Entity'ye dönüştür
  AboutEntity toEntity() {
    return AboutEntity(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      mission: mission,
      vision: vision,
      values: values,
      achievements: achievements,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AboutModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AboutModel(id: $id, title: $title)';
  }
}
