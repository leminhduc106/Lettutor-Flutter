import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';

class CustomAcceptDialog extends StatefulWidget {
  const CustomAcceptDialog({
    Key? key,
    required this.content,
    required this.context,
    required this.acceptFuction,
    this.cancelFuction,
  }) : super(key: key);
  final String content;
  final BuildContext context;
  final Function acceptFuction;
  final Function? cancelFuction;

  @override
  State<CustomAcceptDialog> createState() => _CustomAcceptDialogState();
}

class _CustomAcceptDialogState extends State<CustomAcceptDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(widget.content,
          style: BaseTextStyle.body2(color: BaseColor.black)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 100,
                  child: CustomButton.whiteBackGround(
                      isShadow: false,
                      onTap: () {
                        if (widget.cancelFuction != null) {
                          widget.cancelFuction!();
                        }

                        Navigator.pop(context);
                      },
                      content: "Cancel")),
              SizedBox(
                  width: 100,
                  child: CustomButton.common(
                      onTap: () {
                        widget.acceptFuction();
                        Navigator.pop(context);
                      },
                      isShadow: false,
                      content: "OK")),
            ],
          ),
        )
      ],
    );
  }
}
