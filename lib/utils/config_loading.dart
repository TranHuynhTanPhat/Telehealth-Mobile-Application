import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/res/colors.dart';

void configLoading(context) {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 4000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..indicatorSize = 40
    ..radius = 21.0
    ..progressColor = white
    ..backgroundColor = colorF2F5FF
    ..indicatorColor = primary
    ..textColor = color1F1F1F
    ..maskColor = transparent
    ..userInteractions = true
    ..dismissOnTap = false
    ..toastPosition = EasyLoadingToastPosition.top
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..textAlign = TextAlign.center
    // ..textStyle = Theme.of(context).textTheme.bodyLarge
    ..contentPadding = const EdgeInsets.all(10)
    ..textPadding = EdgeInsets.zero
    ..animationDuration = const Duration(milliseconds: 200)
    ..customAnimation = CustomAnimation();
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
