import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screen/components/badge_notification.dart';
import 'package:healthline/utils/translate.dart';

class LabelDrawer extends StatefulWidget {
  const LabelDrawer(
      {super.key,
      required this.active,
      this.press,
      required this.label,
      required this.icon,
      this.isShowBadge = false});
  final bool active;
  final String label;
  final IconData icon;
  final Function()? press;
  final bool isShowBadge;

  @override
  State<LabelDrawer> createState() => _LabelDrawerState();
}

class _LabelDrawerState extends State<LabelDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastEaseInToSlowEaseOut,
    ));
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    if (widget.active) {
      await Future.delayed(const Duration(milliseconds: 100));
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            right: dimensWidth(),
          ),
          decoration: BoxDecoration(
            color: primary.withOpacity(.2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  dimensWidth() * 2,
                ),
                bottomRight: Radius.circular(
                  dimensWidth() * 2,
                )),
          ),
          width: animation.value * dimensWidth() * 40,
          height: dimensHeight() * 7,
        ),
        Container(
          width: dimensWidth() * 40,
          height: dimensHeight() * 7,
          alignment: Alignment.center,
          child: ListTile(
            focusColor: transparent,
            hoverColor: transparent,
            splashColor: transparent,
            onTap: widget.press,
            dense: true,
            visualDensity: const VisualDensity(vertical: 0),
            title: Text(
              translate(context, widget.label),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: color1F1F1F),
            ),
            leading: badgeNotification(
                child:FaIcon(
                  widget.icon,
                  size: dimensIcon() * .5,
                  color: color1F1F1F,
                ),
                isShow:widget.isShowBadge,
                color:Theme.of(context).colorScheme.error,
                top:-10,
                end:-10),
          ),
        ),
      ],
    );
  }
}
