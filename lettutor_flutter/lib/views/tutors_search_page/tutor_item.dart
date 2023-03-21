import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/models/tutor/tutor.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/avatar_circle/avatar_circle.dart';

class TutorCardInfo extends StatelessWidget {
  const TutorCardInfo({Key? key, required this.tutor}) : super(key: key);

  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            routes.tutorProfilePage,
            arguments: {"tutor": tutor},
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: AvatarCircle(
                          width: 65, height: 65, source: tutor.image),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    tutor.fullName,
                                    style: BaseTextStyle.heading2(fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    tutor.getTotalStar().toString(),
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.pink,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  SvgPicture.asset(
                                    "assets/svg/ic_star.svg",
                                    color: Colors.yellow,
                                    height: 25,
                                    width: 25,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 28,
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
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 35,
                            child: ListView.builder(
                              itemCount: tutor.languages.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 212, 212, 212),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
