import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/news/detail_news_screen.dart';
import 'package:healthline/utils/translate.dart';

class MainNewsPost extends StatelessWidget {
  const MainNewsPost({
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
          top: dimensHeight() * 2,
          bottom: dimensHeight() * 2,
        ),
        child: Column(
          children: [
            Container(
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
                  image: AssetImage(
                    DImages.placeholder,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Covid-19 tại thành phố Hồ Chí Minh',
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
                    translate(context, 'covid-19'),
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
                      'Covid-19 tại thành phố Hồ Chí Minh flkajfkljsdlfjsdf f ladskjflksadf  flkajdfljasldf sadflsadf adlfsalkdfjksdjfka flasdjflskd fldksjflahd f dfjadl dkf adljfl ldfjad lfkas djaflksd fdks',
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
    );
  }
}
