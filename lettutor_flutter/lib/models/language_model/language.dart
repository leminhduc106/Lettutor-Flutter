abstract class Language {
  late String name;
  // Login Page
  get email;
  get password;
  get signUpQuestion;
  get signUp;
  get signIn;
  get forgotPassword;
  get continueWith;
  get invalidEmail;
  get emptyField;
  get passwordTooShort;
  get forgotPasswordFail;
  get forgotPasswordSuccess;

  // Sign Up Page
  get confirmPassword;
  get loginQuestion;
  get errEnterAllFields;
  get errPasswordMismatch;

  // Reset Password Page
  get resetPassword;
  get enterEmail;
  get pleaseEnter;
  get pleaseEnterEmail;
  get confirmReset;
  get gobackLogin;

  // Home Page
  get home;
  get totalLessonTime;
  get enterRoom;
  get recommendTutor;
  get seeAll;
  get wellcome;
  get nextLesson;
  get bookAlesson;
  get bookingText;

  // Profile page
  get profile;
  get fullName;
  get birthday;
  get phone;
  get country;
  get level;
  get wantToLearn;
  get save;
  get errGetNewProfile;
  get errUploadAvatar;
  get successUploadAvatar;
  get errUpdateProfile;
  get successUpdateProfile;
  get errPhoneNumber;
  get errEnterName;
  get errBirthday;

  // Course page
  get course;
  get searchCourse;
  get lesson;
  get errNotAnyResult;
  // Course Detail
  get aboutCourse;
  get overview;
  get why;
  get what;
  get topic;
  get tutor;

  // Ebook tab
  get ebook;
  get searchEbook;

  // Upcoming Page
  get upcoming;
  get cancel;
  get goToMeeting;
  get dontHaveUpcoming;
  get removeUpcomingSuccess;
  get removeUpcomingFail;
  get cancelUpcomingWarning;
  get upcommingExplain;
  get bookedSchedule;

  // Tutor search page and Tutor detail page
  get tutors;
  get tutorDetail;
  get searchTutor;
  get booking;
  get languages;
  get interests;
  get specialties;
  get rateAndComment;
  get selectSchedule;
  get selectScheduleDetail;
  get bookingSuccess;
  get submitBtn;
  get reportSucessMsg;

  // Setting page
  get setting;
  get changePassword;
  get sessionHistory;
  get advancedSetting;
  get ourWebsite;
  get logout;
  get becomeTutor;

  // Change password page
  get currentPassword;
  get newPassword;
  get confirmNewPassword;
  get passwordAtLeast;
  get changePasswordSuccess;

  // Session history page
  get giveFeedback;
  get watchRecord;
  get mark;
  get tutorNotMark;
  get emptySession;
  get sessionHistoryExplain;

  // Feedback page
  get feedback;
  get hintFeedback;
  get errEnterFeedback;
  get errFeedbackLength;
  get successFeedback;

  //Chat Assistant page
  get chatAssistant;
  get holdToSpeak;
  get chatOrTalk;
  get errorEmptyMessage;
}
