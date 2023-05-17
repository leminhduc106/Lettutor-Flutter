import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/edit_field/multiline_text_field.dart';
import 'package:provider/provider.dart';

class CVTeacher extends StatefulWidget {
  const CVTeacher({Key? key}) : super(key: key);

  @override
  _CVTeacherState createState() => _CVTeacherState();
}

class _CVTeacherState extends State<CVTeacher> {
  final TextEditingController _interests = TextEditingController();
  final TextEditingController _education = TextEditingController();
  final TextEditingController _experience = TextEditingController();
  final TextEditingController _profession = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Teacher teacher = Provider.of<Teacher>(context);
    return Column(
      children: [
        //CV
        Row(
          children: [
            Text("CV",
                style: BaseTextStyle.heading2(
                    fontSize: 14, color: BaseColor.secondaryBlue)),
            const Spacer()
          ],
        ),

        //Interests
        MultilineTextField(
          label: "Interests",
          hint:
              "Interests, hobbies, memorable life experiences, or anything else your'd like to share!",
          controller: _interests,
          onChanged: (value) {},
        ),

        //Education
        MultilineTextField(
            label: 'Education',
            hint:
                "Interests, hobbies, memorable life experiences, or anything else your'd like to share!",
            controller: _education,
            onChanged: (value) {}),

        //Experience
        MultilineTextField(
            label: "Experience",
            hint: "Enter your Experience",
            controller: _experience,
            onChanged: (value) {}),

        //Current or Previous Profession
        MultilineTextField(
            label: "Profession",
            hint: "Current or Previous Profession",
            controller: _profession,
            onChanged: (value) {}),

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
