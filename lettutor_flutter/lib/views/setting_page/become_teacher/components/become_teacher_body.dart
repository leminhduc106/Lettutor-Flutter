import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/setting_page/become_teacher/components/step/step1/step1_page.dart';
import 'package:lettutor_flutter/views/setting_page/become_teacher/components/step/step2/step2_page.dart';
import 'package:lettutor_flutter/views/setting_page/become_teacher/components/step/step3/step3_page.dart';
import 'package:lettutor_flutter/widgets/custom_button/default_button.dart';

class BecomeTeacherBody extends StatefulWidget {
  const BecomeTeacherBody({Key? key}) : super(key: key);

  @override
  _BecomeTeacherBodyState createState() => _BecomeTeacherBodyState();
}

class _BecomeTeacherBodyState extends State<BecomeTeacherBody> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stepper(
      currentStep: _index,
      type: size.width > 576 ? StepperType.horizontal : StepperType.vertical,
      controlsBuilder: (context, controlsDetails) {
        return Row(
          mainAxisAlignment:
              (_index == 2) ? MainAxisAlignment.center : MainAxisAlignment.end,
          children: [
            (_index == 2)
                ? const SizedBox.shrink()
                : SizedBox(
                    width: 100,
                    child: OutlinedButton(
                      style: outlineButtonStyle,
                      onPressed: controlsDetails.onStepCancel,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(_index == 0 ? "Cancel" : "Back"),
                      ),
                    )),
            SizedBox(
                width: 100,
                child: DefaultButton(
                  press: controlsDetails.onStepContinue,
                  text: _index < 2 ? "Continue" : "Submit",
                )),
          ],
        );
      },
      onStepTapped: (index) {
        if (index < _index) {
          setState(() {
            _index = index;
          });
        }
      },
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        } else {
          Navigator.pop(context);
        }
      },
      onStepContinue: () {
        if (_index < 2) {
          setState(() {
            _index += 1;
          });
        } else {
          Navigator.pop(context);
        }
      },
      steps: [
        Step(
          isActive: _index >= 0,
          title: Text(
            "Complete profile",
            style: BaseTextStyle.heading2(
                fontSize: 13, color: BaseColor.secondaryBlue),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: const Step1Page(),
        ),
        Step(
          isActive: _index >= 1,
          title: Text(
            "Video introduction",
            style: BaseTextStyle.heading2(
                fontSize: 13, color: BaseColor.secondaryBlue),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: const Step2Page(),
        ),
        Step(
          isActive: _index >= 2,
          title: Text(
            "Approval",
            style: BaseTextStyle.heading2(
                fontSize: 13, color: BaseColor.secondaryBlue),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: const Step3Page(),
        ),
      ],
    );
  }
}
