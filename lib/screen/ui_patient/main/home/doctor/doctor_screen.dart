import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_doctor/doctor_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/translate.dart';
import 'package:meilisearch/meilisearch.dart';

import 'components/export.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    if (!mounted) return;
    context
        .read<DoctorCubit>()
        .searchDoctor(key: '', searchQuery: const SearchQuery(limit: 20));
    super.initState();
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
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
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
                prefixIcon: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: color6A6E83,
                    size: dimensIcon() * .8,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
              child: const ListCategories(),
            ),
            BlocBuilder<DoctorCubit, DoctorState>(builder: (context, state) {
              if (state.blocState == BlocState.Pending &&
                  state.doctors.isEmpty) {
                return buildShimmer();
              } else if (state.blocState == BlocState.Successed) {
                return Column(
                  children: state.doctors
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.only(left: dimensWidth() * 3),
                          child: DoctorCard(doctor: e),
                        ),
                      )
                      .toList(),
                );
              } else {
                return const SizedBox();
              }
            }),
          ],
        )
        // ],

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
