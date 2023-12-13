// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_forum/forum_cubit.dart';
import 'package:healthline/data/api/models/responses/post_response.dart';
import 'package:healthline/screen/forum/components/exports.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:intl/intl.dart';
import 'package:preload_page_view/preload_page_view.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.post});
  final PostResponse post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late PreloadPageController _preloadPageController;
  var image;
  late List<String?> images;

  late int _currentIndex;
  bool like = false;
  String? timeBetween;

  @override
  void initState() {
    image = null;
    images = [];
    _preloadPageController = PreloadPageController(initialPage: 0);
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.post.photo?.removeWhere((element) => element == '');
    try {
      if (widget.post.photo!.isNotEmpty && images.isEmpty) {
        images = List.generate(widget.post.photo?.length ?? 0, (index) => null);
      }
    } catch (e) {
      logPrint(e);
    }
    try {
      if (widget.post.user?.avatar != null &&
          widget.post.user?.avatar != 'default' &&
          widget.post.user?.avatar != '') {
        image = image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget.post.user?.avatar ?? '')
                  .toString(),
            );
      } else {
        image = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      image = AssetImage(DImages.placeholder);
    }
    try {
      if (widget.post.updatedAt != null) {
        DateTime from = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .parse(widget.post.updatedAt!);

        DateTime to = DateTime.now();
        timeBetween = daysBetween(context, from, to);
      } else {
        timeBetween = null;
      }
    } catch (e) {
      logPrint(e);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Divider(
          thickness: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth(), vertical: dimensHeight()),
              child: CircleAvatar(
                backgroundColor: primary,
                backgroundImage: AssetImage(DImages.placeholder),
                radius: dimensWidth() * 3,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.post.user?.fullName ??
                        translate(context, 'undefine'),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    timeBetween ?? translate(context, 'undefine'),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
              child: InkWell(
                borderRadius: BorderRadius.circular(180),
                child: Padding(
                  padding: EdgeInsets.all(dimensWidth()),
                  child: FaIcon(
                    FontAwesomeIcons.ellipsisVertical,
                    size: dimensIcon() * .7,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: dimensHeight() * 2, horizontal: dimensWidth() * 2),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.post.description ?? translate(context, 'undefine'),
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (widget.post.photo!.isNotEmpty && widget.post.photo != null)
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 0),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: dimensWidth() * 30,
                        child: PreloadPageView.builder(
                            controller: _preloadPageController,
                            itemCount: widget.post.photo?.length,
                            preloadPagesCount: widget.post.photo?.length ?? 0,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (value) {
                              setState(() {
                                _currentIndex = value;
                              });
                            },
                            itemBuilder: (context, index) {
                              try {
                                if (widget.post.photo?[index] != null &&
                                    widget.post.photo?[index] != 'default' &&
                                    widget.post.photo?[index] != '') {
                                  images[index] = images[index] ??
                                      CloudinaryContext.cloudinary
                                          .image(
                                              widget.post.photo?[index] ?? '')
                                          .toString();
                                } else {
                                  images[index] = DImages.placeholder;
                                }
                              } catch (e) {
                                logPrint(e);
                                images[index] = DImages.placeholder;
                              }
                              return Image.network(
                                images[index]!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  logPrint(error);
                                  return Image.asset(DImages.placeholder,
                                      fit: BoxFit.cover);
                                },
                              );
                            }),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: dimensHeight(),
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.post.photo?.length ?? 0,
                      (index) => buildDot(index, context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        const Divider(
          height: 0,
        ),
        Padding(
          padding: EdgeInsets.only(
              top: dimensHeight(),
              left: dimensWidth() * 2,
              right: dimensWidth() * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                splashColor: transparent,
                highlightColor: transparent,
                onTap: () {
                  setState(() {
                    like = !like;
                  });
                },
                child: like
                    ? FaIcon(
                        FontAwesomeIcons.solidHeart,
                        size: dimensIcon() * .8,
                        color: Colors.redAccent,
                      )
                    : FaIcon(
                        FontAwesomeIcons.heart,
                        size: dimensIcon() * .8,
                        color: black26,
                      ),
              ),
              //  ElevatedButton(
              //   onPressed: () {
              //     setState(() {
              //       like = !like;
              //     });
              //   },
              //   style: ButtonStyle(
              //     elevation: const MaterialStatePropertyAll(0),
              //     overlayColor:
              //         MaterialStatePropertyAll(Colors.pink.shade50),
              //     backgroundColor:
              //         const MaterialStatePropertyAll(colorF4F4F4),
              //     shape: MaterialStatePropertyAll(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(
              //           dimensWidth(),
              //         ),
              //       ),
              //     ),
              //   ),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         flex: 1,
              //         child: Align(
              //           alignment: Alignment.centerRight,
              //           child: like
              //               ? FaIcon(
              //                   FontAwesomeIcons.solidHeart,
              //                   size: dimensIcon() * .7,
              //                   color: Colors.redAccent,
              //                 )
              //               : FaIcon(
              //                   FontAwesomeIcons.heart,
              //                   size: dimensIcon() * .7,
              //                   color: black26,
              //                 ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: dimensWidth(),
              //       ),
              //       Expanded(
              //         flex: 2,
              //         child: Text(
              //           translate(context, 'like'),
              //           overflow: TextOverflow.ellipsis,
              //           style: Theme.of(context)
              //               .textTheme
              //               .labelLarge
              //               ?.copyWith(
              //                   color: like ? Colors.redAccent : black26),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                width: dimensWidth() * 3,
              ),
              InkWell(
                splashColor: transparent,
                highlightColor: transparent,
                onTap: () {
                  try {
                    context
                        .read<ForumCubit>()
                        .fetchComment(id: widget.post.id!);
                  } catch (e) {
                    logPrint(e);
                    EasyLoading.showToast(translate(context, 'cant_load_data'));
                  }
                },
                child: FaIcon(
                  FontAwesomeIcons.comment,
                  size: dimensIcon() * .8,
                  color: black26,
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ButtonStyle(
              //     elevation: const MaterialStatePropertyAll(0),
              //     backgroundColor:
              //         const MaterialStatePropertyAll(colorF4F4F4),
              //     shape: MaterialStatePropertyAll(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(
              //           dimensWidth(),
              //         ),
              //       ),
              //     ),
              //   ),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         flex: 1,
              //         child: Align(
              //           alignment: Alignment.centerRight,
              //           child: FaIcon(
              //             FontAwesomeIcons.comment,
              //             size: dimensIcon() * .7,
              //             color: black26,
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: dimensWidth(),
              //       ),
              //       Expanded(
              //         flex: 2,
              //         child: Text(
              //           translate(context, 'comment'),
              //           overflow: TextOverflow.ellipsis,
              //           style: Theme.of(context)
              //               .textTheme
              //               .labelLarge
              //               ?.copyWith(color: black26),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: dimensWidth() * 2,
              right: dimensWidth() * 2,
              bottom: dimensHeight(),
              top: dimensHeight()),
          child: Text(
            '${widget.post.likes?.length ?? 0} ${translate(context, 'liked')}',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: black26),
            textAlign: TextAlign.start,
          ),
        ),
        const Divider(
          height: 0,
        ),
        PostComment(
          idPost: widget.post.id,
        ),
      ],
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      height: dimensWidth(),
      width: _currentIndex == index ? dimensWidth() * 2 : dimensWidth(),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dimensWidth() * 2),
        color: _currentIndex == index ? color1F1F1F.withOpacity(.3) : white,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
