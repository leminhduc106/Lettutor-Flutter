// import 'package:flutter/material.dart';
// import 'package:lettutor_flutter/models/course/course.dart';
// import 'package:lettutor_flutter/routes/routes.dart' as routes;

// class CourseCard extends StatelessWidget {
//   const CourseCard({Key? key, required this.course}) : super(key: key);

//   final Course course;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.pushNamed(
//           context,
//           routes.coursePage,
//           arguments: {"course": course},
//         );
//       },
//       child: Card(
//         elevation: 8,
//         child: SizedBox(
//           width: 200,
//           height: 500,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Image.asset(
//                 course.image,
//                 height: 130,
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                 child: Column(
//                   children: [
//                     Text(
//                       course.title,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                           fontSize: 17, fontWeight: FontWeight.bold),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(top: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             course.level,
//                             style: TextStyle(
//                                 fontSize: 12, color: Colors.grey[800]),
//                           ),
//                           Text(
//                             "${course.topics.length} Lessons",
//                             style: TextStyle(
//                                 fontSize: 12, color: Colors.grey[800]),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
