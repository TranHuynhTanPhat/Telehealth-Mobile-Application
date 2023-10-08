// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/main/health_info/components/export.dart';
import 'package:healthline/screen/ui_patient/main/health_info/components/list_record.dart';
import 'package:healthline/screen/ui_patient/main/health_info/components/update_subuser_input_dialog.dart';
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

  Future<void> showUpdateDialogInput(
      BuildContext context, UserResponse subUser) async {
    final result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => UpdateSubUserInputDialog(
              userResponse: subUser,
            ));
    if (result == true) {
      // ignore: use_build_context_synchronously
      context.read<SubUserCubit>().fetchMedicalRecord();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubUserCubit, SubUserState>(
      builder: (context, state) {
        if (state.subUsers.isNotEmpty && state.currentUser != -1) {
          context
              .read<HealthStatCubit>()
              .fetchStats(state.subUsers[state.currentUser].id!);
        }
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: dimensHeight() * 13),
            // width: dimensWidth()*7,
            height: dimensWidth() * 6,
            child: FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(dimensWidth() * 10)),
              icon: FaIcon(
                FontAwesomeIcons.userPen,
                color: white,
                size: dimensIcon() * .5,
              ),
              onPressed: () {
                if (state.subUsers.isNotEmpty && state.currentUser != -1) {
                  showUpdateDialogInput(
                      context, state.subUsers[state.currentUser]);
                }
              },
              extendedPadding: EdgeInsets.all(dimensWidth() * 2),
              label: Text(
                translate(context, 'update'),
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: white),
              ),
            ),
          ),
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  snap: false,
                  pinned: true,
                  floating: true,
                  expandedHeight: dimensHeight() * 17 * _animation.value +
                      dimensHeight() * 14,
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
                        _animation.value > 0
                            ? AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                color: white,
                                height: dimensHeight() * 15 * _animation.value,
                                width: double.maxFinite,
                                curve: Curves.fastEaseInToSlowEaseOut,
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(
                                    bottom: dimensHeight() * 2,
                                    top: dimensHeight()),
                                child: const ListSubUser(),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  bottom: AppBar(
                    title: Padding(
                      padding: EdgeInsets.symmetric(horizontal: dimensWidth()),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.currentUser != -1
                                      ? state.subUsers[state.currentUser]
                                              .fullName ??
                                          ''
                                      : '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  state.subUsers.isNotEmpty &&
                                          state.subUsers[state.currentUser]
                                                  .relationship !=
                                              null
                                      ? translate(
                                          context,
                                          state.subUsers[state.currentUser]
                                              .relationship!.name
                                              .toLowerCase())
                                      : '',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
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
            body: BlocBuilder<HealthStatCubit, HealthStatState>(
              builder: (context, state) {
                return ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      vertical: dimensHeight(), horizontal: dimensWidth() * 3),
                  children: [
                    InkWell(
                      splashColor: transparent,
                      highlightColor: transparent,
                      onTap: () => showDialogInput(context),
                      child: HeartRateCard(
                        healthStatResponse: state.stats.firstWhere(
                            (element) =>
                                element.type == TypeHealthStat.Heart_rate,
                            orElse: () => HealthStatResponse()),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            onTap: () async => await showDialogInput(context),
                            child: const BloodGroupCard(),
                          ),
                        ),
                        SizedBox(
                          width: dimensWidth() * 2,
                        ),
                        Expanded(
                          child: InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
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
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
