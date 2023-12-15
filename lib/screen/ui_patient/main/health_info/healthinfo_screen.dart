// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_patient/main/health_info/components/export.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/utils/translate.dart';

class HealthInfoScreen extends StatefulWidget {
  const HealthInfoScreen({super.key});

  @override
  State<HealthInfoScreen> createState() => _HealthInfoScreenState();
}

class _HealthInfoScreenState extends State<HealthInfoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _animationIC;

  late bool _showUsers;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationIC =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _showUsers = false;
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicalRecordCubit, MedicalRecordState>(
      listener: (context, state) {
        if (state is UpdateCurrentId) {
          bool checkCurrentId = state.subUsers
              .where((element) => element.id == state.currentId)
              .toList()
              .isNotEmpty;
          if (state.subUsers.isNotEmpty && checkCurrentId) {
            context.read<MedicalRecordCubit>().fetchStats();
          }
        } else if (state is HealthStatLoaded) {
          EasyLoading.dismiss();
        } else if (state is HealthStatError) {
          EasyLoading.showToast(translate(context, state.message));
        } else if (state is AddSubUserSuccessfully ||
            state is UpdateSubUserSuccessfully ||
            state is DeleteSubUserSuccessfully) {
          context.read<MedicalRecordCubit>().fetchMedicalRecord();
        }
      },
      child: BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
        builder: (context, state) {
          num heartRate = state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Heart_rate,
                      orElse: () => HealthStatResponse())
                  .value ??
              0;

          num? bloodIndex = state.stats
              .firstWhere(
                  (element) => element.type == TypeHealthStat.Blood_group,
                  orElse: () => HealthStatResponse())
              .value;
          String bloodGroup = bloodIndex == 0
              ? 'A'
              : bloodIndex == 1
                  ? 'B'
                  : bloodIndex == 2
                      ? 'O'
                      : bloodIndex == 3
                          ? 'AB'
                          : '--';
          num temperature = state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Temperature,
                      orElse: () => HealthStatResponse())
                  .value ??
              0;
          num weight = state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Weight,
                      orElse: () => HealthStatResponse())
                  .value ??
              0;
          double height = (state.stats
                      .firstWhere(
                          (element) => element.type == TypeHealthStat.Height,
                          orElse: () => HealthStatResponse())
                      .value ??
                  0) /
              100;
          double bmi =
              (height == 0 && weight == 0) ? 0 : weight / (height * height);
          String? fullName = state.subUsers
              .firstWhere((element) => element.id == state.currentId,
                  orElse: () => UserResponse())
              .fullName;
          String? relationship = state.subUsers
              .firstWhere((element) => element.id == state.currentId,
                  orElse: () => UserResponse())
              .relationship
              ?.name;
          return AbsorbPointer(
            absorbing: state is MedicalRecordLoadingState,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: white,
              appBar: AppBar(
                centerTitle: false,
                title: Padding(
                  padding: EdgeInsets.only(left: dimensWidth()),
                  child: Text(
                    translate(context, 'patient_records'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: color1F1F1F, fontWeight: FontWeight.w900),
                  ),
                ),
                actions: [
                  state.subUsers.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(right: dimensWidth() * 2),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(180),
                            child: Padding(
                              padding: EdgeInsets.all(dimensWidth()),
                              child: AnimatedIcon(
                                icon: AnimatedIcons.menu_close,
                                progress: _animationIC,
                                color: color1F1F1F,
                                size: dimensIcon(),
                              ),
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
                        )
                      : const SizedBox(),
                ],
              ),
              body: ListView(
                shrinkWrap: false,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                    left: dimensWidth() * 3,
                    right: dimensWidth() * 3,
                    top: dimensHeight(),
                    bottom: dimensHeight() * 10),
                children: [
                  _animation.value > 0
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          color: white,
                          height: 130 * _animation.value,
                          width: double.maxFinite,
                          curve: Curves.fastEaseInToSlowEaseOut,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(
                              bottom: dimensHeight() * 3, top: dimensHeight()),
                          child: const ListSubUser(),
                        )
                      : const SizedBox(),
                  Container(
                    margin: EdgeInsets.only(bottom: dimensWidth() * 2),
                    padding: EdgeInsets.symmetric(
                        vertical: dimensHeight(),
                        horizontal: dimensWidth() * 1.5),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      border: Border.all(color: color1F1F1F.withOpacity(.1)),
                      borderRadius: BorderRadius.circular(dimensWidth() * 1.8),
                    ),
                    child: state is! HealthStatLoading &&
                            state is! FetchSubUserLoading
                        ? state.subUsers.isNotEmpty
                            ? Stack(
                                children: [
                                  HealthStat(
                                      fullName: fullName,
                                      relationship: relationship,
                                      heartRate: heartRate,
                                      bloodGroup: bloodGroup,
                                      height: height,
                                      weight: weight,
                                      bmi: bmi,
                                      temperature: temperature),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(
                                      splashColor: transparent,
                                      highlightColor: transparent,
                                      onTap: () {
                                        // if (state.subUsers.isNotEmpty) {
                                        Navigator.pushNamed(
                                                context, updateHealthStatName)
                                            .then((value) {
                                          if (value == true) {
                                            context
                                                .read<MedicalRecordCubit>()
                                                .fetchStats();
                                          }
                                        });
                                        // } else {
                                        //   EasyLoading.showToast(
                                        //       translate(context, 'cant_load_data'));
                                        // }
                                      },
                                      child: FaIcon(
                                        FontAwesomeIcons.solidPenToSquare,
                                        size: dimensIcon() * .8,
                                        color: black26,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                  translate(context, 'cant_load_data'),
                                ),
                              )
                        : const HealthStatShimmer(),
                  ),
                  state is! HealthStatLoading &&
                          state is! FetchSubUserLoading &&
                          state.subUsers.isNotEmpty
                      ? const ListRecord()
                      : const SizedBox(),
                ],
              ),
            ),
            // ),
          );
        },
      ),
    );
  }
}

class HealthStatShimmer extends StatelessWidget {
  const HealthStatShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensWidth() * 2,
            width: dimensWidth() * 30,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensWidth() * 2,
            width: dimensWidth() * 15,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensWidth() * 2,
            width: dimensWidth() * 20,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensWidth() * 2,
            width: dimensWidth() * 21,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensWidth() * 2,
            width: dimensWidth() * 19,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensWidth() * 2,
            width: dimensWidth() * 23,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensWidth() * 2,
            width: dimensWidth() * 20,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensWidth() * 2,
            width: dimensWidth() * 30,
          ),
        ),
      ],
    );
  }
}
