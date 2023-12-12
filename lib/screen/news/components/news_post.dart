import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/data/api/models/responses/news_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/news/detail_news_screen.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class NewsPost extends StatelessWidget {
  const NewsPost({
    super.key,
    required this.news,
  });

  final NewsResponse news;

  @override
  Widget build(BuildContext context) {
    var _image;

    String? timeBetween;

    try {
      if (news.photo != null && news.photo != 'default') {
        _image = _image ??
            NetworkImage(
              CloudinaryContext.cloudinary.image(news.photo ?? '').toString(),
            );
      } else {
        _image = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      _image = AssetImage(DImages.placeholder);
    }
    try {
      if (news.updatedAt != null) {
        DateTime from =
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(news.updatedAt!);

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailNewsScreen(),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(
            top: dimensHeight() * 3, bottom: dimensHeight() * 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: dimensWidth() * 10,
              width: dimensWidth() * 10,
              margin: EdgeInsets.only(right: dimensWidth() * 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  dimensWidth() * 2,
                ),
                image: DecorationImage(
                  image: _image,
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => {
                    logPrint(exception),
                    _image = AssetImage(DImages.placeholder),
                  },
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          news.title ?? translate(context, 'undefine'),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
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
                  Row(
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
                        timeBetween ?? 'undefine',
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
          ],
        ),
      ),
    );
  }
}
