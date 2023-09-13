import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/main/home/components/export.dart';

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
        itemBuilder: (context, index) => ServiceCard(services: services, index: index,),
      ),
    );
  }
}


