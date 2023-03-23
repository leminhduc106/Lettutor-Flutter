import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/custom_textfield/custom_textfield.dart';

class CustomModalSheet {
  static Future<void> buildWarningBottom({
    required BuildContext context,
    Color? backgroundColor,
    Color? barrierColor,
    required String content,
    required VoidCallback onTappedCancel,
    required VoidCallback onTappedOk,
  }) {
    return showModalBottomSheet(
        backgroundColor: backgroundColor ?? Colors.white,
        barrierColor: barrierColor ?? Colors.black.withOpacity(0.5),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 10),
              height: MediaQuery.of(context).size.height * 0.4,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Center(
                        child: Text("Warning",
                            style: BaseTextStyle.subtitle1(color: Colors.red)),
                      ),
                      const SizedBox(height: 32),
                      Text(content,
                          overflow: TextOverflow.visible,
                          style: BaseTextStyle.body2(color: Colors.black)),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: CustomButton.common(
                                  onTap: onTappedCancel,
                                  content: "Cancel",
                                ),
                              ),
                              TextButton(
                                  onPressed: onTappedOk,
                                  child: Text(
                                    "Confirm Delete",
                                    style:
                                        BaseTextStyle.button(color: Colors.red),
                                  )),
                            ]),
                      ),
                    ]),
              ));
        });
  }

  static Future<void> buildConfirmDeleteBottom({
    required BuildContext context,
    Color? backgroundColor,
    Color? barrierColor,
    required VoidCallback onTappedCancel,
    required Function(String, String) onTappedOk,
  }) {
    final _phoneController = TextEditingController();
    final _passwordController = TextEditingController();
    return showModalBottomSheet(
        backgroundColor: backgroundColor ?? Colors.white,
        barrierColor: barrierColor ?? Colors.black.withOpacity(0.5),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.only(left: 32, right: 32, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 16),
                        Text("Do you really want to delete your account?",
                            style: BaseTextStyle.subtitle1(color: Colors.red)),
                        const SizedBox(height: 32),
                        Text(
                            "This action will delete your account and cannot be undone. Please enter your phone number and password to confirm:",
                            overflow: TextOverflow.visible,
                            style: BaseTextStyle.body2(color: Colors.black)),
                        const SizedBox(height: 32),
                        CustomTextField.common(
                          textEditingController: _phoneController,
                          onChanged: (_) {},
                          required: true,
                          labelText: "Phone",
                          hintText: "Enter phone number",
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 8),
                        CustomTextField.common(
                            textEditingController: _passwordController,
                            onChanged: (_) {},
                            required: true,
                            labelText: "Password",
                            hintText: "Enter password",
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            isObscured: true),
                        const SizedBox(height: 40),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton.common(
                                onTap: onTappedCancel,
                                content: "Cancel",
                              ),
                              TextButton(
                                onPressed: () {
                                  onTappedOk(_phoneController.text,
                                      _passwordController.text);
                                },
                                child: Text(
                                  "Confirm Delete",
                                  style:
                                      BaseTextStyle.button(color: Colors.red),
                                ),
                              ),
                            ]),
                        SizedBox(
                            height: EdgeInsets.fromWindowPadding(
                                        WidgetsBinding
                                            .instance.window.viewInsets,
                                        WidgetsBinding
                                            .instance.window.devicePixelRatio)
                                    .bottom +
                                32),
                      ]),
                )),
          );
        });
  }

  static Future<void> buildChoosePhotoBottom({
    required BuildContext context,
    required VoidCallback onTappedCamera,
    required VoidCallback onTappedGallery,
  }) {
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        barrierColor: Colors.black.withOpacity(0.5),
        constraints: BoxConstraints(
            maxHeight: 150 + MediaQuery.of(context).padding.bottom),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 6),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                GestureDetector(
                    onTap: onTappedCamera,
                    child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 16, bottom: 12),
                        child: Row(
                          children: [
                            Image.asset('assets/icons/action/icon_camera.png',
                                width: 24, height: 24),
                            const SizedBox(width: 12),
                            Text("Open Camera",
                                style: BaseTextStyle.subtitle1(
                                  color: BaseColor.black,
                                ))
                          ],
                        ))),
                const Divider(),
                GestureDetector(
                    onTap: onTappedGallery,
                    child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(top: 16, bottom: 12),
                        child: Row(
                          children: [
                            Image.asset('assets/icons/action/icon_library.png',
                                width: 24, height: 24),
                            const SizedBox(width: 12),
                            Text("Choose from Gallery",
                                style: BaseTextStyle.subtitle1(
                                  color: BaseColor.black,
                                ))
                          ],
                        )))
              ]));
        });
  }

  static Future<void> buildAddOptionBottomWithTwoBtn({
    required BuildContext context,
    Color? backgroundColor,
    Color? barrierColor,
    String? firstOptionIcon,
    String? secondOptionIcon,
    required String firstOptionLabel,
    required String secondOptionLabel,
    required VoidCallback onFirstOptionTap,
    required VoidCallback onSecondOptionTap,
  }) {
    return showModalBottomSheet(
        backgroundColor: backgroundColor ?? Colors.white,
        barrierColor: barrierColor ?? Colors.black.withOpacity(0.5),
        constraints: BoxConstraints(
            maxHeight: 150 + MediaQuery.of(context).padding.bottom),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 6),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                GestureDetector(
                    onTap: onFirstOptionTap,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 16, bottom: 12),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                                firstOptionIcon ??
                                    'assets/icons/action/icon_manual_add.png',
                                width: 24,
                                height: 24),
                            const SizedBox(width: 12),
                            Text(firstOptionLabel,
                                style: BaseTextStyle.subtitle1(
                                    color: Colors.black))
                          ]),
                    )),
                const Divider(),
                GestureDetector(
                    onTap: onSecondOptionTap,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(top: 16, bottom: 12),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                                secondOptionIcon ??
                                    'assets/icons/action/icon_manual_add.png',
                                width: 24,
                                height: 24),
                            const SizedBox(width: 12),
                            Text(secondOptionLabel,
                                style: BaseTextStyle.subtitle1(
                                    color: Colors.black))
                          ]),
                    ))
              ]));
        });
  }
}
