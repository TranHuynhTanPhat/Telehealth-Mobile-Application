import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class DetailNewsScreen extends StatelessWidget {
  const DetailNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: white,
      appBar: AppBar(
        title: const Text(
            "How accurate are the claims about ashwagandha's benefits?"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          vertical: dimensHeight(),
          horizontal: dimensWidth() * 3,
        ),
        children: [
          Container(
            height: dimensHeight() * 30,
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
                  "How accurate are the claims about ashwagandha's benefits?",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
                '1h trước',
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
            height: dimensHeight() * 5,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                    'From the ALS Ice Bucket Challenge to the Wednesday Dance, social media is known for starting trends that take on a life of their own. However, it is important to remember that not everything you read or hear on social media is true, especially when it comes to health trends. One recent health trend on social platforms is ashwagandha, with users reporting immense stress relief, boosted confidence, and increased libido. But are these claims true? And are there potential risks to using ashwagandha?,There is no denying the fact that stress can have a profound effect on a person’s overall health. According to the State of the Global Workplace 2023 Report, about 44% of workers around the globe say they experience a lot of stress. Previous research shows that ongoing stress can lead to high blood pressureTrusted Source and an increase in cardiovascular events. It can also negatively impact the immune systemTrusted Source, affect metabolic healthTrusted Source, and impact sleep qualityTrusted Source.Because stress can be so damaging to our bodies, it is no wonder why people look for different ways to alleviate it. One method many people on social media platforms are using and promoting is taking supplements of the herb ashwagandha. Called “glizzy pills,” influencers using the hashtag #ashwagandha are reporting benefits including boosted testosterone, increased libido, improved brain function, and feeling so happy, confident, and stress-free that they can better deal with unhappy events like a break-up or removing toxic people from their lives. Could these claims be true or are they misleading? Are there potential risks of taking ashwagandha that people need to know about? And are there other ways people can relieve stress without taking a supplement? Medical News Today spoke with seven medical experts to get the answers to these questions and find out the truth behind social media’s ashwagandha claims',
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
