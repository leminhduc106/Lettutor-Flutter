import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_flutter/models/user/booking.dart';
import 'package:lettutor_flutter/provider/user_provider.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/avatar_circle/avatar_circle.dart';
import 'package:lettutor_flutter/widgets/custom_alert_dialog/custom_accept_dialog.dart';
import 'package:lettutor_flutter/widgets/custom_alert_dialog/custom_two_btn_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UpComingCard extends StatelessWidget {
  const UpComingCard({Key? key, required this.upcomming}) : super(key: key);

  final Booking upcomming;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    void cancelUpcoming(String id) {
      userProvider.cancelBooking(id);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: AvatarCircle(
                          width: 50,
                          height: 50,
                          source: upcomming.tutor.image)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          upcomming.tutor.fullName,
                          style: BaseTextStyle.heading2(fontSize: 16),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            DateFormat.yMEd().format(upcomming.start),
                            style: const TextStyle(fontSize: 13),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 1),
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              DateFormat.Hm().format(upcomming.start),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.blue),
                            ),
                          ),
                          const Text("-"),
                          Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.orange, width: 1),
                                color: Colors.orange[50],
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              DateFormat.Hm().format(upcomming.end),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.orange),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 14),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAcceptDialog(
                                content:
                                    "Do you really want to cancel upcomming lesson?",
                                context: context,
                                acceptFuction: () {
                                  cancelUpcoming(upcomming.id);
                                  upcomming.tutor
                                      .setReserved(upcomming.idSchedule, false);
                                  showTopSnackBar(
                                    context,
                                    const CustomSnackBar.success(
                                      message: "Remove upcomming successful.",
                                      backgroundColor: Colors.green,
                                    ),
                                    showOutAnimationDuration:
                                        const Duration(milliseconds: 700),
                                    displayDuration:
                                        const Duration(milliseconds: 200),
                                  );
                                },
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300] as Color),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[Text("Cancel")],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400] as Color),
                          color: Colors.grey[400],
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            "Go to meeting",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
