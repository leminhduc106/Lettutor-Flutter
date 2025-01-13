import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/tutor_model/tutor_info_model.dart';
import 'package:lettutor_flutter/models/user_model/learning_topic_model.dart';
import 'package:lettutor_flutter/services/tutor_service.dart';
import 'package:lettutor_flutter/views/tutors_search_page/tutor_item.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TutorsPage extends StatefulWidget {
  const TutorsPage({Key? key}) : super(key: key);

  @override
  _TutorsPageState createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
  final TextEditingController _controller = TextEditingController();

  List<TutorInfo> _results = [];
  String specialist = "";
  Timer? _debounce;
  String search = "";
  bool isLoading = true;
  bool isLoadMore = false;
  int page = 1;
  int perPage = 10;
  late ScrollController _scrollController;
  String? token;

  List<Widget> _generateChips(List<dynamic> chips) {
    return chips
        .map(
          (chip) => GestureDetector(
            onTap: () {
              setState(() {
                specialist = chip.key;
                isLoading = true;
                _results = [];
                page = 1;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 5, right: 8),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color:
                    chip.key == specialist ? Colors.blue[50] : Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: chip.key == specialist
                        ? Colors.blue[100] as Color
                        : Colors.grey[400] as Color),
              ),
              child: Text(
                chip.name,
                style: TextStyle(
                  fontSize: 12,
                  color: chip.key == specialist
                      ? Colors.blue[400]
                      : Colors.grey[600],
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.removeListener(loadMore);
    super.dispose();
  }

  void fetchTutors(int page, int size, String token) async {
    final response = await TutorService.searchTutor(page, size, token,
        search: search, specialties: [specialist]);
    if (mounted) {
      setState(() {
        _results.addAll(response);
        isLoading = false;
      });
    }
  }

  void loadMore() async {
    if (_scrollController.position.extentAfter < page * perPage) {
      setState(() {
        isLoadMore = true;
        page++;
      });

      try {
        final response = await TutorService.searchTutor(
            page, perPage, token as String,
            search: search, specialties: [specialist]);
        if (mounted) {
          setState(() {
            _results.addAll(response);
            isLoadMore = false;
          });
        }
      } catch (e) {
        showTopSnackBar(Overlay.of(context),
            const CustomSnackBar.error(message: "Cannot load more"),
            animationDuration: const Duration(milliseconds: 1000),
            displayDuration: const Duration(microseconds: 4000));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    setState(() {
      token = authProvider.tokens!.access.token;
    });

    List<dynamic> chips = [];
    chips.add(LearnTopic(id: 1, key: "", name: "All"));
    chips.addAll(appProvider.allLearningTopics);
    chips.addAll(appProvider.allTestPreparations);

    if (isLoading) {
      fetchTutors(1, 10, token as String);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextField(
                style: TextStyle(fontSize: 12, color: Colors.grey[900]),
                controller: _controller,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 1000), () {
                    setState(() {
                      search = value;
                      _results = [];
                      page = 1;
                      isLoading = true;
                    });
                  });
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(13),
                      child: SvgPicture.asset(
                        "assets/svg/ic_search.svg",
                        color: Colors.grey[600],
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(left: 5, right: 5),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: lang.searchTutor)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _generateChips(chips).length,
              itemBuilder: (context, index) {
                return _generateChips(chips)[index];
              },
              shrinkWrap: true,
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: _results.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/ic_notfound.svg",
                                  width: 200,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    lang.errNotAnyResult,
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _results.length,
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TutorCardInfo(tutor: _results[index]),
                            );
                          },
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
    );
  }
}
