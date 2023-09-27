import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class SubUserCard extends StatelessWidget {
  const SubUserCard({
    super.key, required this.subUser,
  });
  final Map<String, dynamic> subUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: dimensWidth(),
          horizontal: dimensWidth()),
      padding: EdgeInsets.symmetric(
        horizontal: dimensWidth(),
        vertical: dimensHeight() * .5,
      ),
      alignment: Alignment.bottomCenter,
      width: dimensWidth() * 10,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(
              dimensWidth() * 2),
          image: DecorationImage(
              image:
                  AssetImage(DImages.placeholder),
              fit: BoxFit.cover)),
      child: Text(
        subUser['name'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:
            Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}