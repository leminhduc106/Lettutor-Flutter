import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_flutter/data/user_sample.dart';
import 'package:lettutor_flutter/models/tutor/feedback.dart';
import 'package:lettutor_flutter/widgets/avatar_circle/avatar_circle.dart';
import 'package:lettutor_flutter/widgets/rate_stars/rate_stars.dart';

class RateAndComment extends StatelessWidget {
  const RateAndComment({Key? key, required this.feedback}) : super(key: key);

  final FeedbackRate feedback;

  @override
  Widget build(BuildContext context) {
    final user =
        UsersSample.users.where((user) => user.id == feedback.userId).first;

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
                    margin: const EdgeInsets.only(right: 10),
                    child: AvatarCircle(
                        width: 40, height: 40, source: user.image)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(fontSize: 14),
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
                  DateFormat.yMEd().add_jm().format(feedback.createdAt),
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
