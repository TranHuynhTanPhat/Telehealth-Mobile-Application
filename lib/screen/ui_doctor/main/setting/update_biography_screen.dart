import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class UpdateBiographyScreen extends StatefulWidget {
  const UpdateBiographyScreen({super.key});

  @override
  State<UpdateBiographyScreen> createState() => _UpdateBiographyScreenState();
}

class _UpdateBiographyScreenState extends State<UpdateBiographyScreen> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        extendBody: true,
        appBar: AppBar(
          title: Text(
            translate(context, 'update_biography'),
          ),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    label: translate(context, 'biography'),
                    
                    controller: _controller,
                    validate: (value) {
                      if (value!.split(' ').length < 100) {
                        return translate(
                            context, 'biography_must_be_at_least_100_words');
                      }
                      return null;
                    },
                    maxLine: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: dimensHeight() * 1.5),
                    width: double.infinity,
                    child: ElevatedButtonWidget(
                      text: translate(context, 'update'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
