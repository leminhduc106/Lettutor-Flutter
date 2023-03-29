import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:lettutor_flutter/models/course/course.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

class AboutCourse extends StatelessWidget {
  const AboutCourse({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "About Course",
              style: BaseTextStyle.heading4(
                fontSize: 30,
              ),
            ),
          ),
          Text(
            course.about,
            style: BaseTextStyle.body1(
              fontSize: 17,
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 0, top: 14),
            child: Text(
              "Overview",
              style: BaseTextStyle.heading4(
                fontSize: 30,
              ),
            ),
          ),
          ListView.builder(
            itemCount: course.overview.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              String key = course.overview.keys.elementAt(index);
              return Column(
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
                        margin: const EdgeInsets.only(
                            left: 10, bottom: 10, top: 10),
                        child: Text(
                          key,
                          style: BaseTextStyle.heading2(
                            fontSize: 17,
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    course.overview[key] as String,
                    style: BaseTextStyle.body1(
                      fontSize: 17,
                      color: Colors.black54,
                    ),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 14),
            child: Text(
              "Level",
              style: BaseTextStyle.heading4(
                fontSize: 30,
              ),
            ),
          ),
          Text(
            course.level,
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
