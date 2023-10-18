import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.name,
    required this.description,
    required this.icon,
  });
  final String name;
  final String description;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: dimensHeight()),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              icon,
              SizedBox(
                width: dimensWidth() * 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    width: dimensWidth() * 35,
                    child: Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
          FaIcon(
            FontAwesomeIcons.angleRight,
            size: dimensIcon() * .5,
            color: color1F1F1F,
          ),
        ],
      ),
    );
  }
}
