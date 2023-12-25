import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    Key? key,
    required this.services,
    required this.index,
    required this.press,
  }) : super(key: key);

  final List<Map<String, dynamic>> services;
  final int index;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: transparent,
      highlightColor: transparent,
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
            left: index == 0 ? dimensWidth() * 3 : dimensWidth(),
            right:
                index == services.length - 1 ? dimensWidth() * 3 : dimensWidth()),
        width: dimensWidth() * 11,
        height: dimensWidth() * 12,
        child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: dimensWidth() * 9,
                height: dimensWidth() * 9,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: services[index]['color'].withOpacity(.4),
                    borderRadius: BorderRadius.circular(dimensWidth() * 2)),
                child: FaIcon(
                  services[index]['icon'],
                  size: dimensWidth() * 4,
                  color: services[index]['color'],
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    translate(context, services[index]['name']),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  ))
            ],
          
        ),
      ),
    );
  }
}
