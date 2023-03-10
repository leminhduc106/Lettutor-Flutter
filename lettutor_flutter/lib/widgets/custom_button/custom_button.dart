import 'package:flutter/material.dart';
import '../../utils/base_style.dart';

class CustomButton {
  static Widget common(
      {required Function() onTap,
      required String content,
      bool? isLoading,
      bool isBorderRadius = true,
      bool isShadow = true}) {
    Widget text = Text(
      content,
      style: BaseTextStyle.button(color: Colors.white),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
    Widget loading = const SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
    );
    Widget button = Container(
        height: 48,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: BaseColor.secondaryBlue,
            borderRadius: isBorderRadius ? BorderRadius.circular(16.0) : null,
            boxShadow: [if (isShadow) BaseBoxShadow.componentBoxShadow]),
        child: (isLoading == true) ? loading : text);
    return GestureDetector(onTap: onTap, child: button);
  }

  static Widget small(
      {required VoidCallback onTap,
      required String content,
      Color? color,
      Color? textColor}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: color ?? BaseColor.blue,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff003399).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 4))
                ]),
            child: Text(content,
                style: BaseTextStyle.subtitle2(
                    color: textColor ?? Colors.white))));
  }

  static Widget withIcon(
      {required VoidCallback onTap,
      required String content,
      required String iconPath}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 51, 153, 1),
            borderRadius: BorderRadius.circular(16.0)),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 20,
              height: 20,
              color: Colors.white,
            ),
            const SizedBox(width: 6),
            Text(content, style: BaseTextStyle.subtitle1(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  static Widget whiteBackGround(
      {required VoidCallback onTap,
      required String content,
      bool isShadow = true,
      Color textColor = BaseColor.blue,
      Color outlineColor = BaseColor.blue}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: outlineColor, width: 0.5),
                boxShadow: [
                  if (isShadow)
                    BoxShadow(
                        color: const Color(0xff003399).withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 2))
                ]),
            child:
                Text(content, style: BaseTextStyle.button(color: textColor))));
  }

  static Widget lightBlue(
      {required Function() onTap,
      required String content,
      bool? isLoading,
      bool isShadow = true}) {
    Widget text = Text(
      content,
      style: BaseTextStyle.button(color: BaseColor.blue),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
    Widget loading = const SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
    );
    Widget button = Container(
        height: 48,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: BaseColor.secondaryBlue,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [if (isShadow) BaseBoxShadow.componentBoxShadow]),
        child: (isLoading == true) ? loading : text);
    return GestureDetector(onTap: onTap, child: button);
  }

  static Widget whiteBtnWithIcon(
      {required VoidCallback onTap,
      required String content,
      bool isShadow = true,
      bool isBorderRadius = true,
      Color textColor = BaseColor.blue,
      Color outlineColor = BaseColor.blue,
      required String iconPath}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: isBorderRadius
                    ? BorderRadius.circular(32.0)
                    : BorderRadius.circular(0),
                border: Border.all(color: outlineColor, width: 0.5),
                boxShadow: [
                  if (isShadow)
                    BoxShadow(
                        color: const Color(0xff003399).withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 2))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 24,
                  child: Image.asset(
                    iconPath,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(width: 8),
                Text(content, style: BaseTextStyle.button(color: textColor)),
              ],
            )));
  }

  static Widget transparentWithTrailingIcon(
      {required VoidCallback onTap,
      required String content,
      bool isShadow = true,
      Color textColor = BaseColor.blue,
      Color outlineColor = BaseColor.blue}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: outlineColor, width: 0.5),
                boxShadow: [
                  if (isShadow)
                    BoxShadow(
                        color: const Color(0xff003399).withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 2))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(content, style: BaseTextStyle.button(color: textColor)),
                SizedBox(
                  height: 16,
                  child: Image.asset(
                    "assets/icons/directions/blue_next.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            )));
  }
}
