import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lettutor_flutter/data/course_sample.dart';
import 'package:lettutor_flutter/models/course/course.dart';
import 'package:lettutor_flutter/models/tutor/tutor.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/tutor_profile/components/booking_feature.dart';
import 'package:lettutor_flutter/views/tutor_profile/components/course_card.dart';
import 'package:lettutor_flutter/views/tutor_profile/components/infor_chip.dart';
import 'package:lettutor_flutter/views/tutor_profile/components/main_info.dart';
import 'package:lettutor_flutter/views/tutor_profile/components/rate_comment.dart';
import 'package:lettutor_flutter/views/tutor_profile/components/tutor_infor.dart';
import 'package:lettutor_flutter/widgets/video_player/video_player.dart';

class TutorProfile extends StatelessWidget {
  const TutorProfile({Key? key, required this.tutor}) : super(key: key);
  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    final List<Course> courses = [];
    for (Course course in CoursesSample.courses) {
      for (Tutor tutor in course.tutors) {
        if (tutor.id == this.tutor.id) {
          courses.add(course);
        }
      }
    }
    Size size = MediaQuery.of(context).size;
    double heightSafeArea = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);
    double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio)
        .bottom;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(
          "Tutor Details",
          style: BaseTextStyle.heading2(
              fontSize: 20, color: BaseColor.secondaryBlue),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainInfo(tutor: tutor),
              BookingFeature(tutor: tutor),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TutorInfor(tutor: tutor)),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                color: Colors.transparent,
                width: safeWidth,
                height: heightSafeArea * 0.3,
                child: VideoPlayerPage(),
              ),
              const InforChips(
                  title: "Languages", chips: ["English", "Tagalogs"]),
              ListView.builder(
                itemCount: tutor.details.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  String key = tutor.details.keys.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key,
                          style: BaseTextStyle.heading2(
                              fontSize: 17, color: Colors.blue),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Text(
                            tutor.details[key] as String,
                            style: BaseTextStyle.body1(
                                fontSize: 13, color: Colors.grey[600]),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              const InforChips(title: "Specialties", chips: [
                "English for Business",
                "Conversational",
                "English for kids",
                "STARTERS",
                "MOVERS"
              ]),
              courses.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 6, top: 10),
                          child: Text(
                            "Courses",
                            style: BaseTextStyle.heading2(
                                fontSize: 17, color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: courses.length,
                            itemBuilder: (context, index) {
                              return CourseCard(course: courses[index]);
                            },
                          ),
                        ),
                      ],
                    )
                  : const Text(""),
              const SizedBox(height: 12),
              Container(
                margin: const EdgeInsets.only(bottom: 6, top: 15),
                child: Text(
                  "Rates and Comments",
                  style:
                      BaseTextStyle.heading2(fontSize: 17, color: Colors.blue),
                ),
              ),
              ListView.builder(
                itemCount: tutor.feedbacks.length,
                itemBuilder: (context, index) {
                  return RateAndComment(feedback: tutor.feedbacks[index]);
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
