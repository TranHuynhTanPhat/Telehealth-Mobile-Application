import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_doctor/doctor_cubit.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
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
  String? filterExp;

  static const _pageSize = 20;

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
          key: _searchController.text,
          searchQuery: SearchQuery(
              limit: 20,
              attributesToSearchOn: ['full_name'],
              filter:
                  filterExp != null ? 'specialty = $filterExp' : filterExp),
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
    // if (!mounted) return;
    // context
    //     .read<DoctorCubit>()
    //     .searchDoctor(key: '', searchQuery: const SearchQuery(limit: 20));
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translate(context, 'list_of_doctors'),
        ),
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(builder: (context, state) {
        if (state is SearchDoctorState) {
          if (state.blocState == BlocState.Successed) {
            final isLastPage = state.doctors.length < _pageSize;
            if (isLastPage) {
              _pagingController.appendLastPage(state.doctors);
            } else {
              final nextPageKey = state.pageKey + state.doctors.length;
              _pagingController.appendPage(state.doctors, nextPageKey);
            }
          }
          if (state.blocState == BlocState.Failed) {
            _pagingController.error = state.error;
          }
        }
        return GestureDetector(
          onTap: () => KeyboardUtil.hideKeyboard(context),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: dimensHeight() * 1,
                      right: dimensWidth() * 3,
                      left: dimensWidth() * 3),
                  child: TextFieldWidget(
                    validate: (p0) => null,
                    hint: translate(context, 'search_doctors'),
                    fillColor: colorF2F5FF,
                    filled: true,
                    focusedBorderColor: colorF2F5FF,
                    enabledBorderColor: colorF2F5FF,
                    controller: _searchController,
                    onChanged: (value) => {
                      _pagingController.refresh(),
                    },
                    prefixIcon: IconButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: color6A6E83,
                        size: dimensIcon() * .8,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
                  child: ListCategories(callback: changeFilterExp,),
                ),
              ),
              PagedSliverList<int, DoctorResponse>(
                // prototypeItem: buildShimmer(),
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<DoctorResponse>(
                    itemBuilder: (context, item, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensHeight() * 2),
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
    );
  }
}

Widget buildShimmer() => Padding(
      padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(dimensWidth() * 2),
              margin: EdgeInsets.symmetric(vertical: dimensHeight() * 1),
              decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.1),
                    spreadRadius: dimensWidth() * .4,
                    blurRadius: dimensWidth() * .4,
                  ),
                ],
                borderRadius: BorderRadius.circular(dimensWidth() * 3),
                border:
                    Border.all(color: colorA8B1CE.withOpacity(.2), width: 2),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ShimmerWidget.circular(
                                width: dimensWidth() * 9,
                                height: dimensWidth() * 9),
                            SizedBox(
                              width: dimensWidth() * 2.5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShimmerWidget.rectangular(
                                      height: dimensHeight() * 3),
                                  SizedBox(
                                    height: dimensHeight() * .5,
                                  ),
                                  ShimmerWidget.rectangular(
                                      height: dimensHeight() * 1.5),
                                  SizedBox(
                                    height: dimensHeight() * .5,
                                  ),
                                  ShimmerWidget.rectangular(
                                    height: dimensHeight() * 3.5,
                                    width: dimensWidth() * 17,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: dimensHeight(),
                        ),
                        ShimmerWidget.rectangular(
                          height: dimensHeight() * 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
