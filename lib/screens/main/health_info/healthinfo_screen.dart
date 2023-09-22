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
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
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
    {'name': 'Phat', 'id': "dsflkadsfjldks", 'image': DImages.placeholder},
    {'name': 'Truong', 'id': "dsflkadsfjldks", 'image': DImages.placeholder},
    {'name': 'Minh', 'id': "dsflkadsfjldks", 'image': DImages.placeholder},
    {
      'name': 'prescription',
      'id': "dsflkadsfjldks",
      'image': DImages.placeholder
    },
    {'name': 'Phat', 'id': "dsflkadsfjldks", 'image': DImages.placeholder},
    {'name': 'Truong', 'id': "dsflkadsfjldks", 'image': DImages.placeholder},
    {'name': 'Minh', 'id': "dsflkadsfjldks", 'image': DImages.placeholder},
  ];

  Future<void> showDialogInput(BuildContext context) async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => CustomDialog(formKey: _formKey));
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
                // backgroundColor: Colors.amber,
                centerTitle: false,
                snap: false,
                pinned: true,
                floating: true,
                expandedHeight:
                    dimensWidth() * 60 + dimensWidth() * 15 * _animation.value,

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
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 3),
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
                        duration: const Duration(milliseconds: 100),
                        color: white,
                        height: dimensHeight() * 15 * _animation.value,
                        width: double.maxFinite,
                        curve: Curves.linear,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: dimensHeight() * 2),
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: dimensWidth(),
                                    horizontal: dimensWidth()),
                                padding: EdgeInsets.symmetric(
                                  horizontal: dimensWidth(),
                                  vertical: dimensHeight() * .5,
                                ),
                                alignment: Alignment.center,
                                width: dimensWidth() * 5,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius:
                                      BorderRadius.circular(dimensWidth() * 2),
                                ),
                                child: const FaIcon(FontAwesomeIcons.circlePlus)),
                            ...users
                                .map(
                                  (e) => Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: dimensWidth(),
                                        horizontal: dimensWidth()),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: dimensWidth(),
                                      vertical: dimensHeight() * .5,
                                    ),
                                    alignment: Alignment.bottomCenter,
                                    width: dimensWidth() * 10,
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(
                                            dimensWidth() * 2),
                                        image: DecorationImage(
                                            image:
                                                AssetImage(DImages.placeholder),
                                            fit: BoxFit.cover)),
                                    child: Text(
                                      e['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                        child: InkWell(
                          onTap: () => showDialogInput(context),
                          child: const HeartRateCard(),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async =>
                                    await showDialogInput(context),
                                child: const BloodGroupCard(),
                              ),
                            ),
                            SizedBox(
                              width: dimensWidth() * 2,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () async =>
                                    await showDialogInput(context),
                                child: const BMICard(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottom: AppBar(
                  title: Text(
                    "Report",
                    style: Theme.of(context).textTheme.titleLarge,
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
            children: reports
                .map((e) => ReportCard(
                      object: e,
                    ))
                .toList(),
          )),
    );
  }
}
