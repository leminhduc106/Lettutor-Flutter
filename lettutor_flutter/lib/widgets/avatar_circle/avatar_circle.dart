import 'package:flutter/material.dart';

class AvatarCircle extends StatelessWidget {
  const AvatarCircle({Key? key, required double width, required double height, required String source})
      : _width = width,
        _height = height,
        _source = source,
        super(key: key);

  final double _width;
  final double _height;
  final String _source;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_source),
          fit: BoxFit.cover,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
      ),
    );
  }
}
