// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/main/health_info/components/export.dart';
import 'package:healthline/screens/main/health_info/components/list_record.dart';
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
  late Animation<double> _animationIC;

  late bool _showUsers;

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
    {
      'name': 'Minh',
      'id': "dsflkadsfjldks",
      'image': DImages.placeholder,
      'role': 'con'
    },
  ];

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationIC =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _showUsers = false;
    super.initState();
  }

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
              snap: false,
              pinned: true,
              floating: true,
              expandedHeight:
                  dimensHeight() * 15 * _animation.value + dimensHeight() * 15,
              // collapsedHeight: dimensHeight()*20,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                expandedTitleScale: 1,
                background: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: dimensWidth() * 3,
                        right: dimensWidth() * 3,
                        top: dimensHeight() * 1.5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              translate(context, 'patient_records'),
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
                            splashColor: transparent,
                            highlightColor: transparent,
                            child: AnimatedIcon(
                              icon: AnimatedIcons.menu_close,
                              progress: _animationIC,
                              color: color1F1F1F,
                              size: dimensIcon(),
                            ),
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
              const ListRecord()
            ]),
      ),
    );
  }
}
