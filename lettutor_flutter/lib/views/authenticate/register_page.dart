import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/custom_textfield/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _phoneError;
  String? _passwordError;
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool? _isLoading;
  bool _pwIsObscured = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightSafeArea = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);
    double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio)
        .bottom;

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
          child: Stack(children: [
            SingleChildScrollView(
                child: Center(
              child: Container(
                  width: safeWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildLogoArea(
                            heightSafeArea, safeWidth, keyboardHeight),
                        buildRegisterArea(
                            heightSafeArea, context, keyboardHeight),
                        buildLoginArea(heightSafeArea, keyboardHeight),
                      ])),
            )),
          ]),
        ));
  }

  Widget buildLogoArea(
      double heightSafeArea, double safeWidth, double keyboardHeight) {
    return Column(
      children: [
        AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.center,
            height: (keyboardHeight == 0)
                ? heightSafeArea * 0.37
                : heightSafeArea * 0.3,
            child: Image.asset("assets/images/login.png",
                width: safeWidth * 0.6, fit: BoxFit.fitWidth)),
        const SizedBox(height: 16),
        Text("Đăng ký", style: BaseTextStyle.heading4(color: BaseColor.blue)),
        const SizedBox(height: 20),
        Text(
          "Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành riêng cho bạn.",
          style: BaseTextStyle.body3(color: BaseColor.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget buildRegisterArea(
      double heightSafeArea, BuildContext context, double keyboardHeight) {
    return SizedBox(
        height: heightSafeArea * 0.6,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField.common(
                  onChanged: (value) {
                    _clearError();
                  },
                  errorText: _phoneError,
                  textEditingController: _phoneController,
                  hintText: "mail@example.com",
                  required: true,
                  labelText: "Email",
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next),
              const SizedBox(height: 16),
              CustomTextField.common(
                  onChanged: (value) {
                    if (value == "") _pwIsObscured = true;
                    _clearError();
                  },
                  errorText: _passwordError,
                  textEditingController: _passwordController,
                  hintText: "********",
                  labelText: "Mật khẩu",
                  required: true,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  isObscured: _pwIsObscured,
                  editIconPath: _pwIsObscured
                      ? "assets/icons/action/icon-hidden.png"
                      : "assets/icons/action/icon-display.png",
                  edit: _passwordController.text.isNotEmpty
                      ? () => setState(() {
                            _pwIsObscured = !_pwIsObscured;
                          })
                      : null),
              const SizedBox(height: 32),
              AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: (keyboardHeight == 0) ? 12 : 16),
              CustomButton.common(
                  onTap: () {}, content: "ĐĂNG KÝ", isLoading: _isLoading),
              const SizedBox(height: 24),
              Text("Hoặc tiếp tục với",
                  style: BaseTextStyle.body2(color: BaseColor.black)),
              const SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: BaseColor.blue, width: 0.5),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xff003399).withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset: const Offset(0, 2))
                          ]),
                      child: SizedBox(
                        height: 24,
                        child: Image.asset(
                          "assets/icons/social/icon_facebook.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )),
                const SizedBox(width: 12),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: BaseColor.blue, width: 0.5),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xff003399).withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset: const Offset(0, 2))
                          ]),
                      child: SizedBox(
                        height: 24,
                        child: Image.asset(
                          "assets/icons/social/icon_google.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )),
                const SizedBox(width: 12),
                GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: BaseColor.blue, width: 0.5),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xff003399).withOpacity(0.2),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset: const Offset(0, 2))
                          ]),
                      child: SizedBox(
                        height: 24,
                        child: Image.asset(
                          "assets/icons/social/icon_mobile.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )),
              ]),
            ]));
  }

  Widget buildLoginArea(double heightSafeArea, double keyboardHeight) {
    return SizedBox(
        height: (keyboardHeight == 0) ? 100 : 0,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Đã có tài khoản?",
            style: BaseTextStyle.body2(color: Colors.black),
          ),
          const SizedBox(height: 32),
          InkWell(
              child: Text("Đăng nhập",
                  style:
                      BaseTextStyle.subtitle2(color: BaseColor.secondaryBlue)),
              onTap: () {}),
        ]));
  }

  void _clearPassword() {
    _passwordController.clear();
  }

  void _clearError() {
    setState(() {
      _phoneError = null;
      _passwordError = null;
    });
  }
}
