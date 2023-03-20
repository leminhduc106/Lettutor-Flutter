import 'package:lettutor_flutter/models/user/booking.dart';
import 'package:lettutor_flutter/models/user/session.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class User {
  String id;
  final String email;
  final String fullName;
  String image;
  DateTime birthDay;
  String phone;
  String country;
  String level;
  String topicToLearn;
  List<Booking> bookingHistory = [];
  List<Session> sessionHistory = [];

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.image,
    required this.birthDay,
    required this.country,
    required this.level,
    required this.topicToLearn,
    required this.bookingHistory,
    required this.sessionHistory,
    this.phone = "",
  });

  List<Booking> getUpcomming() {
    return bookingHistory
        .where((booking) => booking.isCancelled == false)
        .toList();
  }

  int getTotalLessonTime() {
    int total = 0;

    for (Booking b in bookingHistory) {
      if (b.isCancelled == false) {
        total += b.end.difference(b.start).inMinutes;
      }
    }
    return total;
  }

  Booking? getNearestLesson() {
    List<Booking> upcoming = getUpcomming();
    upcoming.sort((a, b) => a.start.compareTo(b.start));
    return upcoming.isNotEmpty ? upcoming.first : null;
  }
}
