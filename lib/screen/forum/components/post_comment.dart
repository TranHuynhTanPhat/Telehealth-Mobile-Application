import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubit_forum/forum_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/forum/components/comment_card.dart';
import 'package:healthline/screen/forum/components/create_comment.dart';

class PostComment extends StatelessWidget {
  PostComment({super.key, required this.idPost});
  final String? idPost;

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: dimensWidth()*2),
      decoration: BoxDecoration(color: secondary.withOpacity(.02)),
      child: Column(
        children: [
          BlocBuilder<ForumCubit, ForumState>(
            builder: (context, state) {
              if (state is FetchCommentState &&
                  state.comments.isNotEmpty &&
                  state.idPost == idPost) {
                return Column(
                  children: state.comments
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.only(top: dimensHeight(), ),
                          child: CommentCard(
                            onTap: () {},
                            comment: e,
                          ),
                        ),
                      )
                      .toList(),
      
                  // CommentCard(
                  //   onTap: () {
                  //     // _focusNode.requestFocus();
                  //   },
                  // ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
              child: CreateComment(
                focus: _focusNode,
              )),
        ],
      ),
    );
  }
}
