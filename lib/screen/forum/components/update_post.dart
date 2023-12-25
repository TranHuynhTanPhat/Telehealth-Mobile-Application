import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubit_forum/forum_cubit.dart';
import 'package:healthline/data/api/models/responses/post_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class UpdatePost extends StatefulWidget {
  const UpdatePost({
    super.key,
    required this.post,
  });
  final PostResponse post;

  @override
  State<UpdatePost> createState() => _UpdatePostState();
}

class _UpdatePostState extends State<UpdatePost> {
  late TextEditingController contentController;

  @override
  void initState() {
    contentController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (contentController.text.trim().isEmpty) {
      contentController.text = widget.post.description ?? '';
    }
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
                  controller: contentController,
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
                        onTap: () async {
                          KeyboardUtil.hideKeyboard(context);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                '${widget.post.photo?.length} ${translate(context, 'files')} ${translate(context, 'attach').toLowerCase()}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.labelLarge,
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
                          if (contentController.text.trim().isNotEmpty) {
                            context.read<ForumCubit>().editPost(
                                idPost: widget.post.id,
                                files: [],
                                content: contentController.text.trim());
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
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered) ||
                                  states.contains(MaterialState.pressed)) {
                                return white.withOpacity(.3); //<-- SEE HERE
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        child: Text(
                          translate(context, 'update'),
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
