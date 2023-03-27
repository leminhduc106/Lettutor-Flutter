import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/models/tutor/tutor.dart';
import 'package:lettutor_flutter/provider/user_provider.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/avatar_circle/avatar_circle.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/rate_stars/rate_stars.dart';
import 'package:provider/provider.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;

class CardTutor extends StatelessWidget {
  const CardTutor({Key? key, required this.tutor}) : super(key: key);
  final Tutor tutor;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final exists =
        userProvider.idFavorite.where((element) => element == tutor.id);
    Size size = MediaQuery.of(context).size;
    double safeWidth = min(size.width, 500);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            routes.tutorProfilePage,
            arguments: {"tutor": tutor},
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
                    child: AvatarCircle(
                        width: 65, height: 65, source: tutor.image),
                  ),
                  Positioned(
                      //top right
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          if (exists.isNotEmpty) {
                            userProvider.removeFavorite(tutor.id);
                          } else {
                            userProvider.addFavorite(tutor.id);
                          }
                        },
                        child: exists.isEmpty
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
                    tutor.fullName,
                    style: BaseTextStyle.body3(fontSize: 18),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(
                      height: 32,
                      child: Image.asset(
                        "assets/icons/social/icon_vietnam_flag.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tutor.country,
                      style: BaseTextStyle.body2(),
                    ),
                  ]),
                  RateStars(count: tutor.getTotalStar()),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 35,
                    child: ListView.builder(
                      itemCount: tutor.languages.length,
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
                          child: Text(tutor.languages[index],
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
                  tutor.intro,
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
                        arguments: {"tutor": tutor},
                      );
                    },
                    content: "Đặt lịch",
                    iconPath: "assets/icons/common/icon_calendar_blue.png"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
