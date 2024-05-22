import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: white,
      appBar: AppController().authState == AuthState.PatientAuthorized
          ? AppBar(
              surfaceTintColor: transparent,
              scrolledUnderElevation: 0,
              backgroundColor: white,
              title: Padding(
                padding: EdgeInsets.only(left: dimensWidth()),
                child: Text(
                  translate(context, 'message'),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: color1F1F1F, fontWeight: FontWeight.w900),
                ),
              ),
              centerTitle: false,
            )
          : null,
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: dimensWidth() * 3, vertical: dimensHeight()),
        shrinkWrap: true,
        children: [
          TextFieldWidget(
            // focusNode: _focus,
            validate: (p0) => null,
            hint: translate(context, 'search'),
            fillColor: colorF2F5FF,
            filled: true,
            focusedBorderColor: colorF2F5FF,
            enabledBorderColor: colorF2F5FF,
            controller: _searchController,
            onChanged: (value) {
              // Future.delayed(const Duration(seconds: 1), () {
              //   if (value == _searchController.text.trim()) {
              //     _pagingController.refresh();
              //   }
              // });
            },
            prefixIcon: IconButton(
              padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
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
            suffixIcon: IconButton(
              padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
              onPressed: () {},
              icon: InkWell(
                splashColor: transparent,
                highlightColor: transparent,
                onTap: () {
                  // if (_searchController.text.isNotEmpty) {
                  //   _searchController.text = '';
                  //   _pagingController.refresh();
                  // } else {
                  //   KeyboardUtil.hideKeyboard(context);
                  //   _checkFocus();
                  // }
                },
                child: FaIcon(
                  FontAwesomeIcons.solidCircleXmark,
                  color: color6A6E83,
                  size: dimensIcon() * .5,
                ),
              ),
            ),
          ),
          SizedBox(
            height: dimensHeight() * 3,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, chatBoxName),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(dimensWidth() * 2),
                  // border: Border.all(width: .5, color: black26.withOpacity(.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.07),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: primary,
                        backgroundImage: AssetImage(DImages.placeholder),
                        radius: dimensHeight() * 2.5,
                        onBackgroundImageError: (exception, stackTrace) {
                          logPrint(exception);
                        },
                      ),
                      SizedBox(
                        width: dimensWidth(),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text.rich(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.normal, color: black26),
                                  TextSpan(
                                    text: "${translate(context, 'you')}: ",
                                    children: const [
                                      TextSpan(
                                        text: "the last message",
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                                right: 0,
                                top: 0,
                                child: Text(
                                  "20:00",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: black26),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
