import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_surffix_icon/custom_suffix_icon.dart';
import 'package:lettutor_flutter/widgets/edit_field/pick_country_field.dart';
import 'package:lettutor_flutter/widgets/edit_field/pick_date_field.dart';
import 'package:provider/provider.dart';

class BasicInfor extends StatefulWidget {
  const BasicInfor({Key? key}) : super(key: key);

  @override
  _BasicInforState createState() => _BasicInforState();
}

class _BasicInforState extends State<BasicInfor> {
  File? _image;
  final TextEditingController _fullnameControlor = TextEditingController();
  final TextEditingController _birthday = TextEditingController();
  final TextEditingController _country = TextEditingController();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Teacher teacher = Provider.of<Teacher>(context);

    _fullnameControlor.text = "";
    _country.text = "";
    _birthday.text = "";
    return Column(
      children: [
        //Basic info
        Row(
          children: [
            Text("Basic info",
                style: BaseTextStyle.heading2(
                    fontSize: 14, color: BaseColor.secondaryBlue)),
            const Spacer(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                pickImage();
                // if (_image != null) {
                //   teacher.uriImage = _image!.path;
                // }
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey.withOpacity(0.5),
                ),
                child: _image != null
                    ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.camera_alt,
                        size: 40,
                      ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: 100,
                child: Text(
                  "Please upload your professional photo. See guidelines",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  style: BaseTextStyle.heading2(
                    fontSize: 14,
                    color: BaseColor.secondaryBlue,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),
        //Full name
        Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: _fullnameControlor,
            onChanged: (value) {},
            decoration: const InputDecoration(
              label: Text("Full name"),
              hintText: "Enter your name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(icon: Icons.person_outline_rounded),
            ),
          ),
        ),

        //Birthday
        const SizedBox(
          height: 15,
        ),
        PickDateField(
          controller: _birthday,
          icon: Icons.date_range_outlined,
          label: "Birthday",
          hint: "Select your birthday",
          onChanged: (value) {},
        ),

        //Country
        const SizedBox(
          height: 15,
        ),
        PickCountryField(
          controller: _country,
          onChanged: (value) {},
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
