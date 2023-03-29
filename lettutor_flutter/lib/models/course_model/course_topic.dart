class CourseTopic {
  late String id;
  late String courseId;
  late int orderCourse;
  late String name;
  late String nameFile;
  String? description;
  String? videoUrl;
  late String createdAt;
  late String updatedAt;

  CourseTopic({
    required this.id,
    required this.courseId,
    required this.orderCourse,
    required this.name,
    required this.nameFile,
    this.description,
    this.videoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  CourseTopic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['courseId'];
    orderCourse = json['orderCourse'];
    name = json['name'];
    nameFile = json['nameFile'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['courseId'] = courseId;
    data['orderCourse'] = orderCourse;
    data['name'] = name;
    data['nameFile'] = nameFile;
    data['description'] = description;
    data['videoUrl'] = videoUrl;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
