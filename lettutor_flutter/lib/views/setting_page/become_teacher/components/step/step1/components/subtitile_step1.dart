import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

class SubtitleStep1 extends StatelessWidget {
  const SubtitleStep1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Set up your tutor profile",
              style: BaseTextStyle.heading2(
                  fontSize: 14, color: BaseColor.secondaryBlue),
            ),
            const Spacer()
          ],
        ),
        const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              """Your tutor profile is your chance to market yourself to students on Tutoring. You can make edits later on your profile settings page.

New students may browse tutor profiles to find a tutor that fits their learning goals and personality. Returning students may use the tutor profiles to find tutors they've had great experiences with already.""",
              textAlign: TextAlign.justify,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Divider(
            height: 3,
            color: BaseColor.secondaryBlue.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
