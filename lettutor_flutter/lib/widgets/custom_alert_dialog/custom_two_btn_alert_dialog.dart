import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';

class CustomTwoBtnAlertDialog extends StatelessWidget {
  const CustomTwoBtnAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.context,
      required this.onContinue,
      required this.backBtnTitle,
      required this.continueBtnTitle})
      : super(key: key);

  final BuildContext context;
  final String title;
  final String content;
  final VoidCallback onContinue;
  final String backBtnTitle;
  final String continueBtnTitle;

  @override
  Widget build(BuildContext context) {
    double safeButtonWidth = MediaQuery.of(context).size.width - 100;
    return AlertDialog(
      title: Text(title, style: BaseTextStyle.heading2(color: BaseColor.red)),
      content:
          Text(content, style: BaseTextStyle.body2(color: BaseColor.black)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: safeButtonWidth * 0.5,
              child: CustomButton.common(
                onTap: () {
                  Navigator.of(context).pop();
                },
                content: backBtnTitle,
              ),
            ),
            SizedBox(
              width: safeButtonWidth * 0.5,
              child: TextButton(
                  onPressed: onContinue,
                  child: Text(continueBtnTitle,
                      style: BaseTextStyle.body2(color: BaseColor.red),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis)),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
