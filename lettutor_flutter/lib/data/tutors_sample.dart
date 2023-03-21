import 'package:lettutor_flutter/data/user_sample.dart';
import 'package:lettutor_flutter/models/tutor/feedback.dart';
import 'package:lettutor_flutter/models/tutor/schedule.dart';
import 'package:lettutor_flutter/models/tutor/tutor.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

List<Schedule> sampleSchedule() {
  return [
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 10, 7, 0),
        end: DateTime(2023, 12, 10, 7, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 10, 8),
        end: DateTime(2023, 12, 10, 8, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 10, 9),
        end: DateTime(2023, 12, 10, 9, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 10, 10),
        end: DateTime(2023, 12, 10, 10, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 10, 11),
        end: DateTime(2023, 12, 10, 11, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 10, 15),
        end: DateTime(2023, 12, 10, 15, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 10, 16),
        end: DateTime(2023, 12, 10, 16, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 10, 17),
        end: DateTime(2023, 12, 10, 17, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 11, 7),
        end: DateTime(2023, 12, 11, 7, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 11, 8),
        end: DateTime(2023, 12, 11, 8, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 11, 9),
        end: DateTime(2023, 12, 11, 9, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 11, 10),
        end: DateTime(2023, 12, 11, 10, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 11, 11),
        end: DateTime(2023, 12, 11, 11, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 11, 15),
        end: DateTime(2023, 12, 11, 15, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 11, 16),
        end: DateTime(2023, 12, 11, 16, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 11, 17),
        end: DateTime(2023, 12, 11, 17, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 12, 7, 0),
        end: DateTime(2023, 12, 12, 7, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 12, 8),
        end: DateTime(2023, 12, 12, 8, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 12, 9),
        end: DateTime(2023, 12, 12, 9, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 13, 7),
        end: DateTime(2023, 12, 13, 7, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 13, 8),
        end: DateTime(2023, 12, 13, 8, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 13, 9),
        end: DateTime(2023, 12, 13, 9, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 14, 9),
        end: DateTime(2023, 12, 14, 9, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 15, 9),
        end: DateTime(2023, 12, 15, 9, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 16, 9),
        end: DateTime(2023, 12, 16, 9, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 17, 9),
        end: DateTime(2023, 12, 17, 9, 30)),
    Schedule(
        id: uuid.v4(),
        start: DateTime(2023, 12, 18, 9),
        end: DateTime(2023, 12, 18, 9, 30)),
  ];
}

List<FeedbackRate> sampleFeedback() {
  return [
    FeedbackRate(
      id: uuid.v4(),
      userId: UsersSample.users[1].id,
      content: "Greate!",
      createdAt: DateTime(2023, 10, 22),
      rating: 5,
    ),
    FeedbackRate(
      id: uuid.v4(),
      userId: UsersSample.users[2].id,
      content: "Thank you!",
      createdAt: DateTime(2023, 10, 22),
      rating: 5,
    ),
    FeedbackRate(
      id: uuid.v4(),
      userId: UsersSample.users[3].id,
      content: "Very good!",
      createdAt: DateTime(2023, 10, 22),
      rating: 5,
    ),
  ];
}

