class Schedule {
  String id;
  DateTime start;
  DateTime end;
  bool isReserved = false;

  Schedule({required this.id, required this.start, required this.end});
}
