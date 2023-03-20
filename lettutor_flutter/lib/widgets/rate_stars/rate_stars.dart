import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RateStars extends StatelessWidget {
  const RateStars({Key? key, required this.count}) : super(key: key);
  final int count;

  List<Widget> _buildStars() {
    final stars = <Widget>[];
    for (var i = 0; i < 5; i++) {
      if (i < count) {
        stars.add(SvgPicture.asset(
          "assets/svg/ic_star.svg",
          width: 20,
          height: 20,
          color: Colors.yellow[700],
        ));
      } else {
        stars.add(SvgPicture.asset(
          "assets/svg/ic_star_empty.svg",
          width: 20,
          height: 20,
          color: Colors.yellow[700],
        ));
      }
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildStars(),
    );
  }
}
