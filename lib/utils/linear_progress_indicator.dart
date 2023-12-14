import 'package:flutter/material.dart';

class LinearProgressIndicatorLoading extends StatefulWidget {
  const LinearProgressIndicatorLoading({super.key});

  @override
  State<LinearProgressIndicatorLoading> createState() =>
      _LinearProgressIndicatorLoadingState();
}

class _LinearProgressIndicatorLoadingState
    extends State<LinearProgressIndicatorLoading>
    with TickerProviderStateMixin {
  // late AnimationController controller;

  @override
  void initState() {
    // controller = AnimationController(
    //   /// [AnimationController]s can be created with `vsync: this` because of
    //   /// [TickerProviderStateMixin].
    //   vsync: this,
    //   duration:
    //       widget.seconds != null ? Duration(seconds: widget.seconds!) : null,
    // );
    // controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
        // color: secondary,
        // value: controller.value,
        // valueColor: controller
        //     .drive(ColorTween(begin: colorCDDEFF, end: secondary)),

        );
  }
}
