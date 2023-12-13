import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_forum/forum_cubit.dart';
import 'package:healthline/data/api/models/responses/post_response.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screen/forum/components/exports.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meilisearch/meilisearch.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  late TextEditingController _textEdittingController;
  late TextEditingController _searchController;

  final FocusNode _focus = FocusNode();

  bool openSearch = false;

  static const _pageSize = 20;

  final PagingController<int, PostResponse> _pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 5);

  @override
  void initState() {
    _textEdittingController = TextEditingController();
    _searchController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<ForumCubit>().searchPost(
            key: _searchController.text,
            searchQuery: const SearchQuery(
                limit: 20,
                attributesToSearchOn: ['description', 'user.full_name'],
                sort: ['updatedAt:desc']),
            pageKey: pageKey,
            callback: (news) => updateData(news: news, pageKey: pageKey),
          );
    });
    if (!mounted) return;
    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              translate(context, 'cant_load_data'),
            ),
            action: SnackBarAction(
              label: translate(context, 'retry'),
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
    _focus.addListener(_checkFocus);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
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

  void updateData({required List<PostResponse> news, required int pageKey}) {
    final isLastPage = news.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(news);
    } else {
      final nextPageKey = pageKey + news.length;
      _pagingController.appendPage(news, nextPageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: white,
      body: BlocConsumer<ForumCubit, ForumState>(
        listener: (context, state) {
          if (state.blocState == BlocState.Failed) {
            EasyLoading.showToast(translate(context, 'cant_load_data'));
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              KeyboardUtil.hideKeyboard(context);
              _checkFocus();
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: false,
                  pinned: true,
                  floating: true,
                  titleSpacing: 0,
                  leadingWidth: openSearch ? 0 : null,
                  leading: openSearch ? const SizedBox() : null,
                  title: openSearch
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 3),
                          child: TextFieldWidget(
                            focusNode: _focus,
                            validate: (p0) => null,
                            hint: translate(context, 'search'),
                            fillColor: colorF2F5FF,
                            filled: true,
                            focusedBorderColor: colorF2F5FF,
                            enabledBorderColor: colorF2F5FF,
                            controller: _searchController,
                            onChanged: (value) => _pagingController.refresh(),
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
                                    _pagingController.refresh();
                                  } else {
                                    KeyboardUtil.hideKeyboard(context);
                                    _checkFocus();
                                  }
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.solidCircleXmark,
                                  color: color6A6E83,
                                  size: dimensIcon() * .5,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Text(
                          translate(context, 'forum'),
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
                SliverToBoxAdapter(
                  child: Container(
                    color: white,
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 3,
                        vertical: dimensHeight()),
                    child: CreatePost(
                        textEdittingController: _textEdittingController),
                  ),
                ),
                PagedSliverList<int, PostResponse>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<PostResponse>(
                      itemBuilder: (context, item, index) {
                    return PostCard(
                      post: item,
                    );
                  }),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: dimensHeight() * 10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
