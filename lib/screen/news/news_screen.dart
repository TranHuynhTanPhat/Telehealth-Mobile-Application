import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_news/news_cubit.dart';
import 'package:healthline/data/api/models/responses/news_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/news/components/export.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meilisearch/meilisearch.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late TextEditingController _searchController;

  final FocusNode _focus = FocusNode();

  bool openSearch = false;

  static const _pageSize = 20;

  final PagingController<int, NewsResponse> _pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 5);

  @override
  void initState() {
    _searchController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<NewsCubit>().searchNews(
          key: _searchController.text,
          searchQuery: const SearchQuery(
            limit: 20,
            attributesToSearchOn: ['title', 'content'],
            sort: ['updated_at:desc']
          ),
          pageKey: pageKey);
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
                        onChanged: (value) => _pagingController.refresh(),
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
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is SearchNewsState) {
              if (state.blocState == BlocState.Successed) {
                final isLastPage = state.news.length < _pageSize;
                if (isLastPage) {
                  _pagingController.appendLastPage(state.news);
                } else {
                  final nextPageKey = state.pageKey + state.news.length;
                  _pagingController.appendPage(state.news, nextPageKey);
                }
              }
              if (state.blocState == BlocState.Failed) {
                _pagingController.error = state.error;
              }
            }
            return GestureDetector(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
                _checkFocus();
              },
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                // padding: EdgeInsets.symmetric(
                //   horizontal: dimensWidth() * 3,
                //   vertical: dimensHeight(),
                // ),
                slivers: [
                  // MainNewsPost(),
                  // NewsPost(),
                  // NewsPost(),
                  // NewsPost(),
                  // NewsPost(),
                  // NewsPost(),
                  // NewsPost(),
                  // NewsPost(),
                  // NewsPost(),
                  // NewsPost(),
                  // NewsPost(),
                  // NewsPost(),
                  PagedSliverList<int, NewsResponse>(
                    // prototypeItem: buildShimmer(),
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<NewsResponse>(
                        itemBuilder: (context, item, index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensHeight() * 3),
                          child: MainNewsPost(
                            news: item,
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensHeight() * 3),
                          child: NewsPost(
                            news: item,
                          ),
                        );
                      }
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
