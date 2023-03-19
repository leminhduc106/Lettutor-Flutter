import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

const double commonAppbarHeight = 56;

class CustomAppbar extends StatelessWidget implements PreferredSize {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Container(
        margin: const EdgeInsets.all(8.0),
        height: 24,
        child: Image.asset(
          "assets/icons/social/lettutor_icon.png",
          fit: BoxFit.fitHeight,
        ),
      ),
      title: Text('LetTutor',
          style: BaseTextStyle.heading4(color: BaseColor.secondaryBlue)),
      backgroundColor: Colors.white,
      actions: [
        Container(
          margin: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    color: BaseColor.lightGrey,
                    borderRadius: BorderRadius.circular(32.0),
                    border: Border.all(color: BaseColor.blue, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff003399).withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(0, 2))
                    ]),
                child: SizedBox(
                  height: 64,
                  child: Image.asset(
                    "assets/icons/social/icon_vietnam.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )),
        ),
        Container(
          margin: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                _openDrawer();
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    color: BaseColor.lightGrey,
                    borderRadius: BorderRadius.circular(32.0),
                    border: Border.all(color: BaseColor.blue, width: 0.5),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xff003399).withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(0, 2))
                    ]),
                child: SizedBox(
                  height: 64,
                  child: Image.asset(
                    "assets/icons/common/icon_menu.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Widget _openDrawer() {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Item 1'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(commonAppbarHeight);
}
