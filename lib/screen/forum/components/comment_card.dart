// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:healthline/data/api/models/responses/comment_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  const CommentCard(
      {super.key, required this.onTap, this.child, required this.comment});

  final Function() onTap;
  final Widget? child;
  final CommentResponse comment;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  String? timeBetween;
  var _image;
  @override
  void initState() {
    _image = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (widget.comment.createdAt != null) {
        DateTime from = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .parse(widget.comment.createdAt!);

        DateTime to = DateTime.now();
        timeBetween = daysBetween(context, from, to);
      } else {
        timeBetween = null;
      }
    } catch (e) {
      logPrint(e);
    }
    try {
      if (widget.comment.user?.avatar != null &&
          widget.comment.user?.avatar != 'default' &&
          widget.comment.user?.avatar != '') {
        _image = _image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget.comment.user?.avatar ?? '')
                  .toString(),
            );
      } else {
        _image = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      _image = AssetImage(DImages.placeholder);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: primary,
              backgroundImage: _image,
              radius: dimensHeight() * 2.5,
              onBackgroundImageError: (exception, stackTrace) {
                logPrint(exception);
                setState(() {
                  _image = AssetImage(DImages.placeholder);
                });
              },
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth() * 2,
                ),
                decoration: BoxDecoration(
                  // color: colorF2F5FF.withOpacity(.5),
                  borderRadius: BorderRadius.circular(dimensWidth() * 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: dimensHeight()),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.comment.user?.fullName ??
                                  translate(context, 'undefine'),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: color1F1F1F.withOpacity(.6)),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.comment.text ??
                                translate(context, 'cant_load_data'),
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                      child: Row(
                        children: [
                          Text(
                            timeBetween ?? translate(context, 'undefine'),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: black26),
                          ),
                          // SizedBox(
                          //   width: dimensWidth() * 2,
                          // ),
                          // InkWell(
                          //   onTap: onTap,
                          //   child: Text(
                          //     translate(context, 'reply'),
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .labelMedium
                          //         ?.copyWith(color: Colors.black54),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // if (child != null)
        //   Container(
        //     margin: EdgeInsets.only(left: dimensWidth() * 5),
        //     child: Padding(
        //         padding: EdgeInsets.only(top: dimensHeight() * 2),
        //         child: child),
        //   ),
      ],
    );
  }
}
