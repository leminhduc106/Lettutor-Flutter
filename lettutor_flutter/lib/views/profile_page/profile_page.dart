import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_flutter/models/user/countries.dart';
import 'package:lettutor_flutter/provider/user_provider.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/utils/utils.dart';
import 'package:lettutor_flutter/views/profile_page/components/birthday.dart';
import 'package:lettutor_flutter/views/profile_page/components/dropdown_menu.dart';
import 'package:lettutor_flutter/views/profile_page/components/phone.dart';
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
  late DateTime _birthday;
  late String _phone;
  late String _country;
  late String _level;
  late String _topicToLearn;
  bool isInit = true;

  final ImagePicker _picker = ImagePicker();
  String? _image;

  void setBirthday(DateTime birthday) {
    setState(() {
      _birthday = birthday;
    });
  }

  void setPhone(String phone) {
    setState(() {
      _phone = phone;
    });
  }

  void setCountry(String country) {
    setState(() {
      _country = country;
    });
  }

  void setLevel(String level) {
    setState(() {
      _level = level;
    });
  }

  void setTopicToLearn(String topicToLearn) {
    setState(() {
      _topicToLearn = topicToLearn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    final uploadImage = userProvider.uploadImage;

    setState(() {
      if (isInit) {
        _birthday = user.birthDay;
        _phone = user.phone;
        _country = user.country;
        _level = user.level;
        _topicToLearn = user.topicToLearn;
        isInit = false;
      }
    });

    Future takePhoto(ImageSource source) async {
      try {
        final pickedFile = await _picker.pickImage(source: source);
        if (pickedFile == null) return;
        final imagePermanent =
            await ImageHelper.saveImagePermanently(pickedFile.path);
        userProvider.uploadProfileImage(File(imagePermanent.path));
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
            "Profile",
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
                      child: CircleAvatar(
                        child: uploadImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(1000),
                                child: Image.file(
                                  uploadImage,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const AvatarCircle(
                                width: 200,
                                height: 200,
                                source: "assets/images/profile_2.jpeg"),
                      ),
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
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(user.fullName,
                      style: BaseTextStyle.heading2(fontSize: 18)),
                ),
                Text(user.email,
                    style:
                        BaseTextStyle.body2(fontSize: 14, color: Colors.grey)),
                BirthdayEdition(setBirthday: setBirthday, birthday: _birthday),
                PhoneEdition(changePhone: setPhone, phone: _phone),
                DropdownEdit(
                  title: "Country",
                  selectedItem: _country,
                  items: AllCountries.countries,
                  onChange: setCountry,
                ),
                DropdownEdit(
                  title: "My Level",
                  selectedItem: _level,
                  items: const ["Beginner", "Immediate", "Advanced"],
                  onChange: setLevel,
                ),
                DropdownEdit(
                  title: "Want to learn",
                  selectedItem: _topicToLearn,
                  items: const ["TOEIC", "IELTS", "TOEFL"],
                  onChange: setTopicToLearn,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: CustomButton.common(
                        content: "Save",
                        onTap: () {
                          if (_phone.isEmpty) {
                            showTopSnackBar(
                              context,
                              const CustomSnackBar.error(
                                  message: "Phone number is invalid."),
                              showOutAnimationDuration:
                                  const Duration(milliseconds: 700),
                              displayDuration:
                                  const Duration(milliseconds: 200),
                            );
                          } else {
                            userProvider.updateBirthday(_birthday);
                            userProvider.updatePhone(_phone);
                            userProvider.updateCountry(_country);
                            userProvider.updateLevel(_level);
                            userProvider.updateTopicToLearn(_topicToLearn);
                            Navigator.pop(context);
                            showTopSnackBar(
                              context,
                              const CustomSnackBar.success(
                                  message: "Save information successful"),
                              showOutAnimationDuration:
                                  const Duration(milliseconds: 700),
                              displayDuration:
                                  const Duration(milliseconds: 200),
                            );
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
