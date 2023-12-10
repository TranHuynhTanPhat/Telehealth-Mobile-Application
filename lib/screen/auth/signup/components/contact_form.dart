import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';

class ContactForm extends StatefulWidget {
  const ContactForm(
      {super.key,
      required this.backPressed,
      required this.continuePressed,
      required this.formKey, required this.controllerEmail, required this.controllerPhone});

  final Function() backPressed;
  final Function() continuePressed;
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerEmail;
  final TextEditingController controllerPhone;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 3),
            child: TextFieldWidget(
              label: translate(context, 'email'),
              hint: translate(context, 'ex_email'),
              controller: widget.controllerEmail,
              validate: (value) => Validate().validateEmail(context, value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 2),
            child: TextFieldWidget(
              validate: (value) {
                return Validate().validatePhone(context, widget.controllerPhone.text);
              },
              prefix: Padding(
                padding: EdgeInsets.only(right: dimensWidth() * .5),
                child: Text(
                  '+84',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              controller: widget.controllerPhone,
              label: translate(context, 'phone'),
              textInputType: TextInputType.phone,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: dimensHeight() * 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: widget.backPressed,
                  child: Text(
                    translate(context, 'back'),
                  ),
                ),
                const Spacer(),
                ElevatedButtonWidget(
                  text: translate(context, 'continue'),
                  onPressed: () {
                    if (widget.formKey.currentState!.validate()) {
                      widget.formKey.currentState!.save();
                      widget.continuePressed();
                    }
                  },
                ),
              ],
            ),
          ),
          // ElevatedButton(
          //   style: const ButtonStyle(
          //       shadowColor: MaterialStatePropertyAll(white)),
          //   onPressed: _currentStep < 2
          //       ? () => setState(() {
          //             _currentStep += 1;
          //           })
          //       : null,
          //   child: Text(
          //     translate(context, 'continue'),
          //     style: Theme.of(context)
          //         .textTheme
          //         .labelMedium
          //         ?.copyWith(color: secondary),
          //   ),
          // ),
        ],
      ),
    );
  }
}