class TutorsSample {
  static List<Tutor> tutors = [
    Tutor(
      uuid.v4(),
      "Nhi Lam",
      "Viet Nam",
      5,
      "Hi, I am teacher Nhi. I have been teaching English for 3 years now. I used to study abroad in Sydney for 7 years. During my time as an overseas student, I had spoken with people from diverse cultural backgrounds; therefore, I have strong listening and speaking skills. I love teaching English and I will devote to helping you improve your English skills if you book my class. I am also patient and understanding because I know for many people, English is a tough language to master. In my class, I will help you correct your pronunciation and deliver the lessons in a way that is easy for you to understand. If you book my class, you will have many chances to practice your speaking skills and also improve your pronunciation and grammatical knowledge. Besides that, if you need me to, I will share my personal tips to study English more effectively with you and show you the importance of having fun and practice while learning English.",
      "assets/images/sample/tutor/sample_1.jpg",
      <String>["English", "French", "Spanish", "Japanese", "Chinese"],
      <String, String>{
        "Interests":
            "Teaching English, listening to music, shopping, eating :)",
        "Teaching experience": "3 years",
      },
      <String>[
        "IELTS",
        "English for Business",
        "STARTERS",
        "MOVERS",
        "FLYERS",
        'TOEIC',
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Jill Leano",
      "Philippines (the)",
      3,
      "Hi, My name is Jill I am an experienced English Teacher from Philippine. I would like share my enthusiasm with the learners in this platform. I've been working with diverse learners of all levels for many years. I am greatly passionate about about profession. I love teaching because I can help others improve their skills and it gives me joy and excitement meeting different learners around the world. In my class I worked with wonderful enthusiasm and positivity, and I'm happy t focus on my learner's goal.",
      "assets/images/sample/tutor/sample_1.jpg",
      <String>["English", "French", "Spanish"],
      <String, String>{
        "Interests":
            "Listening to music , Watching English movies, Gardening, Baking, Cooking ,craft making , Adult coloring, Go hiking with my family ,swimming and fishing.",
        "Teaching experience":
            "I am a license teacher I worked as an ESL Teacher for a year now, I am tutor for elementary to Senior High School student. I also teach Business English for some Professional Students .",
      },
      <String>[
        "English for kids",
        "Conversational",
        "IELTS",
        "English for Business",
        "TOEFL",
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Maria Silkyza Galvez",
      "Philippines (the)",
      4,
      "Hello thank you for visiting my profile I am Silkyza, 26 years old from Philippines. I am a Licensed Professional Teacher with TEFL certificate. I am teaching English, Tagalog and Cebuano. I am can teach students in different levels from A0- B1. I can also handle students in all ages from kids to adults. I already have experience in online teaching. if you have difficulties in your English speaking, reading and writing skills from now on you don't have to worry about it because I am here to help you to improve those skills",
      "assets/images/sample/tutor/sample_2.jpg",
      <String>["English", "French", "Spanish", "Tagalog"],
      <String, String>{
        "Interests":
            "I am music enthusiast, my hobbies are playing guitar, singing and dancing.",
        "Teaching experience":
            "I have experience in online teaching, I teach student's in different levels from kids to adult.",
      },
      <String>[
        "English for kids",
        "Conversational",
        "IELTS",
        "English for Business",
        "MOVERS",
        "STARTERS",
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "April Corpuz",
      "Philippines (the)",
      5,
      "Hello there! I am an Industrial Engineer in the profession but chose to do online teaching because I love to meet different learners. I am an outgoing person and I have this passion for dealing with different people and seeing them progress with my help as their teacher. In fact, making friends is one of my best skills. I am very good at adapting to new environments and new situations. I am very friendly and can easily get along well with everyone. I have obtained a 120-Hour TEFL Certificate. I get a variety of teaching techniques. I know that there are fast and not so fast learners. So don't worry, I will be with you every step of the way going at your own pace. Let's practice what you already know and add something new each day. With my skills and experiences, I can assure you that I can provide adequate English learning effectively and efficiently. Together, let's make English learning fun.",
      "assets/images/sample/tutor/sample_3.jpg",
      <String>["English", "French", "Spanish", "Tagalog"],
      <String, String>{
        "Interests": "Cooking, Mingling with kids, Travelling",
        "Teaching experience":
            "I have been teaching English online since 2020 catering to Japanese, Chinese, Russian, and Ukrainian students.",
      },
      <String>[
        "English for kids",
        "Conversational",
        "IELTS",
        "English for Business",
        "MOVERS",
        "STARTERS",
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Hannah Nguyen",
      "Viet Nam",
      3,
      "I have been teaching English as a second language for kids, teenagers and adults for 5 years. I can help you gain a stronger foundation in English before furthering your studies. I'm patient, will speak slowly and clearly so don't hesitate to ask for good understanding.",
      "assets/images/sample/tutor/sample_4.jpg",
      <String>["English"],
      <String, String>{
        "Interests": "Finance, gardening, travelling",
        "Teaching experience": "5 years of English teaching experience",
      },
      <String>[
        "English for kids",
        'KET',
        "PET",
        "Conversational",
        "IELTS",
        "English for Business",
        "MOVERS",
        "STARTERS"
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Kathy Huỳnh",
      "Viet Nam",
      4,
      "Hi! My name is Kathy, I have been using English as a second language since I was young, I also have great experience in teaching and communicating with students. As a friendly and energetic person, I am always ready to help and accompany with you in your English learning journey. I can help you gain confidence in using English and enhance your speaking skill. I know that learning a new language can be full of obstacles; however, do not hesitate and come to my class, I will bring you a friendly classroom with slow speak, a good accent that offers you opportunities to speak more, practice more, learn more about English.",
      "assets/images/sample/tutor/sample_5.jpg",
      <String>["English", "Vietnamese"],
      <String, String>{
        "Interests":
            "I love spending my free time on watching movies, especially American comedy and horror ones. I can develop my English skill from those exciting films. Other than that, I also enjoy talking with people from different cultures, getting to know more about them, and widening my perspective. Listening to music and traveling are also some of my top favorite things to do when I have spare time.",
        "Teaching experience":
            "I have been teaching primary students for almost two years, besides, I have long been talking and interacting with native teachers and friends at school so I possess an American accent which makes it easy for students to understand.",
      },
      <String>[
        "English for kids",
        'KET',
        "PET",
        "Conversational",
        "IELTS",
        "English for Business",
        "MOVERS",
        "STARTERS"
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Joan Gacer",
      "Philippines (the)",
      3,
      "I was a customer service sales executive for 3 years before I become an ESL teacher I am trained to deliver excellent service to my clients so I can help you with business English dealing with customers or in sales-related jobs and a lot more, I also love to teach beginner, intermediate and advance I speak slowly and clearly so that the student can easily follow my instructions and pronunciation. In my class, I want environment-friendly fun and engaging I have many activities designed to help your enthusiasm in learning the language. I'm so excited to meet you in one of my classes let us have fun while learning English. See you there.",
      "assets/images/sample/tutor/sample_6.jfif",
      <String>["English", "Vietnamese"],
      <String, String>{
        "Interests":
            "I'm an outgoing patient and fun I love spending time with cute nephews and nieces I teach them to become good English speakers. In my spare time, I love to watch movies, read travel and swim I also love meeting new people learning their culture, and share our experiences together I believe language should not be the barrier to share your passion and care for other people that's why I teach English it is my passion to educate and help.",
        "Teaching experience":
            "I have over 5 years of experience teaching and using English in my job. I have an American accent which the student can easily understand.",
      },
      <String>[
        "English for kids",
        'KET',
        "PET",
        "Conversational",
        "IELTS",
        "English for Business",
        "MOVERS",
        "STARTERS"
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Chrizaira Nodado Senadre",
      "Philippines (the)",
      5,
      "Hi! I am teacher Zaira and I am majoring in English so if you want to know more about grammar, and wants to be fluent in English, I can help you with that. I will help you build your confidence in English communication. Are you preparing for an upcoming exam? I can help you with that! Let's get a score with flying colors!",
      "assets/images/sample/tutor/sample_7.jpg",
      <String>["English", "Tagalog"],
      <String, String>{
        "Interests":
            "Hi! I am teacher Zaira and I am majoring in English so if you want to know more about grammar, and wants to be fluent in English, I can help you with that. I will help you build your confidence in English communication. Are you preparing for an upcoming exam? I can help you with that! Let's get a score with flying colors!",
        "Teaching experience":
            "I have 2 years of experience in teaching English. I have taught different kinds of nationalities from levels beginner to advanced, of all ages.",
      },
      <String>[
        "English for kids",
        'KET',
        "PET",
        "Conversational",
        "IELTS",
        "English for Business",
        "MOVERS",
        "STARTERS"
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Darlyn Grace Sausa",
      "Philippines (the)",
      4,
      "A teacher for almost a decade with lengthy teaching exposure with Vietnamese students, adult professionals, non -professionals, and executives. Teaching is a skill delivered with own style and creativity focused on YOU. YES, our lessons will be based on what really matters to you, what you want to learn in a short possible time. Take the opportunity to practice speaking English on daily basis with me with an assurance that speaking English will never be that engaging as you will experience now with us here in LetTutor.",
      "assets/images/sample/tutor/sample_8.jpg",
      <String>["Philippine Vernacular and English", "a litte of Arabic"],
      <String, String>{
        "Interests":
            "Teaching and inspire people to be able to overcome challenges, Reading, Movie watching and go walking in nature parks or go climbing on a hill",
        "Teaching experience":
            "Sales Executive and Financial Advisor ESL online teacher for kids and Adult professionals including but not limited to Business English and conversational English, and MS Office Application Tutor",
      },
      <String>[
        'KET',
        "PET",
        "IELTS",
        "English for Business",
        "MOVERS",
        "STARTERS"
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Giang Nguyen",
      "Viet Nam",
      5,
      "I am a teacher of English and a lecturer at a college in HCMC. I can help you to communicate better in English and be more confident to use English. For me, to learn is to you, so you will be given many chances to practice English with you.",
      "assets/images/sample/tutor/sample_9.jpg",
      <String>["English", "Vietnamese", "Korea"],
      <String, String>{
        "Interests":
            "Watching English films and talking to friends from different countries",
        "Teaching experience":
            "I have been teaching as an English teacher for over three years. I have been working for many English centers, including VUS and I am also a lecturer at HCM College of Economics. I have taught English at various levels, including English for Kids, English for Communication, TOEIC and IELTS.",
      },
      <String>[
        'KET',
        "PET",
        "IELTS",
        "English for Business",
        "MOVERS",
        "STARTERS"
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Angelicalabraa",
      "Philippines (the)",
      4,
      "While I've always longed to be an ESL teacher, the delight I had from assisting students' growth and development definitely encouraged my desire. I feel that my enthusiasm, good approach, and hands-on experience working with youngsters will make me a fantastic educator. I'm looking forward to a career that allows me to mold young minds and make a difference in the lives of the children in my community. Hope you will be one of them and See you soon.",
      "assets/images/sample/tutor/sample_10.jpg",
      <String>["English"],
      <String, String>{
        "Interests":
            "Reading books, eating, playing badminton and playing with kids",
        "Teaching experience":
            "• ESL Teacher (September 12, 2016 -December 2017)) SMEAG Sparta Campus, Talamban, Cebu, Philippines +63 (32) 345 6430 www.smenglish.com • ESL Teacher/Cambridge English (January 2018 – February 2020)) SMEAG Sparta Campus, Mabolo, Cebu, Philippines - Bookmaker for YLE students & A2-B2 • ONLINE TEACHING Home-based (March 2020 – Present) Private students",
      },
      <String>[
        'KET',
        "PET",
        "IELTS",
        "English for Business",
        "MOVERS",
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Lora Mae Moreño",
      "Philippines (the)",
      5,
      "I've been teaching English online to students of different languages and cultures for a year now, Chinese, Vietnamese, and Japanese. This makes me more flexible and patient in dealing with my students of different English levels. I can help you with grammar and pronunciation.",
      "assets/images/sample/tutor/sample_11.jpg",
      <String>["English"],
      <String, String>{
        "Interests":
            "I like playing guitar, singing and writing songs. I like making crafts like paper flowers and letter cutting. I'm like mountains over beaches and I love dogs so much.",
        "Teaching experience":
            "I've been teaching English online for a year now. I taught Chinese students both kids and adults in my first ESL company and now I'm teaching kids and adults Japanese and Vietnamese.",
      },
      <String>['KET', "PET", "Conversational", "IELTS", "MOVERS", "STARTERS"],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Gail Carlos",
      "Philippines (the)",
      5,
      "Hi! I am Teacher Gail. I have been enjoying teaching English for 2 years now. I am an Artist, a Singer, and a Teacher at heart so I always love to share my knowledge and skills to everyone, may be it to kids, teenagers, or adults. Let us learn together and grow together.",
      "assets/images/sample/tutor/sample_12.jpg",
      <String>["English"],
      <String, String>{
        "Interests":
            "I love talking and being with people! I also love traveling, watching movies, playing and listening to music, and so much more. Teaching also is of my passion that's why I'm here today.",
        "Teaching experience":
            "I have been teaching English for almost two years now. But even before that, I already loved teaching kids and playing with children.",
      },
      <String>[
        'KET',
        "PET",
        "IELTS",
        "English for Business",
        "MOVERS",
        "STARTERS"
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
    Tutor(
      uuid.v4(),
      "Basilla Efren Jr Saez",
      "Philippines (the)",
      5,
      "Hello! My name is Efren. I was born and raised in the Philippines where English is an official language. I am a licensed professional teacher and I've been teaching for thirty years now. I have taught in different schools in the Philippines and I had an opportunity to teach in China for nine years as an International Baccalaureate Diploma Programme (IB DP) Teacher in History and Economics and also for IB Middle Years Pogramme teaching Individuals and Societies - History, Economics, and Geography. I also became an ESL High School Teacher in the Philippines and also in China. I am a dynamic teacher thereby making my classes fun, creative, and interesting. I am providing my students learning with fun. I can teach their beginners vocabulary, grammar, pronunciation, as well as improving their speaking and listening communication skills. I love to engage myself with people of different nationalities and cultures because I want to know and be aware also of their cultures and at the same sharing my own Filipino culture with them. I love seeing my students become successful because I believe that their success is also my success. I would be very happy and honored to be a part of your learning the English language. I will always be your guide until you achieve your personal growth and personal goal, if you would permit me. Thank you very much.",
      "assets/images/sample/tutor/sample_13.jpg",
      <String>["English", "Mandarin", "Spanish", "Filipino"],
      <String, String>{
        "Interests":
            "watching/viewing war movies and documentary films on global issues, cooking, biking",
        "Teaching experience":
            "I had teaching experience in different schools, public and private) in the Philippines handling grade school/lower school kids as well as high school students, junior and senior. I can teach all subjects in grade school. For high school students, I taught Humanities, History, Economics, Geography, and ESL. I also had teaching experience in China, in the city of Xiamen, Province of Fujian for 9 years in an international school as an International Baccalaureate Middle Years and Diploma Program wherein I handled IB students with History and Economics courses. I also had experience teaching ESL for Middle School for two years.",
      },
      <String>[
        'KET',
        "PET",
        "IELTS",
        "English for Business",
        "MOVERS",
        "STARTERS"
      ],
      sampleSchedule(),
      sampleFeedback(),
    ),
  ];
}
