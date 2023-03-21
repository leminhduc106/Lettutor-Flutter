import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/data/tutors_sample.dart';
import 'package:lettutor_flutter/models/tutor/tutor.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/tutors_search_page/tutor_item.dart';
import 'package:woozy_search/woozy_search.dart';

class TutorsPage extends StatefulWidget {
  const TutorsPage({Key? key}) : super(key: key);

  @override
  _TutorsPageState createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
  final List<String> _chips = [
    "All",
    "English for kids",
    "English for Business",
    "Conversational",
    "STARTERS",
    "MOVERS",
    "FLYERS",
    "KET",
    "PET",
    "IELTS",
    "TOEFL",
    "TOEIC"
  ];
  final TextEditingController _controller = TextEditingController();

  List<Tutor> _results = [];
  String specialist = "All";

  // * Debounce timer for search performance
  Timer? _debounce;

  List<Widget> _generateChips() {
    return _chips
        .map(
          (chip) => GestureDetector(
            onTap: () {
              setState(() {
                specialist = chip;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 5, right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              decoration: BoxDecoration(
                color: chip == specialist ? Colors.blue[50] : Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    color: chip == specialist
                        ? Colors.blue[100] as Color
                        : Colors.grey[400] as Color),
              ),
              child: Text(chip,
                  style: BaseTextStyle.heading4(
                    fontSize: 12,
                    color: chip == specialist
                        ? Colors.blue[400]
                        : Colors.grey[600],
                  )),
            ),
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final woozy = Woozy();
    List<String> names =
        TutorsSample.tutors.map((tutor) => tutor.fullName).toList();
    woozy.setEntries(names);

    if (_controller.text.isEmpty) {
      setState(() {
        _results = TutorsSample.tutors;
      });
    }

    if (specialist != "All") {
      _results = _results
          .where((tutor) => tutor.specialties.contains(specialist))
          .toList();
    }

    return SingleChildScrollView(
      child: Padding(
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
                      final res = woozy.search(value);
                      List<Tutor> newResults = [];
                      for (int i = 0; i < res.length; i++) {
                        if (res[i].score >= 0.3) {
                          newResults.add(TutorsSample.tutors.firstWhere(
                              (tutor) => tutor.fullName == res[i].text));
                        }
                      }

                      setState(() {
                        _results = newResults;
                        if (specialist != "All") {
                          _results = _results
                              .where((tutor) =>
                                  tutor.specialties.contains(specialist))
                              .toList();
                        }
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
                      hintText: "Search Tutors")),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _generateChips().length,
                itemBuilder: (context, index) {
                  return _generateChips()[index];
                },
                shrinkWrap: true,
              ),
            ),
            _controller.text.isNotEmpty && _results.isEmpty
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
                    itemBuilder: (context, index) {
                      Tutor tutor = _results[index];
                      return TutorCardInfo(tutor: tutor);
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
          ],
        ),
      ),
    );
  }
}
