import 'package:lettutor_flutter/models/course_model/course_category.dart';

class Ebook {
  late String id;
  late String name;
  late String description;
  late String imageUrl;
  late String level;
  late bool visible;
  late String fileUrl;
  late String createdAt;
  late String updatedAt;
  bool? isPrivate;
  String? createdBy;
  List<CourseCategory>? categories;

  Ebook({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.level,
    required this.visible,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
    this.isPrivate,
    this.createdBy,
    this.categories,
  });

  Ebook.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    level = json['level'];
    visible = json['visible'];
    fileUrl = json['fileUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isPrivate = json['isPrivate'];
    createdBy = json['createdBy'];
    categories = json['categories'] != null
        ? (json['categories'] as List)
            .map((e) => CourseCategory.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['level'] = level;
    data['visible'] = visible;
    data['fileUrl'] = fileUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isPrivate'] = isPrivate;
    data['createdBy'] = createdBy;
    return data;
  }
}
