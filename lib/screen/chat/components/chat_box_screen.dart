import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class ChatBoxScreen extends StatefulWidget {
  const ChatBoxScreen({super.key});

  @override
  State<ChatBoxScreen> createState() => _ChatBoxScreenState();
}

class _ChatBoxScreenState extends State<ChatBoxScreen> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: false,
        backgroundColor: primary.withOpacity(.1),
        // bottomSheet: Container(color: color9D4B6C, height: dimensHeight()*10,),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(dimensWidth() * 2, dimensHeight() * 3,
              dimensWidth() * 2, dimensHeight() * 5),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth(), vertical: dimensWidth()),
            decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
                borderRadius: BorderRadius.circular(dimensWidth() * 2)),
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
                onTap: () {},
                child: FaIcon(
                  FontAwesomeIcons.plane,
                  color: primary,
                  size: dimensIcon() / 2,
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Name"),
          backgroundColor: primary.withOpacity(.5),
          centerTitle: false,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: dimensWidth() * 3,
          ),
          reverse: true,
          shrinkWrap: false,
          children: [
            Container(child: Text("Message")),
            SizedBox(
              height: dimensHeight() * 3,
            )
          ],
        ),
      ),
    );
  }
}
