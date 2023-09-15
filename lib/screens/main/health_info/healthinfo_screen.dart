import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/main/health_info/components/export.dart';

class HealthInfoScreen extends StatefulWidget {
  const HealthInfoScreen({super.key});

  @override
  State<HealthInfoScreen> createState() => _HealthInfoScreenState();
}

class _HealthInfoScreenState extends State<HealthInfoScreen> {
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
                expandedHeight: dimensWidth() * 60,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  expandedTitleScale: 1,
                  background: ListView(
                    padding: EdgeInsets.symmetric(
                        vertical: dimensHeight() * 10,
                        horizontal: dimensWidth() * 3),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: dimensWidth() * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate("health_information"),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                      color: color1F1F1F,
                                      fontWeight: FontWeight.w900),
                            ),
                            CircleAvatar(
                              radius: dimensImage()*3,
                              backgroundImage: AssetImage(DImages.placeholder),
                              onBackgroundImageError: (exception, stackTrace) =>
                                  AssetImage(DImages.placeholder),
                            )
                          ],
                        ),
                      ),
                      const HeartRateCard(),
                      Row(
                        children: [
                          const Expanded(
                            child: BloodGroupCard(),
                          ),
                          SizedBox(
                            width: dimensWidth() * 2,
                          ),
                          const Expanded(
                            child: BMICard(),
                          ),
                        ],
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
