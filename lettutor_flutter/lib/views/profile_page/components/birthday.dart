import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:provider/provider.dart';

class BirthdayEdition extends StatefulWidget {
  const BirthdayEdition({
    Key? key,
    required this.setBirthday,
    required this.birthday,
  }) : super(key: key);

  final Function(
      {DateTime? birthday,
      String phone,
      String country,
      String level}) setBirthday;
  final DateTime? birthday;

  @override
  State<BirthdayEdition> createState() => _BirthdayEditionState();
}

class _BirthdayEditionState extends State<BirthdayEdition> {
  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.birthday ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2023),
    );
    if (picked != null && picked != widget.birthday) {
      widget.setBirthday(birthday: picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppProvider>(context).language;

    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              lang.birthday,
              style: BaseTextStyle.heading1(fontSize: 17),
            ),
          ),
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 7),
              padding: const EdgeInsets.only(left: 15, right: 15),
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26, width: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    stringFormatDateTime(widget.birthday ?? DateTime.now()),
                    style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                  ),
                  SvgPicture.asset("assets/svg/ic_calendar.svg", width: 16),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

String stringFormatDateTime(DateTime date) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  return "${twoDigits(date.day)}/${twoDigits(date.month)}/${date.year}";
}
