import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/schedule_model/schedule_detail_model.dart';
import 'package:lettutor_flutter/models/schedule_model/schedule_model.dart';
import 'package:lettutor_flutter/services/schedule_service.dart';
import 'package:lettutor_flutter/utils/distinct_date.dart';
import 'package:lettutor_flutter/utils/generate_ratio.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class BookingFeature extends StatefulWidget {
  const BookingFeature({Key? key, required this.tutorId}) : super(key: key);

  final String tutorId;

  @override
  State<BookingFeature> createState() => _BookingFeatureState();
}

class _BookingFeatureState extends State<BookingFeature> {
  List<Schedule> _schedules = [];
  bool isLoading = true;

  void fetchSchedules(String token) async {
    List<Schedule> res =
        await ScheduleService.getTutorSchedule(widget.tutorId!, token);
    res = res.where((schedule) {
      final now = DateTime.now();
      final start =
          DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp);
      return start.isAfter(now) ||
          (start.day == now.day &&
              start.month == now.month &&
              start.year == now.year);
    }).toList();
    res.sort((s1, s2) => s1.startTimestamp.compareTo(s2.startTimestamp));

    List<Schedule> tempRes = [];

    for (int index = 0; index < res.length; index++) {
      bool isExist = false;
      for (int index_2 = 0; index_2 < tempRes.length; index_2++) {
        final DateTime first =
            DateTime.fromMillisecondsSinceEpoch(res[index].startTimestamp);
        final DateTime second = DateTime.fromMillisecondsSinceEpoch(
            tempRes[index_2].startTimestamp);
        if (first.day == second.day &&
            first.month == second.month &&
            first.year == second.year) {
          tempRes[index_2].scheduleDetails.addAll(res[index].scheduleDetails);
          isExist = true;
          break;
        }
      }

      if (!isExist) {
        tempRes.add(res[index]);
      }
    }

    for (int index = 0; index < tempRes.length; index++) {
      tempRes[index].scheduleDetails.sort((s1, s2) => DateTime
              .fromMillisecondsSinceEpoch(s1.startPeriodTimestamp)
          .compareTo(
              DateTime.fromMillisecondsSinceEpoch(s2.startPeriodTimestamp)));
    }

    if (mounted) {
      setState(() {
        _schedules = tempRes;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final lang = Provider.of<AppProvider>(context).language;
    if (mounted && isLoading) {
      fetchSchedules(authProvider.tokens!.access.token);
    }

    Future showTutorTimePicker(Schedule schedules) {
      List<ScheduleDetails> scheduleDetails = schedules.scheduleDetails;

      return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        builder: (context) {
          return SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              lang.selectScheduleDetail,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10),
                        child: GridView.count(
                          crossAxisCount:
                              generateAsisChildRatio(constraints)[0].toInt(),
                          childAspectRatio:
                              (1 / generateAsisChildRatio(constraints)[1]),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          children: List.generate(
                            scheduleDetails.length,
                            (index) => ElevatedButton(
                              onPressed: () async {
                                if (!scheduleDetails[index].isBooked &&
                                    DateTime.fromMillisecondsSinceEpoch(
                                            scheduleDetails[index]
                                                .startPeriodTimestamp)
                                        .isAfter(DateTime.now())) {
                                  try {
                                    final res =
                                        await ScheduleService.bookAClass(
                                            scheduleDetails[index].id,
                                            authProvider.tokens!.access.token);
                                    if (res) {
                                      scheduleDetails[index].isBooked = true;
                                      Navigator.pop(context);
                                      Navigator.pop(context);

                                      // ignore: use_build_context_synchronously
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.success(
                                          message: lang.bookingSuccess,
                                          backgroundColor: Colors.green,
                                        ),
                                        showOutAnimationDuration:
                                            const Duration(milliseconds: 700),
                                        displayDuration:
                                            const Duration(milliseconds: 200),
                                      );
                                    }
                                  } catch (e) {
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                          message: e.toString()),
                                      showOutAnimationDuration:
                                          const Duration(milliseconds: 700),
                                      displayDuration:
                                          const Duration(milliseconds: 200),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: scheduleDetails[index].isBooked ||
                                        DateTime.fromMillisecondsSinceEpoch(
                                                scheduleDetails[index]
                                                    .startPeriodTimestamp)
                                            .isBefore(DateTime.now())
                                    ? Colors.grey[200]
                                    : Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  side:
                                      BorderSide(color: Colors.blue, width: 1),
                                ),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 13, bottom: 13),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(scheduleDetails[index].startPeriodTimestamp))} - ",
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                    Text(
                                      DateFormat('HH:mm').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              scheduleDetails[index]
                                                  .endPeriodTimestamp)),
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    Future showTutorDatePicker() {
      return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        isScrollControlled: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.6,
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(lang.selectSchedule,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10),
                        child: GridView.count(
                          crossAxisCount:
                              generateAsisChildRatio(constraints)[0].toInt(),
                          childAspectRatio:
                              (1 / generateAsisChildRatio(constraints)[1]),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          children: List.generate(
                            _schedules.length,
                            (index) => ElevatedButton(
                              onPressed: () {
                                showTutorTimePicker(_schedules[index]);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  side:
                                      BorderSide(color: Colors.blue, width: 1),
                                ),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 13, bottom: 13),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat.MMMEd().format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              _schedules[index]
                                                  .startTimestamp)),
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {
              showTutorDatePicker();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(1000))),
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 13, bottom: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(lang.booking,
                      style: const TextStyle(color: Colors.white))
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SvgPicture.asset("assets/svg/ic_message2.svg",
                      color: Colors.blue),
                  const Text("Message",
                      style: TextStyle(color: Colors.blue, fontSize: 14))
                ],
              ),
              Column(
                children: [
                  SvgPicture.asset("assets/svg/ic_report.svg",
                      color: Colors.blue),
                  const Text("Report",
                      style: TextStyle(color: Colors.blue, fontSize: 14))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
