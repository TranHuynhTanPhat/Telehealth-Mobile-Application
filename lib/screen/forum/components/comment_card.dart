import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.onTap, this.child});

  final Function() onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: primary,
              backgroundImage: AssetImage(DImages.placeholder),
              radius: dimensHeight() * 2.5,
            ),
            SizedBox(
              width: dimensWidth(),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: dimensWidth() * 2, vertical: dimensWidth()),
                decoration: BoxDecoration(
                  color: colorF2F5FF.withOpacity(.5),
                  borderRadius: BorderRadius.circular(dimensWidth() * 2),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tran Huynh Tan Phat',
                            style: Theme.of(context).textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'fkạdflkjdslfjlsdjflkádjfjádlkfjldàkladsjfl dklfjaldskjflsdjfkadsjlfsjdàkdls',
                            style: Theme.of(context).textTheme.bodyLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: dimensHeight()),
                      child: Row(
                        children: [
                          Text(
                            '5 phút',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: black26),
                          ),
                          SizedBox(
                            width: dimensWidth() * 2,
                          ),
                          InkWell(
                            onTap: onTap,
                            child: Text(
                              translate(context, 'reply'),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        if (child != null)
          Container(
            margin: EdgeInsets.only(left: dimensWidth() * 5),
            child: 
            Padding(
                padding: EdgeInsets.only(top: dimensHeight() * 2),
                child: child),
          ),
      ],
    );
  }
}
