import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

class CustomOneBtnAlertDialog extends StatelessWidget {
  const CustomOneBtnAlertDialog(
      {Key? key,
      required this.title,
      this.content,
      required this.context,
      required this.buttonTitle})
      : super(key: key);

  final BuildContext context;
  final String title;
  final String? content;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(title, style: BaseTextStyle.subtitle1(color: BaseColor.black)),
      content: (content == null)
          ? null
          : Text(content!, style: BaseTextStyle.body2(color: BaseColor.black)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actions: [
        TextButton(
            child: Text(buttonTitle,
                style: BaseTextStyle.button(color: BaseColor.red)),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
