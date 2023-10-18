import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

Widget cancelButton(BuildContext context) => Center(
      child: InkWell(
        splashColor: transparent,
        highlightColor: transparent,
        onTap: () {
          KeyboardUtil.hideKeyboard(context);
          Future.delayed(
              const Duration(milliseconds: 200), () => Navigator.pop(context));
        },
        child: Container(
            padding: EdgeInsets.all(dimensWidth()),
            child: Text(
              translate(context, 'cancel'),
              style: Theme.of(context).textTheme.titleSmall,
            )),
      ),
    );
