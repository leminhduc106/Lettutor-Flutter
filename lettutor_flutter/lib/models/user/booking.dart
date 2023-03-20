import 'package:lettutor_flutter/models/tutor/tutor.dart';

class Booking {
  String id;
  Tutor tutor;
  DateTime start;
  DateTime end;
  late bool isCancelled;
  String idSchedule;

  Booking(
      {required this.id,
      required this.tutor,
      required this.start,
      required this.end,
      required this.idSchedule}) {
    isCancelled = false;
  }
}
