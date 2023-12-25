// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/data/api/models/responses/news_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class DetailNewsScreen extends StatefulWidget {
  const DetailNewsScreen({super.key, this.args});
  final String? args;

  @override
  State<DetailNewsScreen> createState() => _DetailNewsScreenState();
}

class _DetailNewsScreenState extends State<DetailNewsScreen> {
  late NewsResponse news;

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
      news = NewsResponse.fromJson(widget.args!);
    } catch (e) {
      EasyLoading.showToast(translate(context, 'cant_load_data'));
      Navigator.pop(context);
      return const SizedBox();
    }

    try {
      if (news.photo != null && news.photo != 'default') {
        image = image ??
            NetworkImage(
              CloudinaryContext.cloudinary.image(news.photo ?? '').toString(),
            );
      } else {
        image = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      image = AssetImage(DImages.placeholder);
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          news.title ?? translate(context, 'undefine'),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          vertical: dimensHeight(),
          horizontal: dimensWidth() * 3,
        ),
        children: [
          Hero(
            tag: news.id!,
            transitionOnUserGestures: true,
            child: Container(
              height: dimensHeight() * 30,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: dimensWidth() * 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  dimensWidth() * 2,
                ),
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => {
                    logPrint(exception),
                    logPrint(stackTrace),
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
                  news.title ?? translate(context, 'cant_load_data'),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.justify,
                ),
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
          SizedBox(
            height: dimensHeight() * .5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${translate(context, 'tags')}:',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: dimensHeight(),
              ),
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
              Expanded(
                child: Text(
                    news.content ?? translate(context, 'cant_load_data'),
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            ],
          ),
          SizedBox(
            height: dimensHeight() * 10,
          ),
        ],
      ),
    );
  }
}
