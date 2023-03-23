import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

class PhoneEdition extends StatefulWidget {
  const PhoneEdition({Key? key, required this.changePhone, required this.phone})
      : super(key: key);
  final Function(String) changePhone;
  final String phone;

  @override
  State<PhoneEdition> createState() => _PhoneEditionState();
}

class _PhoneEditionState extends State<PhoneEdition> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 7, left: 5),
            child: Text(
              "Phone number",
              style: BaseTextStyle.heading1(fontSize: 17),
            ),
          ),
          TextField(
            style: TextStyle(fontSize: 17, color: Colors.grey[700]),
            controller: _controller,
            onChanged: (value) => widget.changePhone(value),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 15, right: 15),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 0.3),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 0.3),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              hintText: "Phone number",
            ),
          )
        ],
      ),
    );
  }
}
