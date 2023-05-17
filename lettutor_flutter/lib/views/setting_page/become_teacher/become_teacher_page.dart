import 'package:flutter/material.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:provider/provider.dart';

import 'components/become_teacher_body.dart';

class BecomeTeacherPage extends StatelessWidget {
  static String routeName = "/become_teacher";
  const BecomeTeacherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppProvider>(context).language;

    // final ProfileProvider profile = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(lang.becomeTutor,
            style: BaseTextStyle.heading2(
                fontSize: 20, color: BaseColor.secondaryBlue)),
      ),
      body: const BecomeTeacherBody(),
    );
  }
}
