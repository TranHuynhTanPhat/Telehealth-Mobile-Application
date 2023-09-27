import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.mess});
  final Map<String, dynamic> mess;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: dimensHeight()),
      padding: EdgeInsets.symmetric(
          vertical: dimensHeight() * 2, horizontal: dimensWidth() * 2),
      decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
            color: Colors.grey.withOpacity(.1),
            spreadRadius: dimensWidth() * .4,
            blurRadius: dimensWidth() * .4,
          ),
          ],
          borderRadius: BorderRadius.circular(dimensWidth() * 2),
          border: Border.all(color: colorA8B1CE.withOpacity(.2), width: 2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: dimensWidth() * 2),
            width: dimensWidth() * 8,
            height: dimensWidth() * 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dimensWidth() * 1.5),
              image: DecorationImage(
                image: AssetImage(mess['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      mess['dr'],
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      mess['time'].format(context).toString(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                SizedBox(
                  height: dimensHeight(),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        mess['message'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    mess['unread'] != 0
                        ? Container(
                            margin: EdgeInsets.only(left: dimensWidth()),
                            width: dimensWidth() * 3,
                            height: dimensWidth() * 3,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              mess['unread'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: white),
                            ),
                          )
                        : const SizedBox()
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}