import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';

class CustomTextField {
  static Widget common(
      {required ValueChanged<String> onChanged,
      String? labelText,
      String? hintText,
      String? errorText,
      String? initialValue,
      bool required = false,
      bool isObscured = false,
      bool enable = true,
      EdgeInsets? contentPadding,
      FocusNode? focusNode,
      TextEditingController? textEditingController,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool autoFocus = false,
      int? maxLength,
      int? maxLines,
      Color? fillColor,
      bool readOnly = false,
      TextStyle? textStyle,
      TextAlign textAlign = TextAlign.start,
      TextAlignVertical textAlignVertical = TextAlignVertical.center,
      TextInputAction? textInputAction,
      VoidCallback? edit,
      VoidCallback? onPrefixIconTap,
      String? prefixIconPath,
      String? editIconPath,
      TextInputType? textInputType}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if ((labelText != null))
            Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(labelText, style: BaseTextStyle.subtitle2()),
                  if (required == true)
                    Text(" *",
                        style: BaseTextStyle.subtitle2(color: BaseColor.red))
                ])),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [BaseBoxShadow.common]),
              child: TextFormField(
                  initialValue: initialValue,
                  onChanged: onChanged,
                  enabled: enable,
                  readOnly: readOnly,
                  obscureText: isObscured,
                  obscuringCharacter: "*",
                  style: textStyle ?? BaseTextStyle.body2(),
                  focusNode: focusNode,
                  controller: textEditingController,
                  autofocus: autoFocus,
                  textAlign: textAlign,
                  textCapitalization: textCapitalization,
                  textAlignVertical: textAlignVertical,
                  textInputAction: textInputAction,
                  maxLength: maxLength,
                  maxLines: maxLines ?? 1,
                  keyboardType: textInputType,
                  decoration: InputDecoration(
                      prefixIcon: onPrefixIconTap != null
                          ? IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                onPrefixIconTap();
                              },
                              icon: ClipRRect(
                                child: Image.asset(
                                  prefixIconPath ??
                                      "assets/icons/action/icon_search.png",
                                  height: 24,
                                  fit: BoxFit.fitHeight,
                                ),
                              ))
                          : null,
                      suffixIcon: edit != null
                          ? IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                edit();
                              },
                              icon: ClipRRect(
                                child: Image.asset(
                                  editIconPath ??
                                      "assets/icons/action/icon_edit.png",
                                  height: 20,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                          : null,
                      hintText: hintText,
                      counter: const Offstage(),
                      fillColor: fillColor ??
                          (readOnly ? BaseColor.lightGrey : Colors.white),
                      filled: true,
                      contentPadding: contentPadding ??
                          const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                      hintStyle: BaseTextStyle.body2(color: BaseColor.hint),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                            color: errorText != null
                                ? BaseColor.red
                                : Colors.transparent,
                            width: 0.0,
                          )),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 0.0,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                              color: errorText != null
                                  ? BaseColor.red
                                  : readOnly
                                      ? Colors.white
                                      : BaseColor.blue,
                              width: 1.0)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                              color: BaseColor.red, width: 1.0)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                              color: BaseColor.red, width: 1.0))))),
          if (errorText != null)
            Text(errorText, style: BaseTextStyle.caption(color: BaseColor.red))
        ]);
  }
}
