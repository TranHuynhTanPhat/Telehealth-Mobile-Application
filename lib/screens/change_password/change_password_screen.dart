import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/change_password/components/export.dart';
import 'package:healthline/utils/translate.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          translate(context, 'change_password'),
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
    );
  }
}
