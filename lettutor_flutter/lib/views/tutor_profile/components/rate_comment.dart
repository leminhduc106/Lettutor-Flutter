import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_flutter/models/user_model/feedback_model.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/rate_stars/rate_stars.dart';

class RateAndComment extends StatelessWidget {
  const RateAndComment({Key? key, required this.feedback}) : super(key: key);

  final FeedBack feedback;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10, right: 15),
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: Image.network(
                      feedback.firstInfo.avatar,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Container(
                          color: Colors.amber,
                          alignment: Alignment.center,
                          child: const Text(
                            'Whoops!',
                            style: TextStyle(fontSize: 30),
                          ),
                        );
                      },
                    ),
                  )),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        feedback.firstInfo.name,
                        style: BaseTextStyle.heading2(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            RateStars(count: feedback.rating),
            Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: feedback.content.isNotEmpty
                    ? Text(feedback.content)
                    : null),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  DateFormat.yMEd().add_jm().format(
                      DateFormat("yyyy-MM-dd").parse(feedback.createdAt)),
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
