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
      height: dimensWidth() * 12,
      child: ListView.builder(
        padding: EdgeInsets.only(top: dimensHeight()),
        itemCount: services.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(
              left: index == 0 ? dimensWidth() * 3 : dimensWidth(),
              right: index == services.length - 1
                  ? dimensWidth() * 3
                  : dimensWidth()),
          width: dimensWidth() * 11,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Expanded(
                  child: Text(
                services[index]['name'],
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
