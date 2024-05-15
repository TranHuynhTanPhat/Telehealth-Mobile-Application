import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class AllFeedbacks extends StatefulWidget {
  const AllFeedbacks({super.key, this.feedbacks});
  final List<FeedbackResponse>? feedbacks;

  @override
  State<AllFeedbacks> createState() => _AllFeedbacksState();
}

class _AllFeedbacksState extends State<AllFeedbacks> {
  List<FeedbackResponse> feedbacks = [];
  int dropdownValue = 0;

  @override
  void initState() {
    if (!mounted) return;
    feedbacks = widget.feedbacks ?? feedbacks;
    feedbacks = feedbacks
        .where((element) => element.rated != null && element.rated! > 0)
        .toList();
    feedbacks.sort((a, b) {
      DateTime? aTime = convertStringToDateTime(a.createdAt);
      DateTime? bTime = convertStringToDateTime(b.createdAt);
      if (aTime != null && bTime != null) {
        return aTime.compareTo(bTime);
      } else {
        return aTime == null ? -1 : 1;
      }
    });
    feedbacks = feedbacks.reversed.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          translate(context, 'feedbacks'),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: secondary.withOpacity(.1), width: .5),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 3,
              vertical: dimensHeight() * 2,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: white,
                    ),
                  ),
                ),
                SizedBox(
                  width: dimensWidth() * 3,
                ),
                Expanded(
                    child: PopupMenuButton(
                  elevation: 4,
                  position: PopupMenuPosition.under,
                  initialValue: dropdownValue,
                  color: white,
                  surfaceTintColor: white,
                  constraints: BoxConstraints(
                      minWidth: (MediaQuery.of(context).size.width -
                              dimensWidth() * 9) /
                          2),
                  offset: const Offset(0, 15),
                  onSelected: (value) => setState(() {
                    dropdownValue = value;
                  }),
                  itemBuilder: (BuildContext context) {
                    return List.generate(6, (index) => index)
                        .toList()
                        .map<PopupMenuItem<int>>((int value) {
                      return PopupMenuItem<int>(
                        value: value,
                        child: Container(
                          width: double.infinity,
                          color: transparent,
                          child: Text(
                            "${value == 0 ? translate(context, 'all') : value}",
                          ),
                        ),
                      );
                    }).toList();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondary.withOpacity(.2),
                      borderRadius: BorderRadius.circular(
                        dimensWidth(),
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: dimensWidth(),
                      vertical: dimensHeight(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${dropdownValue == 0 ? translate(context, 'all') : dropdownValue}",
                              style: Theme.of(context).textTheme.bodyLarge,
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(
                              width: dimensWidth(),
                            ),
                            FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.orange,
                              size: dimensIcon() / 3,
                            ),
                          ],
                        ),
                        FaIcon(
                          FontAwesomeIcons.angleDown,
                          color: Colors.black,
                          size: dimensIcon() / 2,
                        ),
                      ],
                    ),
                  ),
                )
                    //   DropdownButton<int>(
                    //   value: dropdownValue,
                    //   icon: FaIcon(
                    //             FontAwesomeIcons.solidStar,
                    //             color: Colors.orange,
                    //             size: dimensIcon() / 3,
                    //           ),
                    //   elevation: 16,
                    //   borderRadius: BorderRadius.circular(dimensWidth()),
                    //   alignment: Alignment.center,
                    //   // underline: Container(decoration: BoxDecoration(border: Border.all(width: 0)),),
                    //   onChanged: (int? value) {
                    //     // This is called when the user selects an item.
                    //     setState(() {
                    //       dropdownValue = value!;
                    //     });
                    //   },
                    //   items: List.generate(5, (index) => index + 1)
                    //       .toList()
                    //       .map<DropdownMenuItem<int>>((int value) {
                    //     return DropdownMenuItem<int>(
                    //       value: value,
                    //       child: Center(child: Text("$value")),
                    //     );
                    //   }).toList(),
                    // )
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: secondary.withOpacity(.2),
                    //     borderRadius: BorderRadius.circular(
                    //       dimensWidth(),
                    //     ),
                    //   ),
                    //   alignment: Alignment.center,
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: dimensWidth(),
                    //     vertical: dimensHeight(),
                    //   ),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         translate(context, "star"),
                    //         overflow: TextOverflow.visible,
                    //       ),
                    //       SizedBox(
                    //         width: dimensWidth(),
                    //       ),
                    //       FaIcon(
                    //         FontAwesomeIcons.solidStar,
                    //         color: Colors.orange,
                    //         size: dimensIcon() / 3,
                    //       ),
                    //       SizedBox(
                    //         width: dimensWidth(),
                    //       ),
                    //       FaIcon(FontAwesomeIcons.angleDown,
                    //           size: dimensIcon() / 2),
                    //     ],
                    //   ),
                    // ),
                    ),
              ],
            ),
          ),
          if (feedbacks.isNotEmpty)
            ...feedbacks
                .where((element) =>
                    dropdownValue == 0 || element.rated == dropdownValue
                        ? true
                        : false)
                .map((e) {
              // ignore: prefer_typing_uninitialized_variables
              var image;
              try {
                if (e.user?.avatar != null &&
                    e.user?.avatar != 'default' &&
                    e.user?.avatar != '') {
                  image = image ??
                      NetworkImage(
                        CloudinaryContext.cloudinary
                            .image(e.user?.avatar ?? '')
                            .toString(),
                      );
                } else {
                  image = AssetImage(DImages.placeholder);
                }
              } catch (e) {
                logPrint(e);
                image = AssetImage(DImages.placeholder);
              }
              DateTime? createdAt = convertStringToDateTime(e.createdAt);
              return ListTile(
                shape: Border(
                  bottom:
                      BorderSide(color: secondary.withOpacity(.1), width: .5),
                ),
                leading: CircleAvatar(
                  radius: dimensWidth() * 3,
                  backgroundImage: image,
                  onBackgroundImageError: (exception, stackTrace) {
                    logPrint(exception);
                  },
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        e.user?.fullName ?? translate(context, 'undefine'),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    InkWell(
                      splashColor: transparent,
                      highlightColor: transparent,
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                // insetPadding: EdgeInsets.zero,
                                // iconPadding: EdgeInsets.zero,
                                // titlePadding: EdgeInsets.zero,
                                // buttonPadding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.zero,
                                // actionsPadding: EdgeInsets.zero,
                                content: InkWell(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: dimensWidth() * 2,
                                            vertical: dimensHeight() * 2),
                                        child: Text(
                                          translate(context, 'report'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                      child: FaIcon(
                        FontAwesomeIcons.ellipsis,
                        size: dimensIcon() / 2,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      ignoreGestures: true,
                      initialRating: (e.rated ?? 0).toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: dimensWidth() * 1.5,
                      itemBuilder: (context, _) => const FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.orangeAccent,
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    if (e.feedback != null)
                      Container(
                        padding: EdgeInsets.only(
                          top: dimensHeight(),
                        ),
                        width: double.infinity,
                        child: Text(e.feedback!),
                      ),
                    if (createdAt != null)
                      Container(
                        padding: EdgeInsets.only(top: dimensHeight()),
                        width: double.infinity,
                        child: Text(
                          formatyMMMMd(context, createdAt),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: black26.withOpacity(.5), fontSize: 8),
                        ),
                      )
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
