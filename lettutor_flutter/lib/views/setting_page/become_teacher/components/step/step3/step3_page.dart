import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Step3Page extends StatelessWidget {
  const Step3Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 170, child: SvgPicture.asset("assets/svg/done.svg")),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "You have done all the steps",
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ),
        const Text(
          "Please wait for the operator's approval",
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
