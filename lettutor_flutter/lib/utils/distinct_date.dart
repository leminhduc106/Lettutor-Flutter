List<DateTime> getDistinctDate(List<DateTime> dates) {
  List<DateTime> distinctDates = [];
  bool isDuplicate = false;

  for (DateTime d1 in dates) {
    isDuplicate = false;
    for (DateTime d2 in distinctDates) {
      if (d1.day == d2.day && d1.month == d2.month && d1.year == d2.year) {
        isDuplicate = true;
        break;
      }
    }

    if (isDuplicate == false) {
      distinctDates.add(d1);
    }
  }

  return distinctDates;
}
