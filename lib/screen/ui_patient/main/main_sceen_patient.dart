// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_document/open_document.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/components/badge_notification.dart';
import 'package:healthline/screen/components/side_menu.dart';
import 'package:healthline/screen/schedule/schedule_screen.dart';
import 'package:healthline/screen/ui_patient/main/health_info/healthinfo_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/home_screen.dart';
import 'package:healthline/screen/ui_patient/main/notification/notification_screen.dart';
import 'package:healthline/utils/alice_inspector.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class MainScreenPatient extends StatefulWidget {
  const MainScreenPatient({super.key});

  @override
  State<MainScreenPatient> createState() => _MainScreenPatientState();
}

class _MainScreenPatientState extends State<MainScreenPatient>
    with SingleTickerProviderStateMixin {
  var _currentIndex = 0;
  bool exit = false;
  double animationValue = 0;

  bool isSideMenuClosed = true;

  DateTime? currentBackPressTime;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  // late Animation<double> hideAnimation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      EasyLoading.dismiss();
      await showDialog<String>(
        context: context,
        barrierColor: black26,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          elevation: 0,
          content: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: white),
                      // padding: EdgeInsets.all(dimensWidth()/2),
                      height: dimensIcon(),
                      width: dimensIcon(),
                      alignment: Alignment.center,
                      child: FaIcon(
                        FontAwesomeIcons.xmark,
                        size: dimensIcon() / 2,
                      ),
                    )),
              ),
              SizedBox(
                height: dimensHeight() * 40,
                child: Center(child: Image.asset(DImages.placeholder)),
              ),
            ],
          ),
        ),
      );
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    if (!mounted) return;
    context.read<MedicalRecordCubit>().fetchMedicalRecord();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _pageDetail = [
      {
        "page": HomeScreen(
          press: () {
            if (isSideMenuClosed) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            KeyboardUtil.hideKeyboard(context);

            setState(() {
              isSideMenuClosed = !isSideMenuClosed;
            });
          },
        ),
        "title": "home_page",
        "icon": FontAwesomeIcons.heartPulse,
        "badge": false
      },
      {
        "page": const ScheduleScreen(),
        "title": "schedule",
        "icon": FontAwesomeIcons.calendar,
        "badge": false
      },
      {
        "page": const NotificationScreen(),
        "title": "notification",
        "icon": FontAwesomeIcons.solidBell,
        "badge": false
      },
      {
        "page": const HealthInfoScreen(),
        "title": "health_info",
        "icon": FontAwesomeIcons.bookMedical,
        "badge": false
      },
    ];

    void onWillPop(bool didPop) {
      if (didPop) return;

      EasyLoading.showToast(translate(context, 'click_again_to_exit'));
      setState(() {
        exit = true;
      });
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          exit = false;
        });
      });
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<VaccineRecordCubit, VaccineRecordState>(
          listener: (context, state) {
            if (state.blocState == BlocState.Pending) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state.blocState == BlocState.Successed) {
              EasyLoading.dismiss();
              if (state is DeleteVaccinationRecordState) {
                EasyLoading.showToast(
                    translate(context, 'delete_successfully'));
              }
            } else if ((state is CreateVaccinationRecordState ||
                    state is UpdateVaccinationRecordState) &&
                state.blocState == BlocState.Successed) {
              EasyLoading.showToast(translate(context, 'successfully'));
            } else if (state.blocState == BlocState.Failed) {
              EasyLoading.showToast(translate(context, state.error));
            }
          },
        ),
        BlocListener<MedicalRecordCubit, MedicalRecordState>(
          listener: (context, state) {
            if (state is UpdateSubUserLoading ||
                state is DeleteSubUserLoading) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state is UpdateSubUserSuccessfully ||
                state is DeleteSubUserSuccessfully ||
                state is NoChange) {
              EasyLoading.showToast(translate(context, 'successfully'));
            } else if (state is UpdateSubUserFailure) {
              EasyLoading.showToast(
                  translate(context, state.message.toLowerCase()));
            } else if (state is DeleteSubUserFailure) {
              EasyLoading.showToast(
                  translate(context, state.message.toLowerCase()));
            }
          },
        ),
        BlocListener<PatientRecordCubit, PatientRecordState>(
          listener: (context, state) async {
            if (state is OpenFileLoading ||
                state is AddPatientRecordLoading ||
                state is DeletePatientRecordLoading) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state is OpenFileLoaded) {
              EasyLoading.dismiss();
              await OpenDocument.openDocument(filePath: state.filePath);
            } else if (state is AddPatientRecordLoaded ||
                state is DeletePatientRecordLoaded) {
              EasyLoading.showToast(translate(context, 'successfully'));
            } else if (state is OpenFileError) {
              EasyLoading.showToast(translate(context, 'cant_download'));
              if (!await launchUrl(Uri.parse(state.url))) {
                if (!mounted) return;
                EasyLoading.showToast(translate(context, 'cant_open'));
              }
            } else if (state is AddPatientRecordError) {
              EasyLoading.showToast(translate(context, state.message));
            } else if (state is DeletePatientRecordError) {
              // if(state.blo)
              EasyLoading.showToast(translate(context, state.message));
            }
          },
        ),
      ],
      child: PopScope(
        canPop: exit,
        onPopInvoked: onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          backgroundColor: secondary,
          bottomNavigationBar: Transform.translate(
            offset: Offset(0, dimensWidth() * 12 * animation.value),
            child: Container(
              margin: EdgeInsets.all(dimensWidth() * 2.5),
              height: dimensWidth() * 7.8,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(dimensImage() * 6),
              ),
              child:
                  BlocBuilder<ApplicationUpdateCubit, ApplicationUpdateState>(
                builder: (context, state) {
                  _pageDetail.firstWhere((element) =>
                          element['title'] == 'notification')['badge'] =
                      state is UpdateAvailable;
                  return ListView.builder(
                    itemCount: _pageDetail.length,
                    scrollDirection: Axis.horizontal,
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensWidth() * 1),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => setState(() {
                        _currentIndex = index;
                        // if (_pageDetail[index]['title'] == 'schedule') {
                        //   context.read<ConsultationCubit>().fetchConsultation();
                        // }
                      }),
                      splashColor: transparent,
                      highlightColor: transparent,
                      child: Stack(children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width:
                              index == _currentIndex ? dimensWidth() * 16.5 : 9,
                          alignment: Alignment.center,
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            decoration: BoxDecoration(
                                color: index == _currentIndex
                                    ? primary.withOpacity(.2)
                                    : transparent,
                                borderRadius:
                                    BorderRadius.circular(dimensWidth() * 6)),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height:
                                index == _currentIndex ? dimensWidth() * 6 : 0,
                            width: index == _currentIndex
                                ? dimensWidth() * 16.5
                                : 0,
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == _currentIndex
                              ? dimensWidth() * 15.5
                              : dimensWidth() * 9,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    width: index == _currentIndex
                                        ? dimensWidth() * 6.5
                                        : 0,
                                  ),
                                  AnimatedOpacity(
                                    opacity: index == _currentIndex ? 1 : 0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: Text(
                                      index == _currentIndex
                                          ? translate(context,
                                              _pageDetail[index]['title'])
                                          : '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: primary),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    width: index == _currentIndex
                                        ? dimensWidth() * 1.5
                                        : 20,
                                  ),
                                  badgeNotification(
                                    child: FaIcon(
                                      _pageDetail[index]['icon'],
                                      size: dimensWidth() * 3.8,
                                      color: index == _currentIndex
                                          ? primary
                                          : black26,
                                    ),
                                    isShow: _pageDetail[index]['badge'],
                                    color: Theme.of(context).colorScheme.error,
                                    top: 0,
                                    end: 0,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ),
          ),
          floatingActionButtonLocation: AliceInspector().dev
              ? FloatingActionButtonLocation.endFloat
              : null,
          floatingActionButton: AliceInspector().dev
              ? Container(
                  margin: EdgeInsets.only(right: dimensWidth() * 40),
                  child: IconButton(
                    onPressed: () => RestClient().runHttpInspector(),
                    padding: EdgeInsets.all(dimensWidth() * 2),
                    icon: const FaIcon(FontAwesomeIcons.bug),
                    color: white,
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(secondary),
                    ),
                  ),
                )
              : null,
          body: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                left: isSideMenuClosed ? -dimensWidth() * 35 : 0,
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                child: const SideMenu(),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(animation.value - 30 * animation.value * pi / 180),
                child: Transform.translate(
                  offset: Offset(animation.value * dimensWidth() * 35, 0),
                  child: Transform.scale(
                    scale: scalAnimation.value,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                            isSideMenuClosed ? 0 : dimensWidth() * 3),
                      ),
                      child: InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        onTap: () {
                          if (!isSideMenuClosed) {
                            _animationController.reverse();
                          }
                          KeyboardUtil.hideKeyboard(context);
                          setState(() {
                            isSideMenuClosed = true;
                          });
                        },
                        child: GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (animationValue <= 0.3) {
                              _animationController.reverse();
                              isSideMenuClosed = true;
                            } else {
                              _animationController.forward();
                              isSideMenuClosed = false;
                            }
                          },
                          onHorizontalDragUpdate: (details) {
                            if (!isSideMenuClosed) {
                              animationValue =
                                  details.globalPosition.dx / maxWidth();
                              _animationController.value = animationValue;
                            } else if (isSideMenuClosed &&
                                details.delta.dx > 0 &&
                                details.localPosition.dx < 100) {
                              isSideMenuClosed = false;
                              animationValue =
                                  details.globalPosition.dx / maxWidth();
                              _animationController.value = animationValue;
                            }
                            // print(details.localPosition.dx);
                          },
                          child: AbsorbPointer(
                            child: _pageDetail[_currentIndex]['page'],
                            absorbing: !isSideMenuClosed,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
