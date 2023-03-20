import 'package:lettutor_flutter/data/tutors_sample.dart';
import 'package:lettutor_flutter/models/course/course.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CoursesSample {
  static List<Course> courses = [
    Course(
      id: uuid.v4(),
      title: "Basic Conversation Topics",
      image: "assets/images/sample/course/sample_1.png",
      about: "Gain confidence speaking about familiar topics",
      level: "Beginner",
      overview: {
        "Why take this course":
            "It can be intimidating to speak with a foreigner, no matter how much grammar and vocabulary you've mastered. If you have basic knowledge of English but have not spent much time speaking, this course will help you ease into your first English conversations.",
        "What will you be able to do":
            "This course covers vocabulary at the CEFR A2 level. You will build confidence while learning to speak about a variety of common, everyday topics. In addition, you will build implicit grammar knowledge as your tutor models correct answers and corrects your mistakes.",
      },
      topics: [
        "Foods You Love",
        "Your Job",
        "Playing and Watching Sports",
        "The Best Pet",
        "Having Fun in Your Free Time",
        "Your Daily Routine",
        "Childhood Memories",
        "Your Family Members",
        "Your Hometown",
        "Shopping Habits"
      ],
      tutors: [TutorsSample.tutors[0]],
    ),
    Course(
      id: uuid.v4(),
      title: "Intermediate Conversation Topics",
      image: "assets/images/sample/course/sample_2.png",
      about: "Express your ideas and opinions",
      level: "Intermediate",
      overview: {
        "Why take this course":
            "Looking for some variety in your lesson topics? Immerse yourself in English discussion with this set of engaging topics.",
        "What will you be able to do":
            "This course covers vocabulary at the CEFR B1-B2 levels. You will work on improving fluency and comprehension by discussing a variety of topics. In addition, you will receive corrections from a native English speaker to help improve your grammatical accuracy.",
      },
      topics: [
        "Cooking",
        "Your Dream Job",
        "Sports Fitness",
        "Service Animals",
        "Social Activities",
        "Your Ideal Day",
        "Childhood Friendships",
        "The Importance of Family",
        "City Life",
        "Online Shopping"
      ],
      tutors: [TutorsSample.tutors[1]],
    ),
    Course(
      id: uuid.v4(),
      title: "Healthy Mind, Healthy Body",
      image: "assets/images/sample/course/sample_3.png",
      about: "Let's discuss the many aspects of living a long, happy life",
      level: "Intermediate",
      overview: {
        "Why take this course":
            "Looking for some variety in your lesson topics? Immerse yourself in English discussion with this set of engaging topics.",
        "What will you be able to do":
            "Discuss topics related to physical, mental, and emotional health. Learn about other cultures along the way in friendly conversations with tutors.",
      },
      topics: [
        "You Are What You Eat",
        "Health and Fitness",
        "Drink Up",
        "Getting Some Zizz",
        "Calm and RnB",
        "Look On The Bright Side",
      ],
      tutors: [TutorsSample.tutors[2]],
    ),
    Course(
      id: uuid.v4(),
      title: "Movies and Television",
      image: "assets/images/sample/course/sample_4.png",
      about:
          "Let's discuss our preferences and habits surrounding movies and television shows",
      level: "Beginner",
      overview: {
        "Why take this course":
            "Movies and television shows are common topics of conversation among friends and coworkers. In this course, you will practice discussing the movies and television shows you've seen and sharing your opinions about them.",
        "What will you be able to do":
            "You will learn vocabulary related to movies and television. In addition, you will practice the grammatical structures that help you tell a story, and share and explain your likes and dislikes.",
      },
      topics: [
        "Your Favorite Movie",
        "Your Favorite TV shows",
        "Film Production",
        "The World of Streaming",
        "Competition Shows",
        "Reality TV",
        "TV And Movie Characters",
        "Animated Movies And TV Series",
        "Movies Around the World",
        "The Future of Entertainment"
      ],
      tutors: [TutorsSample.tutors[3]],
    ),
  ];
}
