import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/cubits/cubit_slider/slider_cubit.dart';
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
  SliderCubit sliderCubit = SliderCubit();
  @override
  void initState() {
    sliderCubit.getURL(widget.fileName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SliderCubit, SliderState>(
      bloc: sliderCubit,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // image given in slider
              state.runtimeType == SliderLoaded
                  ? Image(
                      image: NetworkImage((state as SliderLoaded).url),
                      height: dimensImage() * 50,
                      // width: dimensImage() * 50,
                      fit: BoxFit.contain,
                      // placeholder: AssetImage(DImages.placeholder),
                      // imageErrorBuilder: (context, error, stackTrace) =>
                      //     Container(
                      //   decoration: const BoxDecoration(color: colorEBEBF4),
                      //   height: dimensImage() * 50,
                      //   // width: dimensImage() * 50,
                      // ),
                      // placeholderFit: BoxFit.scaleDown,
                    )
                  : Container(
                      decoration: const BoxDecoration(color: white),
                      height: dimensImage() * 50,
                      width: dimensImage() * 50),
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
      },
    );
  }
}
