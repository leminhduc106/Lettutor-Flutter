import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/course_model/course_category.dart';
import 'package:lettutor_flutter/models/ebook_model/ebook_model.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;
import 'package:lettutor_flutter/services/ebook_service.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class BookTab extends StatefulWidget {
  const BookTab({Key? key}) : super(key: key);

  @override
  State<BookTab> createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> {
  List<Ebook> _results = [];
  final TextEditingController _controller = TextEditingController();
  final listLevels = {
    "0": "Any level",
    "1": "Beginner",
    "2": "High Beginner",
    "3": "Pre-Intermediate",
    "4": "Intermediate",
    "5": "Upper-Intermediate",
    "6": "Advanced",
    "7": "Proficiency"
  };
  Timer? _debounce;
  String category = "";
  String search = "";
  bool isLoading = true;
  bool isLoadMore = false;
  int page = 1;
  int perPage = 10;
  late ScrollController _scrollController;
  String? token;

  List<Widget> _generateChips(List<CourseCategory> categories) {
    return categories
        .map(
          (chip) => GestureDetector(
            onTap: () {
              if (category == chip.id) {
                setState(() {
                  category = "";
                  _results = [];
                  page = 1;
                  isLoading = true;
                });
              } else {
                setState(() {
                  category = chip.id;
                  _results = [];
                  page = 1;
                  isLoading = true;
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 5, right: 8),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: chip.id == category ? Colors.blue[50] : Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: chip.id == category
                        ? Colors.blue[100] as Color
                        : Colors.grey[400] as Color),
              ),
              child: Text(
                chip.title,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      chip.id == category ? Colors.blue[400] : Colors.grey[600],
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

  void fetchListEbook(int page, int size, String token) async {
    final response = await EbookService.getListEbookWithPagination(
        page, size, token,
        categoryId: category, q: search);
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
        List<Ebook> response = await EbookService.getListEbookWithPagination(
            page, perPage, token as String,
            categoryId: category, q: search);
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

    if (isLoading) {
      fetchListEbook(1, 10, authProvider.tokens!.access.token);
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 10),
          child: TextField(
            style: TextStyle(fontSize: 12, color: Colors.grey[900]),
            controller: _controller,
            onChanged: (value) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 500), () {
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                hintText: lang.searchEbook),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          height: 37,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _generateChips(appProvider.allCourseCategories).length,
            itemBuilder: (context, index) {
              return _generateChips(appProvider.allCourseCategories)[index];
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GestureDetector(
                              onTap: () async {
                                if (await canLaunch(_results[index].fileUrl)) {
                                  await launch(_results[index].fileUrl);
                                }
                              },
                              child: Card(
                                elevation: 8,
                                child: SizedBox(
                                  height: 600,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: _results[index].imageUrl,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 10, 10, 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _results[index].name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 8, bottom: 15),
                                              child: Text(
                                                _results[index].description,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[800]),
                                              ),
                                            ),
                                            Text(
                                              listLevels[
                                                      _results[index].level] ??
                                                  "Any level",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey[800]),
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
                        },
                      ),
              ),
      ],
    );
  }
}
