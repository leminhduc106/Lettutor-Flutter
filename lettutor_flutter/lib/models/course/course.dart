import 'package:lettutor_mobile/src/models/tutor/tutor.dart';

class Course {
  String id;
  List<String> topics;
  String about;
  String title;
  String image;
  String level;
  List<Tutor> tutors;
  Map<String, String> overview;

  Course({
    required this.id,
    required this.topics,
    required this.about,
    required this.title,
    required this.image,
    required this.level,
    required this.tutors,
    required this.overview,
  });
}
