import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/forum/components/comment_card.dart';
import 'package:healthline/screen/forum/components/create_comment.dart';

class PostComment extends StatefulWidget {
  const PostComment({super.key});

  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: dimensHeight() * 2),
          child: CommentCard(
            onTap: () {
              _focusNode.requestFocus();
            },
            child: CommentCard(
              onTap: () {
                _focusNode.requestFocus();
              },
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: dimensHeight() * 2),
            child: CreateComment(
              focus: _focusNode,
            )),
      ],
    );
  }
}
