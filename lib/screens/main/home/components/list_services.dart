import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';

class ListServices extends StatelessWidget {
  const ListServices({
    super.key,
    required this.services,
  });

  final List<Map<String, dynamic>> services;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dimensWidth() * 10,
      child: ListView.builder(
        padding: EdgeInsets.only(top: dimensHeight() ),
        itemCount: services.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          width: dimensWidth() * 9,
          height: dimensWidth() * 9,
          alignment: Alignment.center,
          margin: EdgeInsets.only(
              left: index == 0 ? dimensWidth() * 3 : dimensWidth(),
              right: index == services.length - 1
                  ? dimensWidth() * 3
                  : dimensWidth()),
          decoration: BoxDecoration(
              color: services[index]['color'].withOpacity(.4),
              borderRadius: BorderRadius.circular(dimensWidth() * 2)),
          child: FaIcon(
            services[index]['icon'],
            size: dimensWidth() * 5,
            color: services[index]['color'],
          ),
        ),
      ),
    );
  }
}