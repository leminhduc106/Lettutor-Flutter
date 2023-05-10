import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/constants/learning_topics.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/tutor_model/tutor_info_model.dart';
import 'package:lettutor_flutter/models/tutor_model/tutor_model.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;
import 'package:lettutor_flutter/services/tutor_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:provider/provider.dart';

class TutorCardInfo extends StatefulWidget {
  const TutorCardInfo({Key? key, required this.tutor}) : super(key: key);

  final TutorInfo tutor;

  @override
  State<TutorCardInfo> createState() => _TutorCardInfoState();
}

class _TutorCardInfoState extends State<TutorCardInfo> {
  Tutor? tutorDetail;
  bool isLoading = true;

  fetchTutorDetail(String token) async {
    final tutorDetail = await TutorService.getTutor(widget.tutor.userId, token);
    setState(() {
      this.tutorDetail = tutorDetail;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final specialist = listLearningTopics.entries
        .where((element) =>
            widget.tutor.specialties.split(",").contains(element.key))
        .map((e) => e.value)
        .toList();

    final authProvider = Provider.of<AuthProvider>(context);
    if (isLoading) {
      fetchTutorDetail(authProvider.tokens!.access.token);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            routes.tutorProfilePage,
            arguments: {"tutorID": widget.tutor.userId},
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
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, right: 10),
                      height: 60,
                      width: 60,
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: CachedNetworkImage(
                              imageUrl: widget.tutor.avatar as String,
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
                                    widget.tutor.name,
                                    style: BaseTextStyle.heading2(fontSize: 16),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    tutorDetail?.avgRating != null
                                        ? tutorDetail!.avgRating.toString()
                                        : "0",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.pink,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.star, color: Colors.yellow),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            widget.tutor.country!,
                            style: BaseTextStyle.body2(),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 35,
                            child: ListView.builder(
                              itemCount: specialist.length,
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
                                  child: Text(specialist[index],
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
                    widget.tutor.bio,
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
