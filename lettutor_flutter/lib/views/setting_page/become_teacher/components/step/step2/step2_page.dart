import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/media/video_widget.dart';

class Step2Page extends StatefulWidget {
  const Step2Page({Key? key}) : super(key: key);

  @override
  _Step2PageState createState() => _Step2PageState();
}

class _Step2PageState extends State<Step2Page> {
  File? _videoFile;

  Future pickMedia(ImageSource imageSource) async {
    try {
      final file = await ImagePicker().pickVideo(source: imageSource);
      if (file == null) return;

      final imageTemp = File(file.path);
      setState(() {
        _videoFile = imageTemp;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick video: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Introduce yourself",
              style: BaseTextStyle.heading2(
                  fontSize: 14, color: BaseColor.secondaryBlue),
            ),
            const Spacer()
          ],
        ),
        const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Let students know what they can expect from a lesson with you by recording a video highlighting your teaching style, expertise and personality. Students can be nervous to speak with a foreigner, so it really helps to have a friendly video that introduces yourself and invites students to call you.",
              textAlign: TextAlign.justify,
              overflow: TextOverflow.clip,
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Divider(
            height: 3,
            color: BaseColor.secondaryBlue.withOpacity(0.5),
          ),
        ),

        //Basic info
        Row(
          children: [
            Text("Introduction video",
                style: BaseTextStyle.heading2(
                    fontSize: 13, color: BaseColor.secondaryBlue)),
            const Spacer(),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.symmetric(vertical: 20),
                color: BaseColor.secondaryBlue.withOpacity(0.2),
                child: const Text(
                  'A few helpful tips:\n1. Find a clean and quiet space\n2. Smile and look at the camera\n3. Dress smart\n4. Speak for 1-3 minutes\n5. Brand yourself and have fun!',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        ),

        _videoFile == null ? Container() : VideoWidget(_videoFile!),

        const SizedBox(height: 10),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                onPressed: () {
                  pickMedia(ImageSource.gallery);
                },
                style: outlineColorButtonStyle,
                child: const Text("Pick a video"),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {
                  pickMedia(ImageSource.camera);
                },
                style: outlineColorButtonStyle,
                child: const Text("Take video"),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Divider(
            height: 3,
            color: BaseColor.secondaryBlue.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
