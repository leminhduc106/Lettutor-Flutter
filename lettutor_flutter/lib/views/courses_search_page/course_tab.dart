import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/data/course_sample.dart';
import 'package:lettutor_flutter/models/course/course.dart';
import 'package:woozy_search/woozy_search.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;

class CourseTab extends StatefulWidget {
  const CourseTab({Key? key}) : super(key: key);

  @override
  State<CourseTab> createState() => _CourseTabState();
}

class _CourseTabState extends State<CourseTab> {
  List<Course> _results = [];
  final TextEditingController _controller = TextEditingController();

  // * Debounce timer for search performance
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final woozy = Woozy();
    List<String> names =
        CoursesSample.courses.map((course) => course.title).toList();
    woozy.setEntries(names);

    if (_controller.text.isEmpty) {
      setState(() {
        _results = CoursesSample.courses;
      });
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
                final res = woozy.search(value);
                List<Course> newResults = [];
                for (int i = 0; i < res.length; i++) {
                  if (res[i].score >= 0.3) {
                    newResults.add(CoursesSample.courses
                        .firstWhere((course) => course.title == res[i].text));
                  }
                }

                setState(() {
                  _results = newResults;
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
                hintText: "Search courses..."),
          ),
        ),
        Expanded(
          child: _controller.text.isNotEmpty && _results.isEmpty
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
                            "Not found any match result...",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          routes.coursePage,
                          arguments: {"course": _results[index]},
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: SizedBox(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                _results[index].image,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: 210,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _results[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _results[index].level,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[800]),
                                          ),
                                          Text(
                                            "${_results[index].topics.length} Lessons",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[800]),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        )
      ],
    );
  }
}
