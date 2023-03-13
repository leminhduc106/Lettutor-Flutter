import 'package:flutter/material.dart';
import 'package:lettutor_flutter/views/authenticate/forgot_password_page.dart';
import 'package:lettutor_flutter/views/authenticate/login_page.dart';
import 'package:lettutor_flutter/views/authenticate/register_page.dart';
import 'package:lettutor_flutter/views/home/booked_schedule_page.dart';
import 'package:lettutor_flutter/views/home/discover_courses_page.dart';
import 'package:lettutor_flutter/views/home/history_lesson_page.dart';
import 'package:lettutor_flutter/views/home/tutor_detail_page.dart';
import 'package:lettutor_flutter/views/home/find_tutor_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DiscoverCoursePage(),
    );
  }
}
