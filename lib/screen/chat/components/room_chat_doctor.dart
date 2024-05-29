import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:healthline/data/api/models/responses/room_chat.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class RoomChatDoctor extends StatefulWidget {
  const RoomChatDoctor({super.key, required this.detail});
  final RoomChat detail;

  @override
  State<RoomChatDoctor> createState() => _RoomChatDoctorState();
}

class _RoomChatDoctorState extends State<RoomChatDoctor> {
  // ignore: prefer_typing_uninitialized_variables
  var image;
  @override
  void initState() {
    if (!mounted) return;
    if (widget.detail.id == null) return;
    if (widget.detail.medical?.avatar != null) {
      image = NetworkImage(CloudinaryContext.cloudinary
          .image(widget.detail.medical?.avatar ?? '')
          .toString());
    } else {
      image = AssetImage(DImages.placeholder);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: transparent,
      highlightColor: transparent,
      hoverColor: transparent,
      onTap: () =>
          Navigator.pushNamed(context, chatBoxName, arguments: widget.detail),
      child: Container(
        margin: EdgeInsets.only(bottom: dimensHeight() * 2),
        padding: EdgeInsets.symmetric(
            horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(dimensWidth() * 2),
            // border: Border.all(width: .5, color: black26.withOpacity(.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.07),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ]),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: primary,
                  backgroundImage: image,
                  radius: dimensHeight() * 2.5,
                  onBackgroundImageError: (exception, stackTrace) {
                    logPrint(exception);
                    setState(() {
                      image = AssetImage(DImages.placeholder);
                    });
                  },
                ),
                SizedBox(
                  width: dimensWidth(),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translate(context, 'dr')}. ${widget.detail.medical?.fullName ?? translate(context, 'empty')}",
                            style: Theme.of(context).textTheme.labelLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (widget.detail.lastMessage != "")
                            Text(
                              "${widget.detail.lastMessage}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: black26),
                            ),
                        ],
                      ),
                      // Positioned(
                      //     right: 0,
                      //     top: 0,
                      //     child: Text(
                      //       "${widget.detail.createdAt}",
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .bodySmall
                      //           ?.copyWith(color: black26),
                      //     )),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
