import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

Widget badgeNotification(Widget widget, bool isShow, Color color,double top, double end){
  return badges.Badge(
    position: badges.BadgePosition.topEnd(top: top, end: end),
    showBadge: isShow,
    badgeContent: const SizedBox(),
    badgeAnimation: const badges.BadgeAnimation.scale(),
    badgeStyle: badges.BadgeStyle(
      shape: badges.BadgeShape.circle,
      elevation: 0,
      badgeColor: color,
    ),
    child: widget,
  );
}