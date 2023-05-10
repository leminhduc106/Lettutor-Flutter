import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

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
          width: 200,
          height: 20,
          color: AppColors.primary,
        ),
        icon: SvgPicture.asset(
          _sourceIcon,
          width: 20,
          height: 20,
          color: Colors.grey[600],
        ),
        label: _label);
  }
}
