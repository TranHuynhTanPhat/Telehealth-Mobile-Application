import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: secondary,
            ),
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(DImages.placeholder),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Bs. Lê Đình Trường',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: white),
                ),
                Text(
                  'leditruong@gmail.com',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: white),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(translate(context, 'schedule')),
            onTap: () {},
          ),
          ListTile(
            title: Text(translate(context, 'wallet')),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
