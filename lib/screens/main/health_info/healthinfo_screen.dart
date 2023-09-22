// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/main/health_info/components/export.dart';
import 'package:healthline/utils/translate.dart';

class HealthInfoScreen extends StatefulWidget {
  const HealthInfoScreen({super.key});

  @override
  State<HealthInfoScreen> createState() => _HealthInfoScreenState();
}

class _HealthInfoScreenState extends State<HealthInfoScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _animation;

  late bool _showUsers;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
    _showUsers = false;
    super.initState();
  }

  final List<Map<String, dynamic>> reports = [
    {
      'name': 'head_circumference',
      'color': colorDF9F1E,
      'icon': FontAwesomeIcons.ruler,
      'unit': 'cm'
    },
    {
      'name': 'vaccination',
      'color': color9D4B6C,
      'icon': FontAwesomeIcons.syringe,
      'unit': 'types'
    },
    {
      'name': 'medical_record',
      'color': color009DC7,
      'icon': FontAwesomeIcons.solidFolder,
      'unit': 'records'
    },
    {
      'name': 'prescription',
      'color': color1C6AA3,
      'icon': FontAwesomeIcons.prescription,
      'unit': 'prescriptions'
    },
  ];
  final List<Map<String, dynamic>> users = [
    {
      'name': 'Phat',
      'id': "dsflkadsfjldks",
      'image': DImages.placeholder,
      'role': 'con'
    },
    {
      'name': 'Truong',
      'id': "dsflkadsfjldks",
      'image': DImages.placeholder,
      'role': 'ba/mẹ'
    },
    {
      'name': 'Minh',
      'id': "dsflkadsfjldks",
      'image': DImages.placeholder,
      'role': 'con'
    },
  ];

  Future<void> showDialogInput(BuildContext context) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => HealthInforInputDialog(formKey: _formKey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: false,
              snap: false,
              pinned: true,
              floating: true,
              expandedHeight:
                  dimensWidth() * 15 * _animation.value + dimensWidth() * 12,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                expandedTitleScale: 1,
                background: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: dimensWidth() * 2),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                translate(context, 'personal_health_records'),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                        color: color1F1F1F,
                                        fontWeight: FontWeight.w900),
                              ),
                            ),
                            InkWell(
                              child: const FaIcon(FontAwesomeIcons.rotate),
                              onTap: () {
                                if (_showUsers) {
                                  _animationController.reverse();
                                  _showUsers = false;
                                } else {
                                  _animationController.forward();
                                  _showUsers = true;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      color: white,
                      height: dimensHeight() * 15 * _animation.value,
                      width: double.maxFinite,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: dimensHeight() * 2),
                      child: ListSubUser(users: users),
                    ),
                  ],
                ),
              ),
              bottom: AppBar(
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: dimensWidth()),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: dimensWidth() * 3,
                        backgroundColor: primary,
                        backgroundImage: AssetImage(DImages.placeholder),
                        onBackgroundImageError: (exception, stackTrace) =>
                            AssetImage(DImages.placeholder),
                      ),
                      SizedBox(
                        width: dimensWidth(),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              users.first['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              users.first['role'],
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                centerTitle: false,
              ),
            )
          ];
        },
        body: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                vertical: dimensHeight(), horizontal: dimensWidth() * 3),
            children: [
              InkWell(
                onTap: () => showDialogInput(context),
                child: const HeartRateCard(),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async => await showDialogInput(context),
                      child: const BloodGroupCard(),
                    ),
                  ),
                  SizedBox(
                    width: dimensWidth() * 2,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () async => await showDialogInput(context),
                      child: const BMICard(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: dimensHeight() * 2,
              ),
              ...reports
                  .map(
                    (e) => ReportCard(
                      object: e,
                    ),
                  )
                  .toList(),
            ]),
      ),
    );
  }
}
