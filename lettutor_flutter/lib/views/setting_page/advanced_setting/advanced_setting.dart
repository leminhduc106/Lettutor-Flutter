import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/models/language_model/language_en.dart';
import 'package:lettutor_flutter/models/language_model/language_vi.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_modal_sheet/custom_modal_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdvancedSettingPage extends StatefulWidget {
  AdvancedSettingPage({Key? key}) : super(key: key);

  @override
  State<AdvancedSettingPage> createState() => _AdvancedSettingPageState();
}

class _AdvancedSettingPageState extends State<AdvancedSettingPage> {
  final en = English();

  final vi = VietNamese();

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    void selectLanguage(int value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value == 0) {
        appProvider.language = vi;
        await prefs.setString("lang", "VI");
      } else {
        appProvider.language = en;
        await prefs.setString("lang", "EN");
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
          title: Text(lang.advancedSetting,
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
                  lang.languages,
                  style: BaseTextStyle.heading3(fontSize: 17),
                ),
                Text(
                  appProvider.language.name == "EN" ? "English" : "Tiếng Việt",
                  style: BaseTextStyle.body2(fontSize: 14, color: Colors.grey),
                )
              ],
            ),
          ),
          onTap: () => CustomModalSheet.buildLanguageBottom(
              context: context,
              currentLang:
                  appProvider.language.name == "EN" ? "English" : "Tiếng Việt",
              index: (index) => selectLanguage(index)),
        ),
      ),
    );
  }
}
