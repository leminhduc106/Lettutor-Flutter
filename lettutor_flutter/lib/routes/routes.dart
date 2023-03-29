import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/models/schedule_model/booking_info_model.dart';
import 'package:lettutor_flutter/navigation.dart';
import 'package:lettutor_flutter/views/authenticate/forgot_password_page.dart';
import 'package:lettutor_flutter/views/authenticate/login_page.dart';
import 'package:lettutor_flutter/views/authenticate/register_page.dart';
import 'package:lettutor_flutter/views/course/course.dart';
import 'package:lettutor_flutter/views/course/topic_course/topic_course.dart';
import 'package:lettutor_flutter/views/feedback_page.dart/feedback_page.dart';
import 'package:lettutor_flutter/views/profile_page/profile_page.dart';
import 'package:lettutor_flutter/views/setting_page/advanced_setting/advanced_setting.dart';
import 'package:lettutor_flutter/views/setting_page/change_password/change_password.dart';
import 'package:lettutor_flutter/views/setting_page/session_history/record_video.dart';
import 'package:lettutor_flutter/views/setting_page/session_history/session_history.dart';
import 'package:lettutor_flutter/views/tutor_profile/tutor_profile.dart';

const String loginPage = 'login';
const String registerPage = 'register';
const String forgotPasswordPage = 'forgot_password';
const String homePage = 'home';
const String profilePage = 'profile';
const String tutorProfilePage = 'tutorProfile';
const String coursePage = 'course';
const String courseTopicPDF = 'courseTopicPDF';
const String sessionHistoryPage = 'sessionHistory';
const String advancedSettingPage = 'advancedSetting';
const String feedbackPage = 'feedback';
const String changePasswordPage = 'changePassword';
const String recordVideoPage = 'recordVideo';
const String favoriteTutorPage = 'favoriteTutor';

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
    case sessionHistoryPage:
      return MaterialPageRoute(
          builder: (context) => const SessionHistoryPage());
    case advancedSettingPage:
      return MaterialPageRoute(builder: (context) => AdvancedSettingPage());
    case changePasswordPage:
      return MaterialPageRoute(
          builder: (context) => const ChangePasswordPage());
    case favoriteTutorPage:
      return MaterialPageRoute(
          builder: (context) => const ChangePasswordPage());

    case recordVideoPage:
      return MaterialPageRoute(builder: (context) {
        Map<String, String> arg = settings.arguments as Map<String, String>;
        return RecordVideo(url: arg['url'] as String);
      });

    case courseTopicPDF:
      return MaterialPageRoute(builder: (context) {
        Map<String, String> arg = settings.arguments as Map<String, String>;
        return CourseTopicPDFViewer(
            url: arg['url'] as String, title: arg['title'] as String);
      });

    case tutorProfilePage:
      return MaterialPageRoute(builder: (context) {
        Map<String, String> arg = settings.arguments as Map<String, String>;
        return TutorProfile(tutorID: arg['tutorID'] as String);
      });

    case coursePage:
      return MaterialPageRoute(builder: (context) {
        Map<String, String> arg = settings.arguments as Map<String, String>;
        return CoursePage(courseId: arg["courseId"] as String);
      });

    case feedbackPage:
      return MaterialPageRoute(builder: (context) {
        Map<String, BookingInfo> arg =
            settings.arguments as Map<String, BookingInfo>;
        return FeedbackPage(bookingInfo: arg["bookingInfo"] as BookingInfo);
      });

    default:
      return MaterialPageRoute(builder: (context) => const LoginPage());
  }
}
