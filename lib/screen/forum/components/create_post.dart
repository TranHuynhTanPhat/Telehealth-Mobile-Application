import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_forum/forum_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/file_picker.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({
    super.key,
  });

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  late List<File?> _files;
  late TextEditingController _textEdittingController;

  @override
  void initState() {
    _files = [];
    _textEdittingController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForumCubit, ForumState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state.blocState == BlocState.Pending,
          child: Column(
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
                  onChanged: (p0) => setState(() {}),
                  focusedBorderColor: colorF2F5FF,
                  enabledBorderColor: colorF2F5FF,
                  hint: translate(context, 'whats_the_problem_with_you'),
                ),
              ),
              if (_textEdittingController.text.trim().isNotEmpty)
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
                          onTap: () async {
                            KeyboardUtil.hideKeyboard(context);
                            _files = await FilePickerCustom().getImages();
                            setState(() {});
                          },
                          child: _files.isEmpty
                              ? Row(
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${_files.length} ${translate(context, 'files')} ${translate(context, 'attach').toLowerCase()}',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            KeyboardUtil.hideKeyboard(context);
                            if (_textEdittingController.text
                                .trim()
                                .isNotEmpty) {
                              context.read<ForumCubit>().editPost(
                                  files: _files,
                                  content: _textEdittingController.text.trim());
                            }
                          },
                          style: ButtonStyle(
                            elevation: const MaterialStatePropertyAll(0),
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  vertical: dimensHeight(),
                                  horizontal: dimensWidth() * 2.5),
                            ),
                            backgroundColor:
                                const MaterialStatePropertyAll(primary),
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
          ),
        );
      },
    );
  }
}
