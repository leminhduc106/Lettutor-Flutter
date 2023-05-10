import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';

class CustomTitleAlertDialog extends StatelessWidget {
  const CustomTitleAlertDialog(BuildContext context,
      {Key? key,
      required this.title,
      required this.content,
      this.contentColor,
      required this.onCancelled,
      required this.okBtnTitle,
      required this.onContinued})
      : super(key: key);

  final String title;
  final Color? contentColor;
  final String content;
  final String okBtnTitle;
  final VoidCallback onCancelled;
  final VoidCallback onContinued;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(title, style: BaseTextStyle.subtitle1(color: BaseColor.black)),
      content: Text(content,
          style: BaseTextStyle.body2(color: contentColor ?? BaseColor.black)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 125,
              child: CustomButton.whiteBackGround(
                  onTap: onCancelled, content: "Cancel"),
            ),
            SizedBox(
              width: 125,
              child: CustomButton.common(
                onTap: onContinued,
                content: okBtnTitle,
              ),
            ),
          ],
        )
      ],
    );
  }
}
