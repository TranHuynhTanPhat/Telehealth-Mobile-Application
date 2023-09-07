// import 'package:flutter/material.dart';
// import 'package:flutter_chat_sdk/res/theme/theme_service.dart';

// import '../../res/style.dart';

// class DataErrorWidget extends StatelessWidget {
//   final String? messageError;
//   final Function() onReloadData;

//   DataErrorWidget({
//     this.messageError,
//     required this.onReloadData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       color: getColor().bgThemeColorWhite,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Image.asset(
//             DImages.dataError,
//             width: 90,
//             height: 90,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Text(
//             messageError ?? txtTranslate('data.error'),
//             style: text16.textColorWhite,
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//             onPressed: () => onReloadData(),
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//             ),
//             child: Text(txtTranslate('reload')),
//           )
//         ],
//       ),
//     );
//   }
// }
