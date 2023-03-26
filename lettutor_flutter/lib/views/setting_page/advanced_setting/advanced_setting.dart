import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/provider/setting.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_modal_sheet/custom_modal_sheet.dart';
import 'package:provider/provider.dart';

class AdvancedSettingPage extends StatelessWidget {
  const AdvancedSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingProvider>(context);
    List<String> lans = ["Tiếng Việt", "English"];
    String? current_language;

    void selectLanguage(int index) {
      Navigator.pop(context);
      if (index == 0) {
        current_language = lans[0];
        setting.changeLanguage(lans[0]);
      } else {
        current_language = lans[1];
        setting.changeLanguage(lans[1]);
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          title: Text("Advanced Settings",
              style: BaseTextStyle.heading2(
                  fontSize: 20, color: BaseColor.secondaryBlue)),
        ),
        body: GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 42),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.black12, width: 0.1),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff003399).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ]),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Language",
                  style: BaseTextStyle.heading3(fontSize: 17),
                ),
                Text(
                  setting.language,
                  style: BaseTextStyle.body2(fontSize: 14, color: Colors.grey),
                )
              ],
            ),
          ),
          onTap: () => CustomModalSheet.buildLanguageBottom(
              context: context,
              currentLang: current_language,
              index: (index) => selectLanguage(index)),
        ),
      ),
    );
  }
}
