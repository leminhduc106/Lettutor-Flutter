import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/schedule_model/booking_info_model.dart';
import 'package:lettutor_flutter/services/tutor_service.dart';

import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key, required this.bookingInfo}) : super(key: key);
  final BookingInfo bookingInfo;

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _controller = TextEditingController();
  int rating = 5;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final lang = Provider.of<AppProvider>(context).language;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          title: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              lang.giveFeedback,
              style: BaseTextStyle.heading2(
                  fontSize: 20, color: BaseColor.secondaryBlue),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 22),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[500]!)),
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {},
                    autofocus: true,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 15),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-z\s_-]+')),
                    ],
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: lang.hintFeedback),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 22),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemSize: 30,
                        onRatingUpdate: (rating) {
                          setState(() {
                            this.rating = rating.toInt();
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_controller.text.isEmpty) {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                  message: lang.errEnterFeedback),
                              showOutAnimationDuration:
                                  const Duration(milliseconds: 1000),
                              displayDuration:
                                  const Duration(microseconds: 1000),
                            );
                          } else if (_controller.text.split(" ").length < 3) {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                  message: lang.errFeedbackLength),
                              showOutAnimationDuration:
                                  const Duration(milliseconds: 1000),
                              displayDuration:
                                  const Duration(microseconds: 1000),
                            );
                          } else {
                            final res = await TutorService.witeFeedback(
                                _controller.text,
                                widget.bookingInfo.id,
                                widget.bookingInfo.scheduleDetailInfo!
                                    .scheduleInfo!.tutorId,
                                rating,
                                authProvider.tokens!.access.token);
                            if (res) {
                              // ignore: use_build_context_synchronously
                              showTopSnackBar(
                                context,
                                CustomSnackBar.success(
                                  message: lang.successFeedback,
                                  backgroundColor: Colors.green,
                                ),
                                showOutAnimationDuration:
                                    const Duration(milliseconds: 1000),
                                displayDuration:
                                    const Duration(microseconds: 1000),
                              );
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/ic_feedback.svg",
                              width: 20,
                              height: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              lang.feedback,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
