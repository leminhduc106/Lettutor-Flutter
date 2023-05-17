import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/schedule_model/booking_info_model.dart';
import 'package:lettutor_flutter/services/schedule_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/setting_page/session_history/session_item.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SessionHistoryPage extends StatefulWidget {
  const SessionHistoryPage({Key? key}) : super(key: key);

  @override
  State<SessionHistoryPage> createState() => _SessionHistoryPageState();
}

class _SessionHistoryPageState extends State<SessionHistoryPage> {
  final List<BookingInfo> _bookedList = [];
  bool isLoading = true;
  bool isLoadMore = false;
  int page = 1;
  int perPage = 10;
  late ScrollController _scrollController;
  String? token;
  String? userId;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(loadMore);
    super.dispose();
  }

  void fetchBookedList(String userId, String token) async {
    final res =
        await ScheduleService.getStudentBookedClass(1, 10, userId, token);
    setState(() {
      _bookedList.addAll(res);
      isLoading = false;
    });
  }

  void loadMore() async {
    if (_scrollController.position.extentAfter < page * perPage) {
      setState(() {
        isLoadMore = true;
        page++;
      });

      try {
        final res = await ScheduleService.getStudentBookedClass(
            page, perPage, userId as String, token as String);
        if (mounted) {
          setState(() {
            _bookedList.addAll(res);
            isLoadMore = false;
          });
        }
      } catch (e) {
        showTopSnackBar(
            context, const CustomSnackBar.error(message: "Cannot load more"),
            showOutAnimationDuration: const Duration(milliseconds: 1000),
            displayDuration: const Duration(microseconds: 4000));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double safeWidth = min(size.width, 500);

    final authProvider = Provider.of<AuthProvider>(context);
    final lang = Provider.of<AppProvider>(context).language;

    setState(() {
      token = authProvider.tokens!.access.token;
      userId = authProvider.userLoggedIn.id;
    });

    if (isLoading) {
      fetchBookedList(
          authProvider.userLoggedIn.id, authProvider.tokens!.access.token);
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
            lang.sessionHistory,
            style: BaseTextStyle.heading2(
                fontSize: 20, color: BaseColor.secondaryBlue),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 104,
                  child: Image.asset(
                    "assets/icons/common/icon_history.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    lang.sessionHistory,
                    style: BaseTextStyle.heading4(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.black12, width: 0.1),
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 6, 11, 21)
                                .withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset: const Offset(0, 0))
                      ]),
                  width: safeWidth,
                  child: Text(
                    lang.sessionHistoryExplain,
                    style: BaseTextStyle.body1(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : !isLoading && _bookedList.isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/ic_empty.svg",
                                    width: 200,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      lang.emptySession,
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox(
                            height: size.height,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 14),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: _bookedList.length,
                                    controller: _scrollController,
                                    itemBuilder: (context, index) => Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: SessionItem(
                                        session: _bookedList[index],
                                      ),
                                    ),
                                  ),
                                ),
                                if (isLoadMore)
                                  const SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              ],
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
