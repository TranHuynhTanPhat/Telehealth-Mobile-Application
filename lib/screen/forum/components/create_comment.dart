import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_forum/forum_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class CreateComment extends StatefulWidget {
  const CreateComment({super.key, required this.focus, required this.idPost});
  final FocusNode focus;
  final String? idPost;

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
        // CircleAvatar(
        //   backgroundColor: primary,
        //   backgroundImage: image,
        //   radius: dimensHeight() * 2.5,
        //   onBackgroundImageError: (exception, stackTrace) {
        //     logPrint(exception);
        //     setState(() {
        //       image = AssetImage(DImages.placeholder);
        //     });
        //   },
        // ),
        // SizedBox(
        //   width: dimensWidth(),
        // ),
        Expanded(
          child: TextFieldWidget(
            focusNode: widget.focus,
            validate: (p0) => null,
            hint: translate(context, 'write_a_comment'),
            fillColor: colorF2F5FF,
            filled: true,
            focusedBorderColor: colorF2F5FF,
            enabledBorderColor: colorF2F5FF,
            controller: _commentController,
            onChanged: (p0) => setState(() {}),
            onTap: () {
              try {
                context
                    .read<ForumCubit>()
                    .fetchComment(idPost: widget.idPost!);
              } catch (e) {
                logPrint(e);
                EasyLoading.showToast(translate(context, 'cant_load_data'));
              }
            },
            suffix: InkWell(
              onTap: () {
                if (_commentController.text.trim().isNotEmpty &&
                    widget.idPost != null) {
                  context.read<ForumCubit>().createComment(
                      idPost: widget.idPost!,
                      content: _commentController.text.trim());
                  _commentController.text = '';
                }
              },
              child: _commentController.text.trim().isNotEmpty
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
