import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({
    super.key,
    required TextEditingController textEdittingController,
  }) : _textEdittingController = textEdittingController;

  final TextEditingController _textEdittingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
          child: Text(
            translate(context, 'your_question'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: dimensHeight(), bottom: dimensHeight() * 1.5),
          child: TextFieldWidget(
            controller: _textEdittingController,
            validate: (value) => null,
            maxLine: 3,
            fillColor: colorF2F5FF,
            filled: true,
            focusedBorderColor: colorF2F5FF,
            enabledBorderColor: colorF2F5FF,
            hint: translate(context, 'whats_the_problem_with_you'),
          ),
        ),
        Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: colorF2F5FF,
            borderRadius: BorderRadius.circular(180),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    KeyboardUtil.hideKeyboard(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.photoFilm,
                        size: dimensIcon() * .5,
                        color: color1F1F1F,
                      ),
                      SizedBox(
                        width: dimensWidth(),
                      ),
                      Text(
                        translate(context, 'attach'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    KeyboardUtil.hideKeyboard(context);
                  },
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(0),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                          vertical: dimensHeight(),
                          horizontal: dimensWidth() * 2.5),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(primary),
                  ),
                  child: Text(
                    translate(context, 'post'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: white),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
