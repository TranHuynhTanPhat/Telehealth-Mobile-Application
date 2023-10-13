import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class RecordCard extends StatelessWidget {
  const RecordCard({
    super.key,
    required this.name,
    required this.color,
    required this.iconData,
    required this.press,
  });
  final String name;

  final Color color;
  final IconData iconData;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      splashColor: transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          dimensWidth(),
        ),
      ),
      onTap: press,
      leading: Container(
        width: dimensWidth() * 7,
        decoration: BoxDecoration(
            color: color.withOpacity(.4),
            borderRadius: BorderRadius.circular(dimensWidth())),
        alignment: Alignment.center,
        child: FaIcon(
          iconData,
          size: dimensIcon(),
          color: color,
        ),
      ),
      title: Text(
        translate(context, name),
        style: Theme.of(context).textTheme.labelLarge,
      ),
      trailing: FaIcon(
        FontAwesomeIcons.angleRight,
        size: dimensIcon() * .5,
        color: black26,
      ),
    );

    // Container(
    //   margin: EdgeInsets.only(bottom: dimensWidth() * 2),
    //   // padding: EdgeInsets.symmetric(
    //   //     vertical: dimensHeight(), horizontal: dimensWidth()),
    //   width: double.maxFinite,
    //   // decoration: BoxDecoration(
    //   //   border: Border.all(color: color1F1F1F.withOpacity(.1)),
    //   //   borderRadius: BorderRadius.circular(dimensWidth() * 1.8),
    //   // ),
    //   child: InkWell(
    //     splashColor: transparent,
    //     highlightColor: transparent,
    //     onTap: press,
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Row(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    // Container(
    //   decoration: BoxDecoration(
    //       color: color.withOpacity(.4),
    //       borderRadius: BorderRadius.circular(dimensWidth() * 1.3)),
    //   padding: EdgeInsets.all(dimensWidth() * 1.3),
    //   margin: EdgeInsets.only(right: dimensWidth()),
    //   child: FaIcon(
    //     iconData,
    //     size: dimensWidth() * 4,
    //     color: color,
    //   ),
    // ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    // Text(
    //   translate(context, name),
    //   style: Theme.of(context).textTheme.titleMedium,
    // ),
    //               ],
    //             )
    //           ],
    //         ),
    // const FaIcon(FontAwesomeIcons.angleRight)
    //       ],
    //     ),
    //   ),
    // );
  }
}
