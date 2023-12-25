import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_doctor/doctor_cubit.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:meilisearch/meilisearch.dart';

import 'components/export.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late TextEditingController _searchController;
  final FocusNode _focus = FocusNode();

  String? filterExp;

  static const _pageSize = 20;
  bool openSearch = false;

  final PagingController<int, DoctorResponse> _pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 5);

  void changeFilterExp(String value) {
    if (value == 'all') {
      filterExp = null;
    } else {
      filterExp = value;
    }
    _pagingController.refresh();
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<DoctorCubit>().searchDoctor(
            key: _searchController.text.trim(),
            searchQuery: SearchQuery(
                limit: 20,
                attributesToSearchOn: ['full_name'],
                sort: ['full_name:asc'],
                filter:
                    filterExp != null ? 'specialty = $filterExp' : filterExp,
                page: pageKey + 1),
            pageKey: pageKey,
            callback: (doctors) =>
                updateDate(doctors: doctors, pageKey: pageKey),
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

  void updateDate(
      {required List<DoctorResponse> doctors, required int pageKey}) {
    final isLastPage = doctors.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(doctors);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(doctors, nextPageKey);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _focus.removeListener(_checkFocus);
    _focus.dispose();
    super.dispose();
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
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        context.read<DoctorCubit>().searchDoctor(
            key: '',
            pageKey: 1,
            searchQuery: const SearchQuery(
                sort: ['ratings:desc', 'full_name:asc'], limit: 6),
            callback: (doctors) {});
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        extendBody: true,
        body: BlocListener<ConsultationCubit, ConsultationState>(
          listener: (context, state) {
            if (state is FetchTimelineState) {
              if (state.blocState == BlocState.Pending) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else if (state.blocState == BlocState.Successed) {
                EasyLoading.dismiss();
              } else if (state.blocState == BlocState.Failed) {
                EasyLoading.showToast(translate(context, state.error));
              }
            }
          },
          child:
              BlocBuilder<DoctorCubit, DoctorState>(builder: (context, state) {
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
                              hint: translate(context, 'search_doctors'),
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
                            translate(context, 'doctor'),
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
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: dimensHeight() * 2,
                          left: dimensWidth() * 3,
                          right: dimensWidth() * 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: dimensWidth()),
                            child: FaIcon(
                              FontAwesomeIcons.filter,
                              size: dimensIcon() * .5,
                            ),
                          ),
                          Text(
                            translate(context, 'filters'),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: dimensHeight() * 2),
                      child: ListCategories(
                        callback: changeFilterExp,
                      ),
                    ),
                  ),
                  PagedSliverList<int, DoctorResponse>(
                    // prototypeItem: buildShimmer(),
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<DoctorResponse>(
                        itemBuilder: (context, item, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: dimensWidth() * 2,
                            vertical: dimensHeight()),
                        child: DoctorCard(
                          doctor: item,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

// Widget buildShimmer() => Padding(
//       padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(dimensWidth() * 2),
//               margin: EdgeInsets.symmetric(vertical: dimensHeight() * 1),
//               decoration: BoxDecoration(
//                 color: white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(.1),
//                     spreadRadius: dimensWidth() * .4,
//                     blurRadius: dimensWidth() * .4,
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(dimensWidth() * 3),
//                 border:
//                     Border.all(color: colorA8B1CE.withOpacity(.2), width: 2),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             ShimmerWidget.circular(
//                                 width: dimensWidth() * 9,
//                                 height: dimensWidth() * 9),
//                             SizedBox(
//                               width: dimensWidth() * 2.5,
//                             ),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ShimmerWidget.rectangular(
//                                       height: dimensHeight() * 3),
//                                   SizedBox(
//                                     height: dimensHeight() * .5,
//                                   ),
//                                   ShimmerWidget.rectangular(
//                                       height: dimensHeight() * 1.5),
//                                   SizedBox(
//                                     height: dimensHeight() * .5,
//                                   ),
//                                   ShimmerWidget.rectangular(
//                                     height: dimensHeight() * 3.5,
//                                     width: dimensWidth() * 17,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: dimensHeight(),
//                         ),
//                         ShimmerWidget.rectangular(
//                           height: dimensHeight() * 10,
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
