import 'package:flutter/material.dart';
import 'package:lettutor_flutter/views/authenticate/login_page.dart';
import 'package:lettutor_flutter/views/authenticate/register_page.dart';
import 'package:lettutor_flutter/views/home/tutor_detail_page.dart';
import 'package:lettutor_flutter/views/home/tutor_list_page.dart';

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
      home: const TutorDetailPage(),
    );
  }
}
