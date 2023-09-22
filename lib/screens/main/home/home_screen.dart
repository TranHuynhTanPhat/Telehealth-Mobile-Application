// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/cubits/cubit_home/home_cubit.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/bases/base_gridview.dart';
import 'package:healthline/screens/main/home/components/export.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';
import 'package:healthline/utils/translate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.press});
  final VoidCallback press;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  int _selected = 0;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'name': 'general_medical',
        'color': color009DC7,
        'icon': FontAwesomeIcons.briefcaseMedical,
      },
      {
        'name': 'doctor',
        'color': color1C6AA3,
        'icon': FontAwesomeIcons.userDoctor,
      },
      {
        'name': 'nurse',
        'color': colorDF9F1E,
        'icon': FontAwesomeIcons.userNurse,
      },
      {
        'name': 'vaccination',
        'color': color9D4B6C,
        'icon': FontAwesomeIcons.syringe,
      },
      {
        'name': 'corona',
        'color': secondary,
        'icon': FontAwesomeIcons.virusCovid,
      },
    ];
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
    // final List<Map<String, dynamic>> doctors = [
    //   {
    //     'dr': 'Dr. Phat',
    //     'description': 'Depression in Cho Ray Hopital',
    //     'rate': 4.5,
    //     'review': 250
    //   },
    //   {
    //     'dr': 'Dr. Nghia',
    //     'description': 'Cardiologist in AB Hopital',
    //     'rate': 4.5,
    //     'review': 250
    //   },
    //   {
    //     'dr': 'Dr. Truong',
    //     'description': 'General in BBC Hopital',
    //     'rate': 4.5,
    //     'review': 250
    //   },
    //   {
    //     'dr': 'Dr. Chien',
    //     'description': 'General in AFC Clinic',
    //     'rate': 4.5,
    //     'review': 250
    //   },
    //   {
    //     'dr': 'Dr. An',
    //     'description': 'Depression in Dr Hopital',
    //     'rate': 4.5,
    //     'review': 250
    //   },
    //   {
    //     'dr': 'Dr. Phong',
    //     'description': 'Cardiologist in XC Clinic',
    //     'rate': 4.5,
    //     'review': 250
    //   },
    // ];
    final List<String> categories = [
      'all',
      'general',
      'dentist',
      'cardiologist',
      'depression',
      'optician',
      'audiologist',
      'paediatric',
      'therapist'
    ];
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(dimensHeight() * 8),
            child: AppBar(
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
                    'Tran Huynh Tan Phat',
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
                    backgroundColor: secondary,
                    backgroundImage: AssetImage(DImages.placeholder),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: dimensWidth() * 3,
                    left: dimensWidth(),
                  ),
                  child: InkWell(
                    splashColor: transparent,
                    highlightColor: transparent,
                    onTap: () {
                    },
                    child: FaIcon(
                      FontAwesomeIcons.solidBell,
                      color: colorDF9F1E,
                      size: dimensIcon(),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: dimensHeight() * 4,
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
                  suffixIcon: IconButton(
                    onPressed: () {
                      UserRepository _userRepository = UserRepository();
                      _userRepository.refreshToken();
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: color6A6E83,
                      size: dimensIcon(),
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
              ListServices(services: services),
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
              ListCategories(
                categories: categories,
                selected: _selected,
                chooseCategory: (value) {
                  setState(() {
                    _selected = value;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: dimensWidth() * 2, horizontal: dimensWidth() * 3),
                child: BaseGridview(
                  children: state.doctors
                      .map(
                        (e) => DoctorCard(
                          doctor: e,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
