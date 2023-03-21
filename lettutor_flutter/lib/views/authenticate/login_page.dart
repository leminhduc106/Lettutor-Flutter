import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/custom_textfield/custom_textfield.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _phoneError;
  String? _passwordError;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool? _isLoading;
  bool _pwIsObscured = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = 'admin';
    _passwordController.text = '123123';
  }

  @override
  void dispose() {
    _emailController.dispose();
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

    void handleLogin() {
      if (_emailController.text == 'admin' &&
          _passwordController.text == '123123') {
        Navigator.pushNamedAndRemoveUntil(
            context, routes.homePage, (Route<dynamic> route) => false);
      } else {
        showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: "Login failed! Email or password is wrong.",
          ),
          showOutAnimationDuration: const Duration(milliseconds: 1000),
          displayDuration: const Duration(microseconds: 1000),
        );
      }
    }

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
                        buildLoginArea(heightSafeArea, context, keyboardHeight,
                            handleLogin: handleLogin),
                        buildRegisterArea(heightSafeArea, keyboardHeight),
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
        Text("Đăng nhập", style: BaseTextStyle.heading4(color: BaseColor.blue)),
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

  Widget buildLoginArea(
      double heightSafeArea, BuildContext context, double keyboardHeight,
      {required Function() handleLogin}) {
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
                  textEditingController: _emailController,
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
              Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, routes.forgotPasswordPage);
                      },
                      child: Text("Quên mật khẩu?",
                          style: BaseTextStyle.button(
                              color: BaseColor.secondaryBlue)))),
              AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: (keyboardHeight == 0) ? 12 : 16),
              CustomButton.common(
                  onTap: () {
                    handleLogin();
                  },
                  content: "ĐĂNG NHẬP",
                  isLoading: _isLoading),
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

  Widget buildRegisterArea(double heightSafeArea, double keyboardHeight) {
    return SizedBox(
        height: (keyboardHeight == 0) ? 100 : 0,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Chưa có tài khoản?",
            style: BaseTextStyle.body2(color: Colors.black),
          ),
          const SizedBox(height: 32),
          InkWell(
              child: Text("Đăng ký",
                  style:
                      BaseTextStyle.subtitle2(color: BaseColor.secondaryBlue)),
              onTap: () {
                Navigator.pushNamed(context, routes.registerPage);
              }),
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
