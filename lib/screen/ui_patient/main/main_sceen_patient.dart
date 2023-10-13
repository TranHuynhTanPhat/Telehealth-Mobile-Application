// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/components/side_menu.dart';
import 'package:healthline/screen/ui_patient/main/health_info/healthinfo_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/home_screen.dart';
import 'package:healthline/screen/ui_patient/main/notification/notification_screen.dart';
import 'package:healthline/screen/ui_patient/main/schedule/schedule_screen.dart';
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

  bool isSideMenuClosed = true;

  DateTime? currentBackPressTime;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  late Animation<double> hideAnimation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      EasyLoading.dismiss();
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
    hideAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.fastOutSlowIn),
    );

    context.read<MedicalRecordCubit>().fetchMedicalRecord();
    super.initState();
  }

  @override
  void deactivate() {
    _animationController.dispose();
    super.deactivate();
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
        "icon": FontAwesomeIcons.heartPulse
      },
      {
        "page": const ScheduleScreen(),
        "title": "schedule",
        "icon": FontAwesomeIcons.calendar
      },
      {
        "page": const NotificationScreen(),
        "title": "notification",
        "icon": FontAwesomeIcons.solidBell
      },
      {
        "page": const HealthInfoScreen(),
        "title": "health_info",
        "icon": FontAwesomeIcons.bookMedical
      },
    ];

    Future<bool> onWillPop() {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        EasyLoading.showToast(translate(context, 'click_again_to_exit'));

        return Future.value(false);
      }
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: onWillPop,
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
            child: ListView.builder(
              itemCount: _pageDetail.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 1),
              itemBuilder: (context, index) => InkWell(
                onTap: () => setState(() {
                  _currentIndex = index;
                }),
                splashColor: transparent,
                highlightColor: transparent,
                child: Stack(children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    width: index == _currentIndex ? dimensWidth() * 16.5 : 9,
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
                      height: index == _currentIndex ? dimensWidth() * 6 : 0,
                      width: index == _currentIndex ? dimensWidth() * 16.5 : 0,
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
                                    ? translate(
                                        context, _pageDetail[index]['title'])
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
                            FaIcon(
                              _pageDetail[index]['icon'],
                              size: dimensWidth() * 3.8,
                              color: index == _currentIndex ? primary : black26,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Container(
          margin: EdgeInsets.only(right: dimensWidth() * 40),
          child: IconButton(
            onPressed: () => RestClient().runHttpInspector(),
            padding: EdgeInsets.all(dimensWidth() * 2),
            icon: const FaIcon(FontAwesomeIcons.bug),
            color: white,
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(secondary)),
          ),
        ),
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
                      Radius.circular(isSideMenuClosed ? 0 : dimensWidth() * 3),
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
                      child: AbsorbPointer(
                        child: _pageDetail[_currentIndex]['page'],
                        absorbing: !isSideMenuClosed,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
