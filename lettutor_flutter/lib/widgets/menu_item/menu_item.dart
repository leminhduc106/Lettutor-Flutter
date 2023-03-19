import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItem {
  const MenuItem({Key? key, required String sourceIcon, required String label})
      : _sourceIcon = sourceIcon,
        _label = label;

  final String _sourceIcon;
  final String _label;

  BottomNavigationBarItem generateItem(context) {
    return BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          _sourceIcon,
          width: 25,
          height: 25,
          color: Colors.blue,
        ),
        icon: SvgPicture.asset(
          _sourceIcon,
          width: 25,
          height: 25,
          color: Colors.grey[600],
        ),
        label: _label);
  }
}
