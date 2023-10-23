import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_url_gen/transformation/transformation.dart';
import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget(
      {super.key,
      required this.fileName,
      required this.title,
      required this.description});
  final String fileName;
  final String title;
  final String description;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CldImageWidget(
            publicId: "healthline/onboarding/images/${widget.fileName}",
            transformation: Transformation(),
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
