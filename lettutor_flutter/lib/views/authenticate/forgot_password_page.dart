import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_appbar/custom_appbar.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/custom_textfield/custom_textfield.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightSafeArea = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          height: 24,
          child: Image.asset(
            "assets/icons/social/lettutor_icon.png",
            fit: BoxFit.fitHeight,
          ),
        ),
        title: Text('LetTutor',
            style: BaseTextStyle.heading4(color: BaseColor.secondaryBlue)),
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(color: BaseColor.blue, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff003399).withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: const Offset(0, 2))
                      ]),
                  child: SizedBox(
                    height: 64,
                    child: Image.asset(
                      "assets/icons/social/icon_vietnam.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Container(
                  width: safeWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: heightSafeArea,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Đặt lại mật khẩu',
                                    style: BaseTextStyle.heading4(
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 18),
                                  RichText(
                                    text: TextSpan(
                                        style: BaseTextStyle.body2(
                                            color: Colors.black),
                                        children: [
                                          const TextSpan(
                                              text: "Vui lòng nhập "),
                                          TextSpan(
                                              text: "Email ",
                                              style: BaseTextStyle.subtitle2(
                                                  color: Colors.black)),
                                          const TextSpan(
                                              text:
                                                  "của bạn để tìm kiếm tài khoản của bạn."),
                                        ]),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField.common(
                                    onChanged: (value) {},
                                    labelText: "Email",
                                    hintText: "Nhập Email",
                                    textInputType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(height: size.height * 0.04),
                                  CustomButton.common(
                                      onTap: () {}, content: "Xác nhận"),
                                  SizedBox(height: size.height * 0.02),
                                  TextButton.icon(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        size: 15,
                                        color: BaseColor.blue,
                                      ),
                                      label: Text("Trở về trang đăng nhập",
                                          style: BaseTextStyle.body2(
                                              color: BaseColor.blue)))
                                ]))
                      ]))),
        ),
      ),
    );
  }
}
