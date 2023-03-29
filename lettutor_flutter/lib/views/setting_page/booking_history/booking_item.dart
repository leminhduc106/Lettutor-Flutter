// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:lettutor_flutter/data/tutors_sample.dart';
// import 'package:lettutor_flutter/widgets/avatar_circle/avatar_circle.dart';

// class BookingItem extends StatelessWidget {
//   const BookingItem({
//     Key? key,
//     required this.idTutor,
//     required this.start,
//     required this.end,
//   }) : super(key: key);
//   final String idTutor;
//   final DateTime start;
//   final DateTime end;

//   @override
//   Widget build(BuildContext context) {
//     final tutor =
//         TutorsSample.tutors.firstWhere((tutor) => tutor.id == idTutor);
//     return Card(
//       elevation: 3,
//       child: Container(
//         padding:
//             const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//                 margin: const EdgeInsets.only(right: 15),
//                 child:
//                     AvatarCircle(width: 50, height: 50, source: tutor.image)),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 5),
//                   child: Text(
//                     tutor.fullName,
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//                 Row(
//                   children: <Widget>[
//                     Text(
//                       DateFormat.yMEd().format(start),
//                       style: const TextStyle(fontSize: 13),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(3),
//                       margin: const EdgeInsets.only(left: 5, right: 5),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.blue, width: 1),
//                           color: Colors.blue[50],
//                           borderRadius: BorderRadius.circular(4)),
//                       child: Text(
//                         DateFormat.Hm().format(start),
//                         style:
//                             const TextStyle(fontSize: 10, color: Colors.blue),
//                       ),
//                     ),
//                     const Text("-"),
//                     Container(
//                       padding: const EdgeInsets.all(3),
//                       margin: const EdgeInsets.only(left: 5, right: 5),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.orange, width: 1),
//                           color: Colors.orange[50],
//                           borderRadius: BorderRadius.circular(4)),
//                       child: Text(
//                         DateFormat.Hm().format(end),
//                         style:
//                             const TextStyle(fontSize: 10, color: Colors.orange),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
