import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/language_model/language.dart';
import 'package:lettutor_flutter/models/language_model/language_en.dart';
import 'package:lettutor_flutter/models/language_model/language_vi.dart';
import 'package:lettutor_flutter/models/user_model/tokens_model.dart';
import 'package:lettutor_flutter/models/user_model/user_model.dart';
import 'package:lettutor_flutter/services/auth_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/authenticate/login_with.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/custom_textfield/custom_textfield.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _emailError;
  String? _passwordError;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool? _isLoading;
  bool _pwIsObscured = true;
  bool isAuthenticating = true;
  bool isAuthenticated = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAuthenticating = true;
    isAuthenticated = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  callback(User user, Tokens tokens, AuthProvider authProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authProvider.logIn(user, tokens);
    await prefs.setString('refresh_token', authProvider.tokens!.refresh.token);
    if (mounted) {
      setState(() {
        isAuthenticating = false;
        isAuthenticated = true;
      });
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pop(context);
      Navigator.of(context).pushNamed(routes.homePage);
    });
  }

  void authenticate(AuthProvider authProvider) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token') ?? "";
      await AuthService.authenticate(refreshToken, authProvider, callback);
    } catch (e) {
      if (mounted) {
        setState(() {
          isAuthenticating = false;
        });
      }
    }
  }

  void handleLogin(Language language, AuthProvider authProvider) async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showTopSnackBar(
          context, CustomSnackBar.error(message: language.emptyField),
          showOutAnimationDuration: const Duration(milliseconds: 1000),
          displayDuration: const Duration(microseconds: 4000));
      return;
    }

    if (_passwordController.text.length < 6) {
      showTopSnackBar(
          context, CustomSnackBar.error(message: language.passwordTooShort),
          showOutAnimationDuration: const Duration(milliseconds: 1000),
          displayDuration: const Duration(microseconds: 4000));
      return;
    }

    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      try {
        await AuthService.loginByEmailAndPassword(_emailController.text,
            _passwordController.text, authProvider, callback);
      } catch (e) {
        showTopSnackBar(context,
            CustomSnackBar.error(message: "Login failed! ${e.toString()}"),
            showOutAnimationDuration: const Duration(milliseconds: 1000),
            displayDuration: const Duration(microseconds: 4000));
      }
    } else {
      showTopSnackBar(
          context, CustomSnackBar.error(message: language.invalidEmail),
          showOutAnimationDuration: const Duration(milliseconds: 1000),
          displayDuration: const Duration(microseconds: 4000));
    }
  }

  void loadLangue(AppProvider appProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('lang') ?? "EN";
    if (lang == "EN") {
      appProvider.language = English();
    } else {
      appProvider.language = VietNamese();
    }
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

    final authProvider = Provider.of<AuthProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final language = appProvider.language;

    loadLangue(appProvider);

    if (isAuthenticating) {
      authenticate(authProvider);
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
              child: isAuthenticating
                  ? const CircularProgressIndicator()
                  : isAuthenticated
                      ? Container()
                      : Container(
                          width: safeWidth,
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildLogoArea(
                                    heightSafeArea, safeWidth, keyboardHeight),
                                buildLoginArea(
                                    heightSafeArea, context, keyboardHeight,
                                    handleLogin: handleLogin,
                                    language: language),
                                buildRegisterArea(
                                    heightSafeArea, keyboardHeight,
                                    language: language),
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
      {required Function(Language language, AuthProvider authProvider)
          handleLogin,
      required Language language}) {
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
                  errorText: _emailError,
                  textEditingController: _emailController,
                  hintText: "mail@example.com",
                  required: true,
                  labelText: language.email,
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
                      child: Text(language.forgotPassword,
                          style: BaseTextStyle.button(
                              color: BaseColor.secondaryBlue)))),
              AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: (keyboardHeight == 0) ? 12 : 16),
              CustomButton.common(
                  onTap: () {
                    handleLogin(language, context.read<AuthProvider>());
                  },
                  content: language.signIn,
                  isLoading: _isLoading),
              const SizedBox(height: 24),
              Text(language.continueWith,
                  style: BaseTextStyle.body2(color: BaseColor.black)),
              const SizedBox(height: 24),
              LoginWith(callback: callback),
            ]));
  }

  Widget buildRegisterArea(double heightSafeArea, double keyboardHeight,
      {required Language language}) {
    return SizedBox(
        height: (keyboardHeight == 0) ? 100 : 0,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            language.signUpQuestion,
            style: BaseTextStyle.body2(color: Colors.black),
          ),
          const SizedBox(height: 32),
          InkWell(
              child: Text(language.signUp,
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
      _emailError = null;
      _passwordError = null;
    });
  }
}
