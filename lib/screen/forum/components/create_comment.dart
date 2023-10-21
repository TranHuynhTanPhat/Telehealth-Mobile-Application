import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/translate.dart';

class CreateComment extends StatefulWidget {
  const CreateComment({super.key});

  @override
  State<CreateComment> createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {
  late TextEditingController _commentController;
  @override
  void initState() {
    _commentController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: primary,
          backgroundImage: AssetImage(DImages.placeholder),
          radius: dimensHeight() * 2.5,
        ),
        SizedBox(
          width: dimensWidth(),
        ),
        Expanded(
          child: TextFieldWidget(
            validate: (p0) => null,
            hint: translate(context, 'write_a_comment'),
            fillColor: colorF2F5FF,
            filled: true,
            focusedBorderColor: colorF2F5FF,
            enabledBorderColor: colorF2F5FF,
            controller: _commentController,
            onChanged: (p0) => setState(() {}),
            suffix: InkWell(
              onTap: null,
              child: _commentController.text.isNotEmpty
                  ? FaIcon(
                      FontAwesomeIcons.solidPaperPlane,
                      color: primary,
                      size: dimensIcon() * .7,
                    )
                  : FaIcon(
                      FontAwesomeIcons.paperPlane,
                      color: black26,
                      size: dimensIcon() * .7,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
