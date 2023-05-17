import 'package:flutter/material.dart';
import 'package:lettutor_flutter/constants/learning_topics.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

class CheckBoxSpecialties extends StatefulWidget {
  CheckBoxSpecialties({Key? key}) : super(key: key);

  final List<String> _checkBoxSelected = [];

  List<String> getCheckBoxSelected() {
    return _checkBoxSelected;
  }

  @override
  _CheckBoxSpecialtiesState createState() => _CheckBoxSpecialtiesState();
}

class _CheckBoxSpecialtiesState extends State<CheckBoxSpecialties> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "My specialties are",
              style: BaseTextStyle.heading2(
                  fontSize: 14, color: BaseColor.secondaryBlue),
            ),
            const Spacer()
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children:
              kSpecialities.sublist(1).map((e) => _buildCheckBox(e)).toList(),
        )
      ],
    );
  }

  Widget _buildCheckBox(String text) {
    return ListTile(
      leading: Checkbox(
        value: widget._checkBoxSelected.contains(text),
        onChanged: (value) {
          setState(
            () {
              if (!value!) {
                widget._checkBoxSelected.remove(text);
              } else {
                widget._checkBoxSelected.add(text);
              }
            },
          );
        },
      ),
      title: Text(
        text,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
