import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubit_forum/forum_cubit.dart';
import 'package:healthline/data/api/models/responses/post_response.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screen/forum/components/update_post.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key, this.args});
  final String? args;

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  late PostResponse post;
  @override
  Widget build(BuildContext context) {
    try {
      post = PostResponse.fromJson(widget.args!);
    } catch (e) {
      EasyLoading.showToast(translate(context, 'cant_load_data'));
      Navigator.pop(context);
      return const SizedBox();
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          translate(context, 'edit_content'),
        ),
        centerTitle: true,
      ),
      body: BlocListener<ForumCubit, ForumState>(
        listener: (context, state) {
          if (state is EditPostState) {
            if (state.blocState == BlocState.Pending) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state.blocState == BlocState.Successed) {
              Navigator.pop(context, true);
            }
          }
        },
        child: GestureDetector(
          onTap: () {
            KeyboardUtil.hideKeyboard(context);
          },
          child: Container(
            color: white,
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3, vertical: dimensHeight()),
            child: UpdatePost(
              post: post,
            ),
          ),
        ),
      ),
    );
  }
}
