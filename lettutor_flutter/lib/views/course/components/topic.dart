import 'package:flutter/material.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/models/course_model/course_model.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:provider/provider.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;

class TopicCourse extends StatelessWidget {
  const TopicCourse({Key? key, required this.course}) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppProvider>(context).language;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lang.topic,
            style: BaseTextStyle.heading4(
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            itemCount: course.topics.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  routes.courseTopicPDF,
                  arguments: {
                    "url": course.topics[index].nameFile,
                    "title": course.topics[index].name,
                  },
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 10,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.indigo[200],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              (index + 1).toString(),
                              style: BaseTextStyle.heading2(
                                  fontSize: 24, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          course.topics[index].name,
                          style: BaseTextStyle.heading4(fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
