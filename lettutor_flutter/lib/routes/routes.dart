import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lettutor_flutter/models/course/course.dart';
import 'package:lettutor_flutter/models/tutor/tutor.dart';
import 'package:lettutor_flutter/navigation.dart';
import 'package:lettutor_flutter/views/authenticate/forgot_password_page.dart';
import 'package:lettutor_flutter/views/authenticate/login_page.dart';
import 'package:lettutor_flutter/views/authenticate/register_page.dart';
import 'package:lettutor_flutter/views/course/course.dart';
import 'package:lettutor_flutter/views/courses_search_page/book_detail.dart';
import 'package:lettutor_flutter/views/feedback_page.dart/feedback_page.dart';
import 'package:lettutor_flutter/views/home/home_page.dart';
import 'package:lettutor_flutter/views/lesson/lesson.dart';
import 'package:lettutor_flutter/views/profile_page/profile_page.dart';
import 'package:lettutor_flutter/views/setting_page/advanced_setting/advanced_setting.dart';
import 'package:lettutor_flutter/views/setting_page/booking_history/booking_history.dart';
import 'package:lettutor_flutter/views/setting_page/session_history/session_history.dart';
import 'package:lettutor_flutter/views/tutor_profile/tutor_profile.dart';

const String loginPage = 'login';
const String registerPage = 'register';
const String forgotPasswordPage = 'forgot_password';
const String homePage = 'home';
const String profilePage = 'profile';
const String tutorProfilePage = 'tutorProfile';
const String coursePage = 'course';
const String lessonPage = 'lesson';
const String bookingHistoryPage = 'bookingHistory';
const String sessionHistoryPage = 'sessionHistory';
const String advancedSettingPage = 'advancedSetting';
const String feedbackPage = 'feedback';
const String bookDetailPage = 'bookDetail';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case registerPage:
      return MaterialPageRoute(builder: (context) => const RegisterPage());
    case forgotPasswordPage:
      return MaterialPageRoute(
          builder: (context) => const ForgetPasswordPage());
    case homePage:
      return MaterialPageRoute(
          builder: (context) => const CustomNavigationBar());
    case profilePage:
      return MaterialPageRoute(builder: (context) => const ProfilePage());
    case lessonPage:
      return MaterialPageRoute(builder: (context) => const LessonPage());
    case bookingHistoryPage:
      return MaterialPageRoute(
          builder: (context) => const BookingHistoryPage());
    case sessionHistoryPage:
      return MaterialPageRoute(
          builder: (context) => const SessionHistoryPage());
    case advancedSettingPage:
      return MaterialPageRoute(
          builder: (context) => const AdvancedSettingPage());
    case bookDetailPage:
      return MaterialPageRoute(builder: (context) => const BookDetail());

    case tutorProfilePage:
      return MaterialPageRoute(builder: (context) {
        Map<String, Tutor> arg = settings.arguments as Map<String, Tutor>;
        return TutorProfile(tutor: arg["tutor"] as Tutor);
      });

    case coursePage:
      return MaterialPageRoute(builder: (context) {
        Map<String, Course> arg = settings.arguments as Map<String, Course>;
        return CoursePage(course: arg["course"] as Course);
      });

    case feedbackPage:
      return MaterialPageRoute(builder: (context) {
        Map<String, Tutor> arg = settings.arguments as Map<String, Tutor>;
        return FeedbackPage(tutor: arg["tutor"] as Tutor);
      });

    default:
      return MaterialPageRoute(builder: (context) => const LoginPage());
  }
}
