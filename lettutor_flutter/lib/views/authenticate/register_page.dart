import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/models/language_model/language.dart';
import 'package:lettutor_flutter/services/auth_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/custom_textfield/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _emailError;
  String? _passwordError;
  String? _repasswordError;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordControler = TextEditingController();
  bool? _isLoading;
  bool _pwIsObscured = true;
  bool _repwIsObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repasswordControler.dispose();
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
    final appProvider = Provider.of<AppProvider>(context);
    final language = appProvider.language;

    void handleSignUp() async {
      if (_emailController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _repasswordControler.text.isEmpty) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(message: language.errEnterAllFields),
          showOutAnimationDuration: const Duration(milliseconds: 1000),
          displayDuration: const Duration(microseconds: 3000),
        );
      } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_emailController.text)) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(message: language.invalidEmail),
          showOutAnimationDuration: const Duration(milliseconds: 1000),
          displayDuration: const Duration(microseconds: 3000),
        );
      } else if (_passwordController.text.length < 6) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(message: language.passwordTooShort),
          showOutAnimationDuration: const Duration(milliseconds: 1000),
          displayDuration: const Duration(microseconds: 3000),
        );
      } else if (_passwordController.text != _repasswordControler.text) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(message: language.errPasswordMismatch),
          showOutAnimationDuration: const Duration(milliseconds: 1000),
          displayDuration: const Duration(microseconds: 3000),
        );
      } else {
        try {
          await AuthService.registerWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
            () {
              Navigator.pushNamedAndRemoveUntil(
                  context, routes.loginPage, (Route<dynamic> route) => false);
            },
          );
        } catch (e) {
          showTopSnackBar(
            context,
            CustomSnackBar.error(message: "Signup failed!. ${e.toString()}"),
            showOutAnimationDuration: const Duration(milliseconds: 1000),
            displayDuration: const Duration(microseconds: 4000),
          );
        }
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
                        buildLogoArea(heightSafeArea, safeWidth, keyboardHeight,
                            language: language),
                        buildRegisterArea(
                            heightSafeArea, context, keyboardHeight,
                            handleRegister: handleSignUp, language: language),
                        buildLoginArea(heightSafeArea, keyboardHeight,
                            language: language),
                      ])),
            )),
          ]),
        ));
  }

  Widget buildLogoArea(
      double heightSafeArea, double safeWidth, double keyboardHeight,
      {required Language language}) {
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
        Text(language.signUp,
            style: BaseTextStyle.heading4(color: BaseColor.blue)),
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
      double heightSafeArea, BuildContext context, double keyboardHeight,
      {required Function handleRegister, required Language language}) {
    return SizedBox(
        height: heightSafeArea * 0.7,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField.common(
                  onChanged: (value) {
                    _clearError();
                  },
                  errorText: _emailError,
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
                  labelText: language.password,
                  required: true,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  isObscured: _pwIsObscured,
                  editIconPath: _pwIsObscured
                      ? "assets/icons/action/icon-hidden.png"
                      : "assets/icons/action/icon-display.png",
                  edit: _passwordController.text.isNotEmpty
                      ? () => setState(() {
                            _pwIsObscured = !_pwIsObscured;
                          })
                      : null),
              const SizedBox(height: 16),
              CustomTextField.common(
                  onChanged: (value) {
                    if (value == "") _repwIsObscured = true;
                    _clearError();
                  },
                  errorText: _repasswordError,
                  textEditingController: _repasswordControler,
                  hintText: "********",
                  labelText: language.confirmPassword,
                  required: true,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  isObscured: _repwIsObscured,
                  editIconPath: _repwIsObscured
                      ? "assets/icons/action/icon-hidden.png"
                      : "assets/icons/action/icon-display.png",
                  edit: _repasswordControler.text.isNotEmpty
                      ? () => setState(() {
                            _repwIsObscured = !_repwIsObscured;
                          })
                      : null),
              const SizedBox(height: 32),
              AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: (keyboardHeight == 0) ? 12 : 16),
              CustomButton.common(
                  onTap: () {
                    handleRegister();
                  },
                  content: language.signUp,
                  isLoading: _isLoading),
              const SizedBox(height: 24),
            ]));
  }

  Widget buildLoginArea(double heightSafeArea, double keyboardHeight,
      {required Language language}) {
    return SizedBox(
        height: (keyboardHeight == 0) ? 100 : 0,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            language.loginQuestion,
            style: BaseTextStyle.body2(color: Colors.black),
          ),
          const SizedBox(height: 32),
          InkWell(
              child: Text(language.signIn,
                  style:
                      BaseTextStyle.subtitle2(color: BaseColor.secondaryBlue)),
              onTap: () {
                Navigator.of(context).pop();
              }),
        ]));
  }

  void _clearPassword() {
    _passwordController.clear();
  }

  void _clearError() {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });
  }
}
