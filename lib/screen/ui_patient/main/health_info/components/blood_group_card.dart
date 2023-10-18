// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:healthline/data/api/models/responses/health_stat_response.dart';
// import 'package:healthline/res/style.dart';
// import 'package:healthline/utils/translate.dart';

// class BloodGroupCard extends StatelessWidget {
//   const BloodGroupCard({
//     super.key,
//     this.healthStatResponse,
//   });
//   final HealthStatResponse? healthStatResponse;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           vertical: dimensWidth() * 3, horizontal: dimensWidth() * 3),
//       decoration: BoxDecoration(
//         color: color9D4B6C.withOpacity(.2),
//         borderRadius: BorderRadius.circular(dimensWidth() * 2.5),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   translate(context, 'blood_group'),
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleSmall
//                       ?.copyWith(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(
//                 width: dimensWidth() * 2,
//               ),
//               FaIcon(
//                 FontAwesomeIcons.droplet,
//                 color: color9D4B6C,
//                 size: dimensIcon(),
//               ),
//             ],
//           ),
//           Text(
//             'O',
//             style: Theme.of(context)
//                 .textTheme
//                 .displaySmall
//                 ?.copyWith(fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }
