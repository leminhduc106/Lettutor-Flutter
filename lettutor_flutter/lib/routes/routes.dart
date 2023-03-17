import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lettutor_flutter/views/authenticate/forgot_password_page.dart';
import 'package:lettutor_flutter/views/authenticate/login_page.dart';
import 'package:lettutor_flutter/views/authenticate/register_page.dart';
import 'package:lettutor_flutter/views/home/booked_schedule_page.dart';
import 'package:lettutor_flutter/views/home/discover_courses_page.dart';
import 'package:lettutor_flutter/views/home/find_tutor_page.dart';
import 'package:lettutor_flutter/views/home/history_lesson_page.dart';
import 'package:lettutor_flutter/views/home/tutor_detail_page.dart';

const String loginPage = 'login';
const String registerPage = 'register';
const String forgotPasswordPage = 'forgot_password';
const String findTutorPage = 'findTutor';
const String tutorDetailPage = 'tutorDetail';
const String bookedSchedulePage = 'bookedSchedule';
const String historyLessonPage = 'historyLesson';
const String discoverCoursePage = 'discoverCourse';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case registerPage:
      return MaterialPageRoute(builder: (context) => const RegisterPage());
    case forgotPasswordPage:
      return MaterialPageRoute(
          builder: (context) => const ForgetPasswordPage());
    case findTutorPage:
      return MaterialPageRoute(builder: (context) => const FindTutorPage());
    case tutorDetailPage:
      return MaterialPageRoute(builder: (context) => const TutorDetailPage());
    case bookedSchedulePage:
      return MaterialPageRoute(
          builder: (context) => const BookedSchedulePage());
    case historyLessonPage:
      return MaterialPageRoute(builder: (context) => const HistoryLessonPage());
    case discoverCoursePage:
      return MaterialPageRoute(
          builder: (context) => const DiscoverCoursePage());

    // case recordVideoPage:
    //   return MaterialPageRoute(builder: (context) {
    //     Map<String, String> arg = settings.arguments as Map<String, String>;
    //     return RecordVideo(url: arg['url'] as String);
    //   });

    // case courseTopicPDF:
    //   return MaterialPageRoute(builder: (context) {
    //     Map<String, String> arg = settings.arguments as Map<String, String>;
    //     return CourseTopicPDFViewer(url: arg['url'] as String, title: arg['title'] as String);
    //   });

    // case tutorProfilePage:
    //   return MaterialPageRoute(builder: (context) {
    //     Map<String, String> arg = settings.arguments as Map<String, String>;
    //     return TutorProfile(tutorID: arg['tutorID'] as String);
    //   });

    // case coursePage:
    //   return MaterialPageRoute(builder: (context) {
    //     Map<String, String> arg = settings.arguments as Map<String, String>;
    //     return CoursePage(courseId: arg["courseId"] as String);
    //   });

    // case feedbackPage:
    //   return MaterialPageRoute(builder: (context) {
    //     Map<String, BookingInfo> arg = settings.arguments as Map<String, BookingInfo>;
    //     return FeedbackPage(bookingInfo: arg["bookingInfo"] as BookingInfo);
    //   });

    default:
      return MaterialPageRoute(builder: (context) => const LoginPage());
  }
}
