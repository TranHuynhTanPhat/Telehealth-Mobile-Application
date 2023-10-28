import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/news/components/export.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late TextEditingController _searchController;

  final FocusNode _focus = FocusNode();

  bool openSearch = false;

  @override
  void initState() {
    _searchController = TextEditingController();
    _focus.addListener(_checkFocus);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_checkFocus);
    _focus.dispose();
  }

  void _checkFocus() {
    if (_focus.hasFocus == false) {
      setState(() {
        openSearch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: false,
              pinned: true,
              floating: true,
              titleSpacing: 0,
              leadingWidth: openSearch ? 0 : null,
              leading: openSearch ? const SizedBox() : null,
              title: openSearch
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                      child: TextFieldWidget(
                        focusNode: _focus,
                        validate: (p0) => null,
                        hint: translate(context, 'search'),
                        fillColor: colorF2F5FF,
                        filled: true,
                        focusedBorderColor: colorF2F5FF,
                        enabledBorderColor: colorF2F5FF,
                        controller: _searchController,
                        suffixIcon: IconButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 2),
                          onPressed: () {},
                          icon: InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            onTap: () {
                              if (_searchController.text.isNotEmpty) {
                                _searchController.text = '';
                              } else {
                                setState(() {
                                  _focus.unfocus();
                                  _checkFocus();
                                });
                              }
                            },
                            child: FaIcon(
                              FontAwesomeIcons.solidCircleXmark,
                              color: color6A6E83,
                              size: dimensIcon() * .5,
                            ),
                          ),
                        ),
                        prefixIcon: IconButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 2),
                          onPressed: () {},
                          icon: InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            onTap: () {},
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: color6A6E83,
                              size: dimensIcon() * .8,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      translate(context, 'news'),
                    ),
              actions: [
                if (openSearch == false)
                  Padding(
                    padding: EdgeInsets.only(right: dimensWidth() * 2),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(180),
                      onTap: () {
                        setState(() {
                          openSearch = true;
                          _focus.requestFocus();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(
                          dimensWidth(),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: dimensIcon() * .7,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ];
        },
        body: GestureDetector(
          onTap: () {
            KeyboardUtil.hideKeyboard(context);
            _checkFocus();
          },
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 3,
              vertical: dimensHeight(),
            ),
            children: const [
              MainNewsPost(),
              NewsPost(),
              NewsPost(),
              NewsPost(),
              NewsPost(),
              NewsPost(),
              NewsPost(),
              NewsPost(),
              NewsPost(),
              NewsPost(),
              NewsPost(),
              NewsPost(),
            ],
          ),
        ),
      ),
    );
  }
}
