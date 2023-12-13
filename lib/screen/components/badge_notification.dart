import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

Widget badgeNotification({required Widget child, required bool isShow, required Color color,required double top, required double end}){
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
    child: child,
  );
}