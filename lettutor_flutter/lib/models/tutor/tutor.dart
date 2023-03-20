import 'package:lettutor_flutter/models/tutor/feedback.dart';
import 'package:lettutor_flutter/models/tutor/schedule.dart';

class Tutor {
  String id;
  String fullName;
  String country;
  int rate;
  String intro;
  String image;
  List<String> languages;
  Map<String, String> details;
  List<String> specialties;
  List<Schedule> dateAvailable;
  List<FeedbackRate> feedbacks = [];

  Tutor(
    this.id,
    this.fullName,
    this.country,
    this.rate,
    this.intro,
    this.image,
    this.languages,
    this.details,
    this.specialties,
    this.dateAvailable, [
    this.feedbacks = const [],
  ]);

  void setReserved(String id, bool reserved) {
    for (var i = 0; i < dateAvailable.length; i++) {
      if (dateAvailable[i].id == id) {
        dateAvailable[i].isReserved = reserved;
      }
    }
  }

  void addFeedback(FeedbackRate feedback) {
    feedbacks.add(feedback);
  }

  int getTotalStar() {
    int total = 0;
    for (var i = 0; i < feedbacks.length; i++) {
      total += feedbacks[i].rating;
    }
    return (total / feedbacks.length).round();
  }
}
