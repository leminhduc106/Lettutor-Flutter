import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({Key? key, required this.icon}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
      child: Icon(icon),
    );
  }
}
