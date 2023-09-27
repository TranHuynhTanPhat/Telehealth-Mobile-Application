import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/change_password/components/export.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 10,
          title: Text(
            translate(context, 'change_password'),
          ),
          leadingWidth: dimensWidth() * 10,
          leading: Center(
            child: InkWell(
              splashColor: transparent,
              highlightColor: transparent,
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
                Future.delayed(const Duration(milliseconds: 200),
                    () => Navigator.pop(context));
              },
              child: Container(
                  padding: EdgeInsets.all(dimensWidth()),
                  child: Text(
                    translate(context, 'cancel'),
                    style: Theme.of(context).textTheme.titleSmall,
                  )),
            ),
          ),
        ),
        body: SafeArea(
          bottom: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: const [ChangePasswordForm()],
          ),
        ),
      ),
    );
  }
}
