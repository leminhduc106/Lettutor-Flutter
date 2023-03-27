import 'package:flutter/material.dart';

class InforText extends StatelessWidget {
  const InforText({Key? key, required String title, required String text})
      : _title = title,
        _text = text,
        super(key: key);

  final String _title, _text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _title,
            style: const TextStyle(fontSize: 17, color: Colors.blue),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              _text,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
