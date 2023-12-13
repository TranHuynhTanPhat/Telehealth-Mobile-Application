import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/screen/forum/components/exports.dart';
import 'package:preload_page_view/preload_page_view.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late PreloadPageController _preloadPageController;

  late int _currentIndex;
  bool like = false;
  @override
  void initState() {
    _preloadPageController = PreloadPageController(initialPage: 0);
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(
            thickness: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
                child: CircleAvatar(
                  backgroundColor: primary,
                  backgroundImage: AssetImage(DImages.placeholder),
                  radius: dimensWidth() * 3,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Le Dinh Truong',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      '5 phút',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
                child: InkWell(
                  borderRadius: BorderRadius.circular(180),
                  child: Padding(
                    padding: EdgeInsets.all(dimensWidth()),
                    child: FaIcon(
                      FontAwesomeIcons.ellipsisVertical,
                      size: dimensIcon() * .7,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: dimensHeight(), horizontal: dimensWidth() * 2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'content fdjflksdfjdlskjfdsajflkjsdlfkjaslkfjldskjfijvnaiuehflkajlkdfjalksfjlkdjfkds',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 0),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: dimensWidth() * 30,
                        child: PreloadPageView.builder(
                            controller: _preloadPageController,
                            itemCount: 1,
                            preloadPagesCount: 1,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (value) {
                              setState(() {
                                _currentIndex = value;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Image.asset(
                                DImages.placeholder,
                                fit: BoxFit.cover,
                              );
                            }),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: dimensHeight(),
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      1,
                      (index) => buildDot(index, context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: dimensHeight(), horizontal: dimensWidth() * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        like = !like;
                      });
                    },
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(0),
                      overlayColor:
                          MaterialStatePropertyAll(Colors.pink.shade50),
                      backgroundColor:
                          const MaterialStatePropertyAll(colorF4F4F4),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            dimensWidth(),
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: like
                                ? FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    size: dimensIcon() * .7,
                                    color: Colors.redAccent,
                                  )
                                : FaIcon(
                                    FontAwesomeIcons.heart,
                                    size: dimensIcon() * .7,
                                    color: black26,
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: dimensWidth(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            translate(context, 'like'),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    color: like ? Colors.redAccent : black26),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: dimensWidth() * 3,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(0),
                      backgroundColor:
                          const MaterialStatePropertyAll(colorF4F4F4),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            dimensWidth(),
                          ),
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FaIcon(
                              FontAwesomeIcons.comment,
                              size: dimensIcon() * .7,
                              color: black26,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: dimensWidth(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            translate(context, 'comment'),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: black26),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
            child: const PostComment(),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      height: dimensWidth(),
      width: _currentIndex == index ? dimensWidth() * 2 : dimensWidth(),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dimensWidth() * 2),
        color: _currentIndex == index ? color1F1F1F.withOpacity(.3) : white,
      ),
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
