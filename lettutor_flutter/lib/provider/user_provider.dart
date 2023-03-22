import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/data/tutors_sample.dart';
import 'package:lettutor_flutter/data/user_sample.dart';

import 'package:lettutor_flutter/models/user/booking.dart';
import 'package:lettutor_flutter/models/user/session.dart';
import 'package:lettutor_flutter/models/user/user.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class UserProvider extends ChangeNotifier {
  late User user;
  List<String> idFavorite = [];
  File? uploadImage;

  UserProvider() {
    user = UsersSample.users[0];
    user.sessionHistory = [
      Session(
        id: uuid.v4(),
        tutor: TutorsSample.tutors[0],
        start: DateTime(2023, 11, 30, 6, 0),
        duration: 10000,
      ),
      Session(
        id: uuid.v4(),
        tutor: TutorsSample.tutors[1],
        start: DateTime(2023, 12, 1, 6, 0),
        duration: 10000,
      ),
      Session(
        id: uuid.v4(),
        tutor: TutorsSample.tutors[2],
        start: DateTime(2023, 12, 2, 6, 0),
        duration: 10000,
      ),
    ];

    notifyListeners();
  }

  void updateUser(User user) {
    this.user = user;
    notifyListeners();
  }

  void updateBirthday(DateTime birthday) {
    user.birthDay = birthday;
    notifyListeners();
  }

  void updatePhone(String phone) {
    user.phone = phone;
    notifyListeners();
  }

  void updateCountry(String country) {
    user.country = country;
    notifyListeners();
  }

  void updateLevel(String level) {
    user.level = level;
    notifyListeners();
  }

  void updateTopicToLearn(String topic) {
    user.topicToLearn = topic;
    notifyListeners();
  }

  void addFavorite(String id) {
    if (TutorsSample.tutors.where((tutor) => tutor.id == id).isNotEmpty) {
      idFavorite.add(id);
      notifyListeners();
    }
  }

  void removeFavorite(String id) {
    if (TutorsSample.tutors.where((tutor) => tutor.id == id).isNotEmpty) {
      idFavorite.removeWhere((element) => element == id);
      notifyListeners();
    }
  }

  void addBooking(Booking booking) {
    user.bookingHistory.add(booking);
    notifyListeners();
  }

  void cancelBooking(String id) {
    for (int index = 0; index < user.bookingHistory.length; index++) {
      if (user.bookingHistory[index].id == id) {
        user.bookingHistory[index].isCancelled = true;
        notifyListeners();
        break;
      }
    }
  }

  void uploadProfileImage(File image) {
    uploadImage = image;
    notifyListeners();
  }
}
