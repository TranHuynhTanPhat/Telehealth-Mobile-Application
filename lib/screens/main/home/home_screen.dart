import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/main/home/components/event_title.dart';
import 'package:healthline/screens/main/home/components/list_services.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.press});
  final VoidCallback press;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'name': 'General medical',
        'color': color009DC7,
        'icon': FontAwesomeIcons.briefcaseMedical,
      },
      {
        'name': 'Doctor',
        'color': color1C6AA3,
        'icon': FontAwesomeIcons.userDoctor,
      },
      {
        'name': 'Nurse',
        'color': colorDF9F1E,
        'icon': FontAwesomeIcons.userNurse,
      },
      {
        'name': 'Vaccination',
        'color': color9D4B6C,
        'icon': FontAwesomeIcons.syringe,
      },
      {
        'name': 'Corona',
        'color': secondary,
        'icon': FontAwesomeIcons.virusCovid,
      },
    ];
    final List<Map<String, dynamic>> appointments = [
      {
        'dr': 'Dr. Phat',
        'description': 'Depression',
        'color': colorCDDEFF,
        'icon': FontAwesomeIcons.briefcaseMedical,
        'date': DateTime.now(),
        'time': TimeOfDay.now()
      },
      {
        'dr': 'Dr. Truong',
        'description': 'Cardiologist',
        'color': colorCDDEFF,
        'icon': FontAwesomeIcons.briefcaseMedical,
        'date': DateTime.now(),
        'time': TimeOfDay.now()
      },
      {
        'dr': 'Dr. Chien',
        'description': 'General examination',
        'color': colorCDDEFF,
        'icon': FontAwesomeIcons.briefcaseMedical,
        'date': DateTime.now(),
        'time': TimeOfDay.now()
      },
      {
        'dr': 'Dr. Dang',
        'description': 'Depression',
        'color': colorCDDEFF,
        'icon': FontAwesomeIcons.briefcaseMedical,
        'date': DateTime.now(),
        'time': TimeOfDay.now()
      },
    ];
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
                'Hello!',
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
                    HapticFeedback.lightImpact();
                  },
                  child: FaIcon(
                    FontAwesomeIcons.bell,
                    color: color1F1F1F,
                    size: dimensIcon(),
                  )),
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
              hint: 'Search drugs, category',
              fillColor: colorF2F5FF,
              filled: true,
              focusedBorderColor: colorF2F5FF,
              enabledBorderColor: colorF2F5FF,
              controller: _searchController,
              suffixIcon: IconButton(
                onPressed: null,
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
              "Services",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: color1F1F1F, fontWeight: FontWeight.w100),
            ),
          ),
          ListServices(services: services),
          Padding(
            padding: EdgeInsets.only(
                top: dimensHeight() * 3,
                left: dimensWidth() * 3,
                right: dimensWidth() * 3),
            child: const EventTitle(),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: dimensHeight() * 4,
                left: dimensWidth() * 3,
                right: dimensWidth() * 3),
            child: Text(
              "Upcoming Appointments",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: color1F1F1F, fontWeight: FontWeight.w100),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: dimensWidth()),
            child: CarouselSlider(
                items: appointments
                    .map(
                      (e) => Container(
                        // width: dimensWidth() * 40,
                        // height: dimensWidth() * 10,
                        padding: EdgeInsets.all(dimensWidth() * 2),
                        decoration: BoxDecoration(
                            color: colorCDDEFF,
                            borderRadius:
                                BorderRadius.circular(dimensWidth() * 2.5)),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: white.withOpacity(.5),
                                      borderRadius: BorderRadius.circular(
                                        dimensWidth() * 1.5,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e['date'].month.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge
                                                ?.copyWith(
                                                    color: secondary,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            e['date'].day.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                                    color: secondary,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 7,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: dimensWidth() * 2,
                                        top: dimensWidth(),
                                        bottom: dimensWidth() * 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e['time']
                                                .format(context)
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(color: secondary),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            e['dr'],
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                    color: secondary,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            e['description'],
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(color: secondary),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ]),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 3,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale)),
          )
        ],
      ),
    );
  }
}




// Padding(
//         padding: EdgeInsets.symmetric(
//             vertical: dimensHeight() * 2, horizontal: dimensWidth() * 3),
//         child: 