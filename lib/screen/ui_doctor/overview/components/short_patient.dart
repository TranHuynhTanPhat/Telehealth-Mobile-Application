import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';

class ShortPatient extends StatelessWidget {
  const ShortPatient({
    super.key,
    required this.fullName,
    this.email,
    this.phone,
  });
  final String fullName;
  final String? email;
  final String? phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
      decoration: BoxDecoration(
        color: colorF2F5FF,
        borderRadius: BorderRadius.circular(dimensWidth() * 2),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: primary,
            backgroundImage: AssetImage(DImages.placeholder),
            radius: dimensHeight() * 3,
            onBackgroundImageError: (exception, stackTrace) {
              logPrint(exception);
            },
          ),
          SizedBox(
            width: dimensWidth() * 2,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        fullName,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
                if (email != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          email!,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                if (phone != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          phone!,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
