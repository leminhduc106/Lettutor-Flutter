import 'package:flutter/material.dart';
import 'package:lettutor_flutter/constants/learning_topics.dart';
import 'package:lettutor_flutter/constants/list_languages.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/utils/enums.dart';
import 'package:lettutor_flutter/widgets/edit_field/multi_item_select_field.dart';
import 'package:lettutor_flutter/widgets/edit_field/multiline_text_field.dart';
import 'package:provider/provider.dart';

class TeachingInfor extends StatefulWidget {
  const TeachingInfor({Key? key}) : super(key: key);

  @override
  _TeachingInforState createState() => _TeachingInforState();
}

class _TeachingInforState extends State<TeachingInfor> {
  final TextEditingController _introduction = TextEditingController();
  MenuLevel? _level;
  @override
  Widget build(BuildContext context) {
    // Teacher teacher = Provider.of<Teacher>(context);

    _introduction.text = '';
    return Column(
      children: [
        //Languages I speak
        Row(
          children: [
            Text("Languages I speak",
                style: BaseTextStyle.heading2(
                    fontSize: 14, color: BaseColor.secondaryBlue)),
            const Spacer()
          ],
        ),
        //Languages
        const SizedBox(
          height: 10,
        ),

        MultiItemSelectField(
          items: kLanguages,
          icon: Icons.language_outlined,
          onConfirm: (values) {},
          title: "Choose language",
          buttonText: "Languages",
          onTap: (value) {},
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Divider(
            height: 3,
            color: BaseColor.secondaryBlue.withOpacity(0.5),
          ),
        ),
        //Who I teach
        Row(
          children: [
            Text("Who I teach",
                style: BaseTextStyle.heading2(
                    fontSize: 14, color: BaseColor.secondaryBlue)),
            const Spacer()
          ],
        ),

        //Introduction
        MultilineTextField(
            label: "Introduction",
            hint:
                "Example: I was a doctor for 35 years and can help you practice business or medical English.",
            controller: _introduction,
            onChanged: (value) {}),

        //My specialties are
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Text(
              "My specialities are",
              style: BaseTextStyle.heading2(
                  fontSize: 14, color: BaseColor.secondaryBlue),
            ),
            const Spacer()
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        MultiItemSelectField(
            items: kSpecialities.sublist(1),
            icon: Icons.bookmark_border_rounded,
            title: "Choose specialities",
            buttonText: "My specialties are",
            onConfirm: (values) {},
            onTap: (value) {}),

        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "I am best at teaching students who are",
                style: BaseTextStyle.heading2(
                    fontSize: 14, color: BaseColor.secondaryBlue),
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),

        //I am best at teaching students who are
        ListTile(
          title: const Text('Beginer'),
          leading: Radio<MenuLevel>(
            value: MenuLevel.beginer,
            groupValue: _level,
            onChanged: (MenuLevel? value) {
              setState(() {
                _level = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Intermediate'),
          leading: Radio<MenuLevel>(
            value: MenuLevel.intermediate,
            groupValue: _level,
            onChanged: (MenuLevel? value) {
              setState(() {
                _level = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Advanced'),
          leading: Radio<MenuLevel>(
            value: MenuLevel.advanced,
            groupValue: _level,
            onChanged: (MenuLevel? value) {
              setState(() {
                _level = value;
              });
            },
          ),
        ),

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
