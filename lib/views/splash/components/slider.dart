import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.description});
  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // image given in slider
          Image(image: AssetImage(image), height: dimensImage()*50,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text.rich(TextSpan(
                        text: title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                        children: [
                      TextSpan(
                          text: "\n$description",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: color6A6E83))
                    ])))
              ],
            ),
          )
        ],
      ),
    );
  }
}
