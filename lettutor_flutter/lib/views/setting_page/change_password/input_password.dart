import 'package:flutter/material.dart';

class InputPassword extends StatelessWidget {
  const InputPassword({Key? key, required this.controller, required this.title}) : super(key: key);
  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
          ),
        ),
        TextField(
          style: TextStyle(fontSize: 15, color: Colors.grey[900]),
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade200,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            hintText: "********",
          ),
        )
      ],
    );
  }
}
