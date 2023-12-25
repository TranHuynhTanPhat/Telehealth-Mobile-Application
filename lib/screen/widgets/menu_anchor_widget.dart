import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/translate.dart';

class MenuAnchorWidget extends StatelessWidget {
  const MenuAnchorWidget(
      {super.key,
      this.enable = true,
      required this.textEditingController,
      required this.menuChildren, required this.label});
  final bool enable;
  final TextEditingController textEditingController;
  final List<Widget> menuChildren;
  final String label;
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(
        maximumSize: MaterialStatePropertyAll(Size.fromHeight(dimensHeight()*40)),
        elevation: const MaterialStatePropertyAll(10),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimensWidth() * 3),
          ),
        ),
        backgroundColor: const MaterialStatePropertyAll(white),
        surfaceTintColor: const MaterialStatePropertyAll(white),
        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
            horizontal: dimensWidth() * 2, vertical: dimensHeight())),
      ),
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return TextFieldWidget(
          enable: enable,
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          readOnly: true,
          label: translate(context, label),
          controller: textEditingController,
          validate: (value) {
            if (value!.isEmpty) {
              return translate(context, 'please_choose');
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          suffixIcon: const IconButton(
              onPressed: null, icon: FaIcon(FontAwesomeIcons.caretDown)),
        );
      },
      menuChildren: menuChildren,
    );
  }
}
