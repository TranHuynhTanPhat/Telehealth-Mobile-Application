// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/repository/common_repository.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/bases/base_gridview.dart';
import 'package:healthline/screen/ui_patient/main/home/components/export.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/translate.dart';

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> appointments = [
      {
        'dr': 'Dr. Phat',
        'description': 'depression',
        'color': colorCDDEFF,
        'icon': FontAwesomeIcons.briefcaseMedical,
        'date': DateTime.now(),
        'time': TimeOfDay.now()
      },
      {
        'dr': 'Dr. Truong',
        'description': 'cardiologist',
        'color': colorCDDEFF,
        'icon': FontAwesomeIcons.briefcaseMedical,
        'date': DateTime.now(),
        'time': TimeOfDay.now()
      },
      {
        'dr': 'Dr. Chien',
        'description': 'general_examination',
        'color': colorCDDEFF,
        'icon': FontAwesomeIcons.briefcaseMedical,
        'date': DateTime.now(),
        'time': TimeOfDay.now()
      },
      {
        'dr': 'Dr. Dang',
        'description': 'depression',
        'color': colorCDDEFF,
        'icon': FontAwesomeIcons.briefcaseMedical,
        'date': DateTime.now(),
        'time': TimeOfDay.now()
      },
    ];

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(dimensHeight() * 8),
            child: BlocBuilder<SubUserCubit, SubUserState>(
              buildWhen: (previous, current) => current is FetchUser,
              builder: (context, state) {
                if (state.subUsers.isNotEmpty) {
                  int index = state.subUsers
                      .indexWhere((element) => element.isMainProfile!);
                  if (index != -1) {
                    _image = _image ??
                        NetworkImage(
                          CloudinaryContext.cloudinary
                              .image(state.subUsers[index].avatar ?? '')
                              .toString(),
                        );
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
                                translate(context, 'undefine')
                            : translate(context, 'undefine'),
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
                      child: CircleAvatar(
                        backgroundImage: _image,
                        onBackgroundImageError: (exception, stackTrace) =>
                            setState(() {
                          _image = AssetImage(DImages.placeholder);
                        }),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: dimensHeight() * 3,
                    left: dimensWidth() * 3,
                    right: dimensWidth() * 3),
                child: TextFieldWidget(
                  validate: (p0) => null,
                  hint: translate(context, 'search_drugs_categories'),
                  fillColor: colorF2F5FF,
                  filled: true,
                  focusedBorderColor: colorF2F5FF,
                  enabledBorderColor: colorF2F5FF,
                  controller: _searchController,
                  prefixIcon: IconButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
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
                child: const EventCard(),
              ),
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
                    InkWell(
                      child: Text(
                        translate(context, 'see_all'),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: primary, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: dimensWidth()),
                child: UpcomingApointment(
                  appointments: appointments,
                ),
              ),
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
              if (state is HomeLoading)
                Column(
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
                )
              else
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: dimensWidth() * 2,
                      horizontal: dimensWidth() * 3),
                  child: BaseGridview(radio: 0.8, children: [
                    ...state.doctors
                        .map(
                          (e) => DoctorCard(
                            doctor: e,
                          ),
                        )
                        .toList(),
                  ]),
                )
            ],
          ),
        );
      },
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
            child: ShimmerWidget.retangular(
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
                    child: ShimmerWidget.retangular(
                      height: dimensHeight() * .5,
                      width: dimensWidth() * 14,
                    ),
                  ),
                  SizedBox(
                    height: dimensHeight(),
                  ),
                  Expanded(
                    flex: 2,
                    child: ShimmerWidget.retangular(
                      height: double.maxFinite,
                      width: dimensWidth() * 10,
                    ),
                  ),
                  SizedBox(
                    height: dimensHeight(),
                  ),
                  const Expanded(
                    flex: 3,
                    child: ShimmerWidget.retangular(height: double.maxFinite),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
