import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_flutter/constants/list_contries.dart';
import 'package:lettutor_flutter/constants/list_level.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/user_model/learning_topic_model.dart';
import 'package:lettutor_flutter/models/user_model/test_preparation_model.dart';
import 'package:lettutor_flutter/models/user_model/tokens_model.dart';
import 'package:lettutor_flutter/services/user_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/profile_page/components/birthday.dart';
import 'package:lettutor_flutter/views/profile_page/components/dropdown_menu.dart';
import 'package:lettutor_flutter/views/profile_page/components/phone.dart';
import 'package:lettutor_flutter/views/profile_page/components/want_to_learn.dart';
import 'package:lettutor_flutter/widgets/avatar_circle/avatar_circle.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/custom_modal_sheet/custom_modal_sheet.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late DateTime? _birthday;
  String? _phone;
  String? _country;
  String? _level;
  List<LearnTopic> _topics = [];
  List<TestPreparation> _tests = [];
  bool isInit = true;

  final ImagePicker _picker = ImagePicker();
  final _nameController = TextEditingController();

  setForm(
      {DateTime? birthday,
      String phone = "",
      String country = "",
      String level = ""}) {
    setState(() {
      _birthday = birthday ?? DateTime.now();
      if (phone.isNotEmpty) {
        _phone = phone;
      }
      if (country.isNotEmpty) {
        _country = country;
      }
      if (level.isNotEmpty) {
        _level = level;
      }
    });
  }

  editTopics(List<LearnTopic> topics) {
    setState(() {
      _topics = topics;
    });
  }

  editTests(List<TestPreparation> tests) {
    setState(() {
      _tests = tests;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final lang = Provider.of<AppProvider>(context).language;
    String? uploadImage = authProvider.userLoggedIn.avatar;

    setState(() {
      if (isInit) {
        _birthday = authProvider.userLoggedIn.birthday != null
            ? DateFormat("yyyy-MM-dd")
                .parse(authProvider.userLoggedIn.birthday as String)
            : DateFormat("yyyy-MM-dd").parse("2001-06-10");
        _phone = authProvider.userLoggedIn.phone;
        _country = authProvider.userLoggedIn.country != null
            ? (authProvider.userLoggedIn.country as String)
            : "VN";
        _level = authProvider.userLoggedIn.level != null
            ? (authProvider.userLoggedIn.level as String)
            : "BEGINNER";
        _nameController.text = authProvider.userLoggedIn.name;
        _topics = authProvider.userLoggedIn.learnTopics ?? [];
        _tests = authProvider.userLoggedIn.testPreparations ?? [];
        isInit = false;
      }
    });

    Future takePhoto(ImageSource source) async {
      try {
        final pickedFile = await _picker.pickImage(source: source);
        if (pickedFile == null) return;
        final bool res = await UserService.uploadAvatar(
            pickedFile.path, authProvider.tokens!.access.token);
        if (res) {
          final newInfo =
              await UserService.getUserInfo(authProvider.tokens!.access.token);
          uploadImage = newInfo?.avatar;
          if (newInfo != null) {
            authProvider.setUser(newInfo);
            // ignore: use_build_context_synchronously
            showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(
                  message: lang.successUploadAvatar,
                  backgroundColor: Colors.green,
                ),
                animationDuration: const Duration(milliseconds: 1000),
                displayDuration: const Duration(microseconds: 4000));
          } else {
            // ignore: use_build_context_synchronously
            showTopSnackBar(Overlay.of(context),
                CustomSnackBar.error(message: lang.errGetNewProfile),
                animationDuration: const Duration(milliseconds: 1000),
                displayDuration: const Duration(microseconds: 4000));
          }
        } else {
          // ignore: use_build_context_synchronously
          showTopSnackBar(Overlay.of(context),
              CustomSnackBar.error(message: lang.errUploadAvatar),
              animationDuration: const Duration(milliseconds: 1000),
              displayDuration: const Duration(microseconds: 4000));
        }
      } on PlatformException catch (e) {
        debugPrint('Failed to pick image: ${e.message}');
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          title: Text(
            lang.profile,
            style: BaseTextStyle.heading2(
                fontSize: 20, color: BaseColor.secondaryBlue),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 100,
                      width: 100,
                      child: uploadImage != null
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: CachedNetworkImage(
                                  imageUrl: authProvider.userLoggedIn.avatar,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ))
                          : const AvatarCircle(
                              width: 200,
                              height: 200,
                              source: "assets/images/profile_2.jpeg"),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          CustomModalSheet.buildChoosePhotoBottom(
                            context: context,
                            onTappedCamera: () {
                              takePhoto(ImageSource.camera);
                              Navigator.of(context).pop();
                            },
                            onTappedGallery: () {
                              takePhoto(ImageSource.gallery);
                              Navigator.of(context).pop();
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 15,
                          child: SvgPicture.asset(
                            "assets/svg/ic_camera.svg",
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Text(authProvider.userLoggedIn.email,
                    style: BaseTextStyle.body1(
                      fontSize: 15,
                      color: Colors.grey[700],
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 7, left: 5),
                        child: Text(lang.fullName,
                            style: BaseTextStyle.body1(fontSize: 18)),
                      ),
                      TextField(
                        style: TextStyle(fontSize: 17, color: Colors.grey[900]),
                        controller: _nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.only(left: 15, right: 15),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          hintText: lang.fullName,
                        ),
                      )
                    ],
                  ),
                ),
                BirthdayEdition(setBirthday: setForm, birthday: _birthday),
                PhoneEdition(
                    changePhone: setForm,
                    phone: _phone ?? "",
                    isPhoneActivated:
                        authProvider.userLoggedIn.isPhoneActivated ?? false),
                DropdownEdit(
                  title: lang.country,
                  selectedItem: _country != null ? _country as String : "VN",
                  items: countryList,
                  onChange: setForm,
                  fieldName: "Country",
                ),
                DropdownEdit(
                  title: lang.level,
                  selectedItem: _level != "" ? _level as String : "BEGINNER",
                  items: listLevel,
                  onChange: setForm,
                  fieldName: "Level",
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 2, left: 5),
                  child: Row(
                    children: [
                      Text(
                        lang.wantToLearn,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
                WantToLearn(
                    userTopics: _topics,
                    editTopics: editTopics,
                    userTestPreparations: _tests,
                    editTestPreparations: editTests),
                Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: CustomButton.common(
                        content: lang.save,
                        onTap: () async {
                          if (_phone != null && _phone?.isEmpty as bool) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                  message: lang.errPhoneNumber),
                              animationDuration:
                                  const Duration(milliseconds: 700),
                              displayDuration:
                                  const Duration(milliseconds: 200),
                            );
                          } else if (_nameController.text.isEmpty) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(message: lang.errEnterName),
                              animationDuration:
                                  const Duration(milliseconds: 700),
                              displayDuration:
                                  const Duration(milliseconds: 200),
                            );
                          } else if (_birthday != null &&
                              _birthday!.millisecondsSinceEpoch >
                                  DateTime.now().millisecondsSinceEpoch) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(message: lang.errBirthday),
                              animationDuration:
                                  const Duration(milliseconds: 700),
                              displayDuration:
                                  const Duration(milliseconds: 200),
                            );
                          } else {
                            String bdArg =
                                "${_birthday!.year.toString()}-${_birthday!.month.toString().padLeft(2, "0")}-${_birthday!.day..toString().padLeft(2, "0")}";

                            final res = await UserService.updateInfo(
                              authProvider.tokens!.access.token,
                              _nameController.text,
                              _country as String,
                              bdArg,
                              _level as String,
                              _topics.map((e) => e.id.toString()).toList(),
                              _tests.map((e) => e.id.toString()).toList(),
                            );
                            if (res != null) {
                              authProvider.logIn(
                                  res, authProvider.tokens as Tokens);
                              // ignore: use_build_context_synchronously
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.success(
                                  message: lang.successUpdateProfile,
                                  backgroundColor: Colors.green,
                                ),
                                animationDuration:
                                    const Duration(milliseconds: 700),
                                displayDuration:
                                    const Duration(milliseconds: 200),
                              );
                              Navigator.pop(context);
                            } else {
                              // ignore: use_build_context_synchronously
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                    message: lang.errUpdateProfile),
                                animationDuration:
                                    const Duration(milliseconds: 700),
                                displayDuration:
                                    const Duration(milliseconds: 200),
                              );
                            }
                          }
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
