import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/models/course_model/course_model.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:provider/provider.dart';

class AboutCourse extends StatelessWidget {
  AboutCourse({Key? key, required this.course}) : super(key: key);

  final Course course;
  final listLevels = {
    "0": "Any level",
    "1": "Beginner",
    "2": "High Beginner",
    "3": "Pre-Intermediate",
    "4": "Intermediate",
    "5": "Upper-Intermediate",
    "6": "Advanced",
    "7": "Proficiency"
  };

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppProvider>(context).language;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              lang.aboutCourse,
              style: BaseTextStyle.heading4(
                fontSize: 30,
              ),
            ),
          ),
          Text(
            course.description,
            style: BaseTextStyle.body1(
              fontSize: 17,
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0, top: 14),
            child: Text(
              lang.overview,
              style: BaseTextStyle.heading4(
                fontSize: 30,
              ),
            ),
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.help_outline,
                    color: Colors.red,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    margin:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    child: Text(
                      lang.why,
                      style: BaseTextStyle.heading2(
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                course.reason,
                style: BaseTextStyle.body1(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.help_outline,
                    color: Colors.red,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    margin:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    child: Text(
                      lang.what,
                      style: BaseTextStyle.heading2(
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                course.purpose,
                style: BaseTextStyle.body1(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 14),
            child: Text(
              lang.level,
              style: BaseTextStyle.heading4(
                fontSize: 30,
              ),
            ),
          ),
          Text(
            listLevels[course.level] ?? "Any level",
            style: BaseTextStyle.body1(
              fontSize: 17,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
