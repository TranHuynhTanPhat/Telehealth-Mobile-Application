import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/news/detail_news_screen.dart';
import 'package:healthline/utils/translate.dart';

class NewsPost extends StatelessWidget {
  const NewsPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    image: AssetImage(DImages.placeholder), fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Covid-19 tại cộng hoà Séc',
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
                          translate(context, 'covid-19'),
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
                        '1h trước',
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
