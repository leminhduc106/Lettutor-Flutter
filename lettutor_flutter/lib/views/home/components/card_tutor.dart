import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/constants/learning_topics.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/tutor_model/tutor_model.dart';
import 'package:lettutor_flutter/services/user_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/rate_stars/rate_stars.dart';
import 'package:provider/provider.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;

class CardTutor extends StatefulWidget {
  const CardTutor({Key? key, required this.tutor}) : super(key: key);
  final Tutor tutor;

  @override
  State<CardTutor> createState() => _CardTutorState();
}

class _CardTutorState extends State<CardTutor> {
  late Tutor _tutor;

  @override
  void initState() {
    super.initState();
    setState(() {
      _tutor = widget.tutor;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double safeWidth = min(size.width, 500);
    final appProvider = Provider.of<AppProvider>(context);
    final language = appProvider.language;

    final specialties = listLearningTopics.entries
        .where((element) => _tutor.specialties.split(",").contains(element.key))
        .map((e) => e.value)
        .toList();

    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            routes.tutorProfilePage,
            arguments: {"tutorID": _tutor.user.id},
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.black12, width: 0.1),
              boxShadow: [
                BoxShadow(
                    color: const Color(0xff003399).withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 2))
              ]),
          width: safeWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10, right: 10),
                      height: 60,
                      width: 60,
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: CachedNetworkImage(
                              imageUrl: _tutor.user.avatar,
                              fit: BoxFit.cover,
                              width: 70,
                              height: 70,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )),
                    ),
                  ),
                  Positioned(
                      //top right
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () async {
                          final res =
                              await UserService.addAndRemoveTutorFavorite(
                                  _tutor.user.id,
                                  authProvider.tokens!.access.token);

                          if (res) {
                            setState(() {
                              _tutor.isFavorite = !(_tutor.isFavorite ?? false);
                            });
                          }
                        },
                        child: _tutor.isFavorite != null &&
                                !(_tutor.isFavorite as bool)
                            ? SvgPicture.asset(
                                "assets/svg/ic_heart.svg",
                                width: 35,
                                height: 35,
                                color: Colors.blue,
                              )
                            : SvgPicture.asset(
                                "assets/svg/ic_heart_fill.svg",
                                width: 35,
                                height: 35,
                                color: Colors.pink,
                              ),
                      ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _tutor.user.name,
                    style: BaseTextStyle.body3(fontSize: 18),
                  ),
                  RateStars(count: _tutor.avgRating ?? 5),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 35,
                    child: ListView.builder(
                      itemCount: specialties.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 212, 212, 212),
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          child: Text(specialties[index],
                              style: BaseTextStyle.body2(fontSize: 14)),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Text(
                  _tutor.bio,
                  style: BaseTextStyle.body2(fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10),
                width: safeWidth * 0.4,
                child: CustomButton.whiteBtnWithIcon(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        routes.tutorProfilePage,
                        arguments: {"tutorID": _tutor.user.id},
                      );
                    },
                    content: language.bookingText,
                    iconPath: "assets/icons/common/icon_calendar_blue.png"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
