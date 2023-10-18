// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// import 'package:healthline/data/api/models/responses/health_stat_response.dart';
// import 'package:healthline/res/style.dart';
// import 'package:healthline/utils/translate.dart';

// class HeartRateCard extends StatelessWidget {
//   const HeartRateCard({
//     super.key,
//     required this.healthStatResponse,
//   });
//   final HealthStatResponse? healthStatResponse;

//   @override
//   Widget build(BuildContext context) {
//     num value = -1;
//     if (healthStatResponse == null) {
//       value = -1;
//     } else {
//       value = healthStatResponse!.value ?? -1;
//     }
//     return Container(
//       margin: EdgeInsets.only(bottom: dimensWidth() * 2.5),
//       padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
//       decoration: BoxDecoration(
//           color: color1C6AA3.withOpacity(.2),
//           borderRadius: BorderRadius.circular(dimensWidth() * 3)),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 translate(context, 'heart_rate'),
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               SizedBox(
//                 height: dimensHeight() * 3,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     translate(context, value == -1 ? '0' : value.toString()),
//                     style: Theme.of(context)
//                         .textTheme
//                         .displayLarge
//                         ?.copyWith(fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     translate(context, 'bpm'),
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           LottieBuilder.asset(
//             'assets/lotties/heart_rate.json',
//             width: dimensWidth() * 25,
//           )
//         ],
//       ),
//     );
//   }
// }
