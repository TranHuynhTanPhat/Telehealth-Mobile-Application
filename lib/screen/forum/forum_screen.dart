import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meilisearch/meilisearch.dart';

import 'package:healthline/bloc/cubits/cubit_forum/forum_cubit.dart';
import 'package:healthline/data/api/models/responses/post_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/forum/components/exports.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/linear_progress_indicator.dart';
import 'package:healthline/utils/translate.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  late TextEditingController _searchController;

  final FocusNode _focus = FocusNode();

  bool openSearch = false;

  static const _pageSize = 20;

  final PagingController<int, PostResponse> _pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 5);

  @override
  void initState() {
    _searchController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      if (_searchController.text.trim().isEmpty) {
        // print(pageKey);
        context.read<ForumCubit>().fetchPostPage(
            pageKey: pageKey + 1,
            limit: 20,
            callback: (posts) => updateData(posts: posts, pageKey: pageKey));
      } else {
        context.read<ForumCubit>().searchPost(
              key: _searchController.text.trim(),
              searchQuery: SearchQuery(
                  limit: 20,
                  attributesToSearchOn: ['description', 'user.full_name'],
                  sort: ['updatedAt:desc'],
                  page: pageKey + 1),
              pageKey: pageKey,
              callback: (news) => updateData(posts: news, pageKey: pageKey),
            );
      }
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

  void updateData({required List<PostResponse> posts, required int pageKey}) {
    final isLastPage = posts.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(posts);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(posts, nextPageKey);
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
          if (state is FetchCommentState) {
            if (state.blocState == BlocState.Failed) {
              EasyLoading.showToast(translate(context, 'cant_load_data'));
            }
          } else if (state is EditPostState) {
            if (state.blocState == BlocState.Successed) {
              EasyLoading.showToast(translate(context, 'successfully'));
              _pagingController.refresh();
            } else if (state.blocState == BlocState.Failed) {
              EasyLoading.showToast(translate(context, state.error));
            }
          } else if (state is DeletePostState) {
            if (state.blocState == BlocState.Successed) {
              EasyLoading.showToast(translate(context, 'successfully'));
            } else if (state.blocState == BlocState.Pending) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state.blocState == BlocState.Failed) {
              EasyLoading.showToast(translate(context, state.error));
            }
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is DeletePostState &&
                state.blocState == BlocState.Pending,
            child: GestureDetector(
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
                              onChanged: (value) {
                                Future.delayed(const Duration(seconds: 1), () {
                                  if (value == _searchController.text.trim()) {
                                    _pagingController.refresh();
                                  }
                                });
                              },
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
                  if (state is EditPostState &&
                      state.blocState == BlocState.Pending)
                    SliverToBoxAdapter(
                      child: Container(
                        color: white,
                        child: const LinearProgressIndicatorLoading(),
                      ),
                    ),
                  if (!openSearch)
                    SliverToBoxAdapter(
                      child: Container(
                        color: white,
                        padding: EdgeInsets.symmetric(
                            horizontal: dimensWidth() * 3,
                            vertical: dimensHeight()),
                        child: CreatePost(
                          pagingController: _pagingController,
                        ),
                      ),
                    ),
                  PagedSliverList<int, PostResponse>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<PostResponse>(
                        itemBuilder: (context, item, index) {
                      return PostCard(
                        post: item,
                        pagingController: _pagingController,
                      );
                    }),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: dimensHeight() * 10,
                      decoration:
                          BoxDecoration(color: secondary.withOpacity(.02)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
