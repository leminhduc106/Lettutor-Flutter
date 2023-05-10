import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomPermissionAlertDialog extends StatelessWidget {
  const CustomPermissionAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.context})
      : super(key: key);

  final BuildContext context;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(title, style: BaseTextStyle.subtitle2(color: BaseColor.black)),
      content:
          Text(content, style: BaseTextStyle.body2(color: BaseColor.black)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actions: [
        TextButton(
            child: Text("GO TO SETTINGS",
                style: BaseTextStyle.body2(color: BaseColor.blue)),
            onPressed: () {
              Navigator.of(context).pop;
              openAppSettings();
            }),
        TextButton(
            child: Text("CANCEL",
                style: BaseTextStyle.body2(color: BaseColor.red)),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
