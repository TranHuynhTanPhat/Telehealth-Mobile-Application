// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:healthline/data/api/models/responses/news_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class MainNewsPost extends StatefulWidget {
  const MainNewsPost({
    super.key,
    required this.news,
  });

  final NewsResponse news;

  @override
  State<MainNewsPost> createState() => _MainNewsPostState();
}

class _MainNewsPostState extends State<MainNewsPost> {
  var image;

  String? timeBetween;
  @override
  void initState() {
    image = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (widget.news.photo != null && widget.news.photo != 'default') {
        image = image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget.news.photo ?? '')
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
      if (widget.news.updatedAt != null) {
        DateTime from = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .parse(widget.news.updatedAt!);

        DateTime to = DateTime.now();
        timeBetween = daysBetween(context, from, to);
      } else {
        timeBetween = null;
      }
    } catch (e) {
      logPrint(e);
    }
    return InkWell(
      splashColor: transparent,
      highlightColor: transparent,
      onTap: () {
        Navigator.pushNamed(
          context,
          detailNewsName,
          arguments: widget.news.toJson(),
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          top: dimensHeight() * 2,
          bottom: dimensHeight() * 2,
        ),
        child: Column(
          children: [
            Hero(
              tag: widget.news.id!,
              transitionOnUserGestures: true,
              child: Container(
                height: dimensHeight() * 20,
                width: double.infinity,
                margin: EdgeInsets.only(
                  bottom: dimensHeight() * 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    dimensWidth() * 2,
                  ),
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) => {
                      logPrint(exception),
                      setState(() {
                        image = AssetImage(DImages.placeholder);
                      }),
                    },
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.news.title ?? translate(context, 'undefine'),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: dimensHeight() * .5,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: dimensWidth() * .5,
                      horizontal: dimensWidth() * 1.5),
                  margin: EdgeInsets.only(
                    top: dimensHeight() * .5,
                    bottom: dimensHeight() * 1,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: primary.withOpacity(.2),
                  ),
                  child: Text(
                    translate(context, 'news'),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: dimensHeight() * .5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                      widget.news.content ??
                          translate(context, 'cant_load_data'),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
            SizedBox(
              height: dimensHeight() * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FaIcon(
                  FontAwesomeIcons.clock,
                  size: dimensIcon() * .5,
                  color: black26,
                ),
                SizedBox(
                  width: dimensWidth(),
                ),
                Text(
                  timeBetween ?? translate(context, 'undefine'),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: black26),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
