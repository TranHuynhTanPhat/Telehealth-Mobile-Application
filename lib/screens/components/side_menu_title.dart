import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.press,
    required this.isActive,
    required this.name,
    required this.icon,
  });

  final VoidCallback press;
  final bool isActive;
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   width: dimensWidth()*35,
        //   padding: EdgeInsets.only(left: dimensWidth() * 3),
        //   child: const Divider(
        //     color: Colors.white24,
        //   ),
        // ),
        Stack(
          children: [
            // AnimatedPositioned(
            //   duration: const Duration(milliseconds: 300),
            //   curve: Curves.fastOutSlowIn,
            //   height: dimensHeight() * 8,
            //   width: isActive ? dimensWidth() * 35 : 0,
            //   left: 0,
            //   child: Container(
            // decoration: BoxDecoration(
            //   color: white,
            //   borderRadius: BorderRadius.circular(dimensWidth()*2)
            // ),
            //   ),
            // ),
            ListTile(
              onTap: press,
              leading: FaIcon(
                icon,
                size: dimensIcon() * .5,
                color: white,
              ),
              title: Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
