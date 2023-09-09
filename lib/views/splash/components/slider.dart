import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/views/widgets/shimmer_widget.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.description});
  final String image;
  final String title;
  final String description;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // image given in slider
          Image(
            image: AssetImage(widget.image),
            height: dimensImage() * 50,
            width: dimensImage() * 50,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return ShimmerWidget(
                  child: SizedBox(
                width: dimensImage() * 50,
                height: dimensImage() * 50,
              ));
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text.rich(TextSpan(
                        text: widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                        children: [
                      TextSpan(
                          text: "\n${widget.description}",
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
