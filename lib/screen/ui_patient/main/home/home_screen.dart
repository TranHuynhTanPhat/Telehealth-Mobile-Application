// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/repositories/common_repository.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/bases/base_gridview.dart';
import 'package:healthline/screen/components/badge_notification.dart';
import 'package:healthline/screen/ui_patient/main/home/components/export.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';
import 'package:meilisearch/meilisearch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.press});
  final VoidCallback press;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  var _image;
  @override
  void initState() {
    _searchController = TextEditingController();
    _image = null;
    if (!mounted) return;
    context.read<DoctorCubit>().searchDoctor(
        key: '',
        pageKey: 1,
        searchQuery: const SearchQuery(sort: [
          'ratings:desc',
        ], limit: 6),
        callback: (doctors) {});
    context.read<ConsultationCubit>().fetchConsultation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicalRecordCubit, MedicalRecordState>(
      listener: (context, state) {
        if (state is FetchSubUserLoaded) {
          _image = null;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(dimensHeight() * 8),
          child: BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
            builder: (context, state) {
              if (state.subUsers.isNotEmpty) {
                int index = state.subUsers
                    .indexWhere((element) => element.isMainProfile!);

                if (index != -1 &&
                    state.subUsers[index].avatar != '' &&
                    state.subUsers[index].avatar != null &&
                    state.subUsers[index].avatar != 'default') {
                  String url = CloudinaryContext.cloudinary
                      .image(state.subUsers[index].avatar ?? '')
                      .toString();
                  NetworkImage provider = NetworkImage(url);
                  if (state is UpdateSubUserSuccessfully) {
                    provider.evict().then<void>((bool success) {
                      if (success) debugPrint('removed image!');
                    });
                  }

                  _image = _image ?? provider;
                } else {
                  _image = AssetImage(DImages.placeholder);
                }
              } else {
                _image = AssetImage(DImages.placeholder);
              }

              return AppBar(
                leadingWidth: dimensWidth() * 10,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      translate(context, 'greeting'),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: color6A6E83),
                    ),
                    Text(
                      state.subUsers.isNotEmpty
                          ? state.subUsers
                                  .firstWhere(
                                      (element) => element.isMainProfile!)
                                  .fullName ??
                              translate(context, 'i_am_healthline')
                          : translate(context, 'i_am_healthline'),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: color1F1F1F),
                    )
                  ],
                ),
                centerTitle: false,
                leading: Padding(
                  padding: EdgeInsets.only(
                    left: dimensWidth() * 3,
                  ),
                  child: InkWell(
                    splashColor: transparent,
                    highlightColor: transparent,
                    onTap: widget.press,
                    child: BlocBuilder<ApplicationUpdateCubit,
                        ApplicationUpdateState>(builder: (context, state) {
                      return badgeNotification(
                          child: CircleAvatar(
                            radius: dimensWidth() * 5,
                            backgroundImage: _image,
                            onBackgroundImageError: (exception, stackTrace) {
                              logPrint(exception);
                              setState(() {
                                _image = AssetImage(DImages.placeholder);
                              });
                            },
                          ),
                          isShow: state is UpdateAvailable,
                          color: Theme.of(context).colorScheme.error,
                          top: 3,
                          end: 3);
                    }),
                  ),
                ),
              );
            },
          ),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: dimensHeight() * 3,
                  left: dimensWidth() * 3,
                  right: dimensWidth() * 3),
              child: TextFieldWidget(
                onTap: () => Navigator.pushNamed(context, doctorName),
                validate: (p0) => null,
                hint: translate(context, 'search_doctors'),
                fillColor: colorF2F5FF,
                readOnly: true,
                filled: true,
                focusedBorderColor: colorF2F5FF,
                enabledBorderColor: colorF2F5FF,
                controller: _searchController,
                prefixIcon: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
                  onPressed: () {},
                  icon: InkWell(
                    splashColor: transparent,
                    highlightColor: transparent,
                    onTap: () => CommonRepository().refreshTokenDoctor(),
                    child: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: color6A6E83,
                      size: dimensIcon() * .8,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: dimensHeight() * 4,
                  left: dimensWidth() * 3,
                  right: dimensWidth() * 3),
              child: Text(
                translate(context, 'services'),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: color1F1F1F),
              ),
            ),
            const ListServices(),
            Padding(
              padding: EdgeInsets.only(
                  top: dimensHeight() * 3,
                  left: dimensWidth() * 3,
                  right: dimensWidth() * 3),
              child: InkWell(
                splashColor: transparent,
                highlightColor: transparent,
                onTap: () => Navigator.pushNamed(context, forumName),
                child: const ForumCard(),
              ),
            ),
            BlocBuilder<ConsultationCubit, ConsultationState>(
                builder: (BuildContext context, ConsultationState state) {
              if (state.consultations?.coming != null &&
                  state.consultations!.coming.isNotEmpty) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: dimensHeight() * 4,
                          left: dimensWidth() * 3,
                          right: dimensWidth() * 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            translate(context, 'upcoming_appointments'),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: color1F1F1F),
                          ),
                          // InkWell(
                          //   child: Text(
                          //     translate(context, 'see_all'),
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .bodyMedium
                          //         ?.copyWith(
                          //             color: primary,
                          //             fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: dimensWidth()),
                      child: UpcomingApointment(
                        appointments: state.consultations!.coming,
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
            Padding(
              padding: EdgeInsets.only(
                  top: dimensHeight() * 4,
                  left: dimensWidth() * 3,
                  right: dimensWidth() * 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translate(context, 'top_doctors'),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: color1F1F1F),
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, doctorName),
                    child: Text(
                      translate(context, 'see_all'),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<DoctorCubit, DoctorState>(
              builder: (context, state) {
                if (state.blocState == BlocState.Pending) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: dimensWidth() * 3),
                        child: const LinearProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: dimensWidth() * 2,
                            horizontal: dimensWidth() * 3),
                        child: BaseGridview(
                          radio: 0.8,
                          children: [buildShimmer(), buildShimmer()],
                        ),
                      )
                    ],
                  );
                } else if (state.blocState == BlocState.Successed) {
                  return SizedBox(
                    height: dimensHeight() * 30,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // reverse: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: dimensWidth() * 3,
                          vertical: dimensWidth() * 2),
                      children: [
                        ...state.doctors.getRange(0, 15).map(
                              (e) => DoctorCard(
                                doctor: e,
                              ),
                            ),
                      ],
                    ),
                  );

                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       vertical: dimensWidth() * 2,
                  //       horizontal: dimensWidth() * 3),
                  //   child: BaseGridview(radio: 0.8, children: [
                  //     ...state.doctors
                  //         .map(
                  //           (e) => DoctorCard(
                  //             doctor: e,
                  //           ),
                  //         )
                  //         .toList(),
                  //   ]),
                  // );
                } else {
                  return const SizedBox();
                }
              },
            ),
            BlocBuilder<DoctorCubit, DoctorState>(
              builder: (context, state) {
                if (state.recentDoctors.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: dimensHeight() * 4,
                            left: dimensWidth() * 3,
                            right: dimensWidth() * 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translate(context, 'recently'),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: color1F1F1F),
                            ),
                            // InkWell(
                            //   onTap: () =>
                            //       Navigator.pushNamed(context, doctorName),
                            //   child: Text(
                            //     translate(context, 'see_all'),
                            //     style: Theme.of(context)
                            //         .textTheme
                            //         .bodyMedium
                            //         ?.copyWith(
                            //           color: primary,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: dimensHeight() * 30,
                      //   child: ListView(
                      //     shrinkWrap: true,
                      //     scrollDirection: Axis.horizontal,
                      //     // reverse: true,
                      //     physics: const AlwaysScrollableScrollPhysics(),
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: dimensWidth() * 3,
                      //         vertical: dimensWidth() * 2),
                      //     children: [
                      //       ...state.recentDoctors.map(
                      //         (e) => DoctorCard(
                      //           doctor: e,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: dimensWidth() * 2,
                            horizontal: dimensWidth() * 3),
                        child: BaseGridview(radio: 0.8, reserve: true, children: [
                          ...state.recentDoctors
                              .map(
                                (e) => RecentDoctorCard(
                                  doctor: e,
                                ),
                              )
                              ,
                        ]),
                      )
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildShimmer() => Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(dimensWidth() * 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            spreadRadius: dimensWidth() * .4,
            blurRadius: dimensWidth() * .4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: ShimmerWidget.rectangular(
              height: double.maxFinite,
              shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(dimensWidth() * 2),
                topRight: Radius.circular(dimensWidth() * 2),
              )),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: dimensWidth(), horizontal: dimensWidth() * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ShimmerWidget.rectangular(
                      height: dimensHeight() * .5,
                      width: dimensWidth() * 14,
                    ),
                  ),
                  SizedBox(
                    height: dimensHeight(),
                  ),
                  Expanded(
                    flex: 2,
                    child: ShimmerWidget.rectangular(
                      height: double.maxFinite,
                      width: dimensWidth() * 10,
                    ),
                  ),
                  SizedBox(
                    height: dimensHeight(),
                  ),
                  const Expanded(
                    flex: 3,
                    child: ShimmerWidget.rectangular(height: double.maxFinite),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
