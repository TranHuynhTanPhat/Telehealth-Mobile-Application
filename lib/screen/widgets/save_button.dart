import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

Widget saveButton(BuildContext context) => Container(
      padding: EdgeInsets.only(top: dimensWidth(), bottom: dimensWidth()),
      child: Text(
        translate(context, 'save'),
        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: primary),
      ),
    );
// InkWell(
//               onTap: null,
//               splashColor: transparent,
//               highlightColor: transparent,
//               child: Container(
//                 padding: EdgeInsets.only(top:dimensWidth(), bottom: dimensWidth()),
//                 child: Text(
//                   translate(context, 'save'),
//                   style: Theme.of(context).textTheme.titleSmall!.copyWith(color: primary),
//                 ),
//               ),
//             );