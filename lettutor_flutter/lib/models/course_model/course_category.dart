class CourseCategory {
  late String id;
  late String title;
  String? description;
  late String key;
  late String createdAt;
  late String updatedAt;

  CourseCategory({
    required this.id,
    required this.title,
    this.description,
    required this.key,
    required this.createdAt,
    required this.updatedAt,
  });

  CourseCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    key = json['key'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['key'] = key;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
