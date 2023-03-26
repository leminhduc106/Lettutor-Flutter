import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';

class CustomNoTitleAlertDialog extends StatelessWidget {
  const CustomNoTitleAlertDialog(BuildContext context,
      {Key? key,
      required this.content,
      required this.cancelBtnTitle,
      required this.okBtnTitle,
      required this.onCancelled,
      required this.onContinued})
      : super(key: key);

  final String content;
  final String cancelBtnTitle;
  final String okBtnTitle;
  final VoidCallback onCancelled;
  final VoidCallback onContinued;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content:
          Text(content, style: BaseTextStyle.body2(color: BaseColor.black)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextButton(
                  onPressed: onCancelled,
                  child: Text(cancelBtnTitle,
                      style: BaseTextStyle.body2(color: BaseColor.red),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis)),
            ),
            Expanded(
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
