import 'package:flutter/cupertino.dart';
import 'package:lettutor_flutter/data/tutors_sample.dart';
import 'package:lettutor_flutter/models/tutor/tutor.dart';
import 'package:lettutor_flutter/views/home/components/card_tutor.dart';

class RecommendTutors {
  List<Widget> tutors = [];

  RecommendTutors() {
    List<Tutor> sampleTutors = TutorsSample.tutors.sublist(0, 4);
    for (int i = 0; i < sampleTutors.length; i++) {
      tutors.add(CardTutor(tutor: sampleTutors[i]));
    }
  }
}
