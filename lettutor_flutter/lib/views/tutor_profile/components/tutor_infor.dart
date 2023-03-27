import 'package:flutter/material.dart';
import 'package:lettutor_flutter/models/tutor/tutor.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/avatar_circle/avatar_circle.dart';
import 'package:lettutor_flutter/widgets/rate_stars/rate_stars.dart';

class TutorInfor extends StatefulWidget {
  const TutorInfor({Key? key, required this.tutor}) : super(key: key);

  final Tutor tutor;

  @override
  State<TutorInfor> createState() => _TutorInforState();
}

class _TutorInforState extends State<TutorInfor> {
  bool _isExpanded = false;
  int maxLength = 200;

  @override
  Widget build(BuildContext context) {
    String text = widget.tutor.intro;
    if (!_isExpanded && text.length > maxLength) {
      text = "${text.substring(0, maxLength)}...";
    }

    return Column(
      children: [
        _isExpanded
            ? Text(
                text,
                style: BaseTextStyle.body1(fontSize: 15, color: Colors.black54),
              )
            : Text(
                text,
                style: BaseTextStyle.body1(fontSize: 15, color: Colors.black54),
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
              ),
        if (text.length > maxLength)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? "less" : "more",
              style: BaseTextStyle.body2(fontSize: 14, color: Colors.blue),
            ),
          ),
      ],
    );
  }
}
