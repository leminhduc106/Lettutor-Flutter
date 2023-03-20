import 'package:lettutor_flutter/models/book/book.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class BooksSample {
  static List<Book> books = [
    Book(
      id: uuid.v4(),
      name: "What a world 1",
      description:
          "For teenagers who have an excellent vocabulary background and brilliant communication skills.",
      img: "assets/images/sample/book/sample_1.jpeg",
      level: 'Beginner',
    ),
    Book(
      id: uuid.v4(),
      name: "Let's go starter",
      description:
          "For kids who start learning English the first time or speak a little English only.",
      img: "assets/images/sample/book/sample_2.jpeg",
      level: 'Beginner',
    ),
    Book(
      id: uuid.v4(),
      name: "Let's go begin",
      description:
          "For kids who start learning English the first time or speak a little English only (reading skills are limited).",
      img: "assets/images/sample/book/sample_3.jpeg",
      level: 'Beginner',
    ),
    Book(
      id: uuid.v4(),
      name: "Family and friends starter",
      description:
          "For kids who want to learn English through pictures, pick up simple vocabulary and simple structures.",
      img: "assets/images/sample/book/sample_4.jpeg",
      level: 'Beginner',
    ),
    Book(
      id: uuid.v4(),
      name: "Everybody up starter",
      description:
          "For: kids who want to learn English through pictures, pick up simple vocabulary and simple structures.",
      img: "assets/images/sample/book/sample_5.png",
      level: 'Beginner',
    ),
    Book(
      id: uuid.v4(),
      name: "Cambridge story fun for starters",
      description:
          "For kids who can handle single words and simple sentences with assistance.",
      img: "assets/images/sample/book/sample_6.jpeg",
      level: 'Beginner',
    ),
    Book(
      id: uuid.v4(),
      name: "NEW HEADWAY ELEMENTARY",
      description:
          "For teenagers who want to form a grammatical background as well as reading and writing ones.",
      img: "assets/images/sample/book/sample_7.jpeg",
      level: 'Beginner',
    ),
    Book(
      id: uuid.v4(),
      name: "English world (Macmillan Young Learners) 1",
      description:
          "For kids who are able to pick up simple sounds, letters, words and learn new things by using pictures.",
      img: "assets/images/sample/book/sample_8.jpeg",
      level: 'Beginner',
    ),
  ];
}
