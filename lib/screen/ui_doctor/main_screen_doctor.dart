import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/components/badge_notification.dart';
import 'package:healthline/screen/components/drawer_label.dart';
import 'package:healthline/screen/schedule/schedule_screen.dart';
import 'package:healthline/screen/ui_doctor/account_setting/account_setting_doctor_screen.dart';
import 'package:healthline/screen/ui_doctor/application_setting/application_setting_screen.dart';
import 'package:healthline/screen/ui_doctor/helps/helps_screen.dart';
import 'package:healthline/screen/ui_doctor/overview/overview_screen.dart';
import 'package:healthline/screen/ui_doctor/patient/patient_screen.dart';
import 'package:healthline/screen/ui_doctor/shift_schedule/shift_screen.dart';
import 'package:healthline/utils/alice_inspector.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class MainScreenDoctor extends StatefulWidget {
  const MainScreenDoctor({super.key});

  @override
  State<MainScreenDoctor> createState() => _MainScreenDoctorState();
}

class _MainScreenDoctorState extends State<MainScreenDoctor> {
  DateTime? currentBackPressTime;
  bool disableDrawer = false;
  bool onChangeToPatient = false;
  bool exit = false;

  DrawerMenu _currentPage = DrawerMenu.Overview;
  // ignore: prefer_typing_uninitialized_variables
  var _image;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      EasyLoading.dismiss();
    });
    context.read<DoctorProfileCubit>().fetchProfile();
   
    _image = null;
  }

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

  void clickDrawer() {
    EasyLoading.dismiss();
    disableDrawer = true;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: exit,
      onPopInvoked: onWillPop,
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              if (state.blocState == BlocState.Pending) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else if ((state.blocState == BlocState.Successed ||
                      state.blocState == BlocState.Failed) &&
                  state is LogoutState) {
                EasyLoading.dismiss();
                Navigator.pushReplacementNamed(context, logInName);
              }
            },
          ),
          BlocListener<ResCubit, ResState>(
            listener: (context, state) {
              if (state is LanguageChanging) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else {
                EasyLoading.dismiss();
              }
            },
          ),
          BlocListener<DoctorProfileCubit, DoctorProfileState>(
            listener: (context, state) {
              if (state is UpdateProfileState) {
                if (state.blocState == BlocState.Pending) {
                  EasyLoading.show(maskType: EasyLoadingMaskType.black);
                } else if (state.blocState == BlocState.Successed) {
                  EasyLoading.showToast(translate(context, state.message));
                  if (state.message == "update_avatar_successfully") {
                    String url = CloudinaryContext.cloudinary
                        .image(state.profile.avatar ?? '')
                        .toString();
                    NetworkImage provider = NetworkImage(url);
                    provider.evict().then<void>((bool success) {
                      if (success) debugPrint('removed image!');
                    });
                  }
                }
              } else if (state is FetchProfileState) {
                if (state.blocState == BlocState.Pending) {
                  EasyLoading.show(maskType: EasyLoadingMaskType.black);
                } else if (state.blocState == BlocState.Successed) {
                  EasyLoading.dismiss();
                } else if (state.blocState == BlocState.Failed) {
                  EasyLoading.showToast(translate(context, state.error));
                }
              }
            },
          ),
          BlocListener<DoctorScheduleCubit, DoctorScheduleState>(
            listener: (context, state) {
              // if (state.blocState == BlocState.Pending) {
              //   EasyLoading.show(maskType: EasyLoadingMaskType.black);
              // } else if (state is UpdateFixedScheduleState ||
              //     state is UpdateScheduleByDayState) {
              //   if (state.blocState == BlocState.Successed) {
              //     EasyLoading.showToast(translate(context, 'successfully'));
              //     Navigator.pop(context, true);
              //   } else if (state.blocState == BlocState.Failed) {
              //     EasyLoading.showToast(translate(context, state.error));
              //   }
              // } else if (state.blocState == BlocState.Successed ||
              //     state.blocState == BlocState.Failed) {
              //   EasyLoading.dismiss();
              // } else if (state.blocState == BlocState.Failed) {
              //   EasyLoading.showToast(translate(context, 'cant_load_data'));
              // }
            },
          ),
          BlocListener<ConsultationCubit, ConsultationState>(
              listener: (context, state) {
            if (state is FetchFeedbackDoctorState) {
              if (state.blocState == BlocState.Pending) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else if (state.blocState == BlocState.Successed ||
                  state.blocState == BlocState.Failed) {
                EasyLoading.dismiss();
              } else if (state.blocState == BlocState.Failed) {
                EasyLoading.showToast(translate(context, 'cant_load_data'));
              }
            }
          })
        ],
        child: AbsorbPointer(
          absorbing: onChangeToPatient,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            backgroundColor: white,
            appBar: AppBar(
              title: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
                  builder: (context, state) {
                return Text(
                  translate(
                      context,
                      _currentPage == DrawerMenu.Schedule
                          ? 'schedule'
                          : _currentPage == DrawerMenu.YourShift
                              ? 'your_shift'
                              : _currentPage == DrawerMenu.Patient
                                  ? 'patient'
                                  : _currentPage == DrawerMenu.AccountSetting
                                      ? 'account_setting'
                                      : _currentPage == DrawerMenu.Helps
                                          ? 'helps'
                                          : state.profile.fullName ??
                                              'overview'),
                );
              }),
              leading:
                  BlocBuilder<ApplicationUpdateCubit, ApplicationUpdateState>(
                builder: (context, state) {
                  return badgeNotification(
                      child: IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const FaIcon(FontAwesomeIcons.bars),
                      ),
                      isShow: state is UpdateAvailable,
                      color: Theme.of(context).colorScheme.error,
                      top: 7,
                      end: 7);
                },
              ),
            ),
            onDrawerChanged: (isOpen) {
              if (isOpen) {
                setState(() {
                  disableDrawer = false;
                });
              }
            },
            drawer: AbsorbPointer(
              absorbing: disableDrawer,
              child: Drawer(
                width: dimensWidth() * 40,
                backgroundColor: white,
                child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
                  builder: (context, state) {
                    try {
                      if (state.profile.avatar != null &&
                          state.profile.avatar != 'default' &&
                          state.profile.avatar != '') {
                        _image = _image ??
                            NetworkImage(
                              CloudinaryContext.cloudinary
                                  .image(state.profile.avatar ?? '')
                                  .toString(),
                            );
                      } else {
                        _image = AssetImage(DImages.placeholder);
                      }
                    } catch (e) {
                      logPrint(e);
                      _image = AssetImage(DImages.placeholder);
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          child: DrawerHeader(
                            decoration: const BoxDecoration(
                              color: secondary,
                            ),
                            padding: EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: _image,
                                  onBackgroundImageError:
                                      (exception, stackTrace) => setState(() {
                                    _image = AssetImage(DImages.placeholder);
                                  }),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  state.profile.fullName ??
                                      translate(context, 'undefine'),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: white),
                                ),
                                Text(
                                  state.profile.email ??
                                      translate(context, 'undefine'),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            children: [
                              // if (AppController.instance.authState ==
                              //     AuthState.AllAuthorized)
                              //   ListTile(
                              //     onTap: () {
                              //       EasyLoading.show(
                              //           maskType: EasyLoadingMaskType.black);
                              //       setState(() {
                              //         onChangeToPatient = true;
                              //         Future.delayed(const Duration(seconds: 1),
                              //             () {
                              //           Navigator.pushReplacementNamed(
                              //               context, mainScreenPatientName);
                              //         });
                              //       });
                              //     },
                              //     title: Text(
                              //       translate(context, 'use_patient_account'),
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .titleMedium
                              //           ?.copyWith(color: color1F1F1F),
                              //     ),
                              //     leading: FaIcon(
                              //       FontAwesomeIcons.solidUser,
                              //       size: dimensIcon() * .5,
                              //       color: color1F1F1F,
                              //     ),
                              //   ),
                              ListTile(
                                onTap: () {
                                  // EasyLoading.show(
                                  //     maskType: EasyLoadingMaskType.black);
                                  // setState(() {
                                  //   onChangeToPatient = true;
                                  // Future.delayed(const Duration(seconds: 1),
                                  //     () {
                                  Navigator.pushNamed(context, forumName);
                                  // });
                                  // });
                                },
                                title: Text(
                                  translate(context, 'forum'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: color1F1F1F),
                                ),
                                leading: FaIcon(
                                  FontAwesomeIcons.solidComments,
                                  size: dimensIcon() * .5,
                                  color: color1F1F1F,
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                    top: dimensHeight(),
                                    left: dimensWidth() * 2,
                                    bottom: dimensHeight()),
                                child: Text(
                                  translate(context, 'general'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: color1F1F1F),
                                ),
                              ),
                              LabelDrawer(
                                active: _currentPage == DrawerMenu.Overview,
                                press: () async {
                                  setState(() {
                                    _currentPage = DrawerMenu.Overview;
                                    clickDrawer();
                                  });
                                },
                                label: 'overview',
                                icon: FontAwesomeIcons.houseMedical,
                              ),
                              LabelDrawer(
                                active: _currentPage == DrawerMenu.Schedule,
                                label: 'schedule',
                                icon: FontAwesomeIcons.solidCalendarCheck,
                                press: () {
                                  setState(() {
                                    _currentPage = DrawerMenu.Schedule;
                                    clickDrawer();
                                  });
                                },
                              ),
                              LabelDrawer(
                                active: _currentPage == DrawerMenu.YourShift,
                                label: 'your_shift',
                                icon: FontAwesomeIcons.solidCalendarDays,
                                press: () {
                                  setState(() {
                                    _currentPage = DrawerMenu.YourShift;
                                    clickDrawer();
                                  });
                                },
                              ),
                              LabelDrawer(
                                active: _currentPage == DrawerMenu.Patient,
                                label: 'patient',
                                icon: FontAwesomeIcons.hospitalUser,
                                press: () {
                                  setState(() {
                                    _currentPage = DrawerMenu.Patient;
                                    if (state.profile.id != null) {
                                      context
                                          .read<DoctorProfileCubit>()
                                          .fetchPatient();
                                    }
                                    clickDrawer();
                                  });
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: dimensHeight() * 2,
                                    left: dimensWidth() * 2,
                                    bottom: dimensHeight()),
                                child: Text(
                                  translate(context, 'setting'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: color1F1F1F),
                                ),
                              ),
                              LabelDrawer(
                                active:
                                    _currentPage == DrawerMenu.AccountSetting,
                                label: 'account_setting',
                                icon: FontAwesomeIcons.userGear,
                                press: () {
                                  setState(() {
                                    _currentPage = DrawerMenu.AccountSetting;
                                    clickDrawer();
                                  });
                                },
                              ),
                              BlocBuilder<ApplicationUpdateCubit,
                                  ApplicationUpdateState>(
                                builder: (context, state) {
                                  return LabelDrawer(
                                    active: _currentPage ==
                                        DrawerMenu.ApplicationSetting,
                                    label: 'application_setting',
                                    icon: FontAwesomeIcons.gear,
                                    isShowBadge: state is UpdateAvailable,
                                    press: () {
                                      setState(() {
                                        _currentPage =
                                            DrawerMenu.ApplicationSetting;
                                        clickDrawer();
                                      });
                                    },
                                  );
                                },
                              ),
                              // const Spacer(),
                              LabelDrawer(
                                active: _currentPage == DrawerMenu.Helps,
                                label: 'helps',
                                icon: FontAwesomeIcons.solidCircleQuestion,
                                press: () {
                                  setState(() {
                                    _currentPage = DrawerMenu.Helps;
                                    clickDrawer();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
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
                          backgroundColor: MaterialStatePropertyAll(secondary)),
                    ),
                  )
                : null,
            body: _currentPage == DrawerMenu.AccountSetting
                ? const SettingScreen()
                : _currentPage == DrawerMenu.Schedule
                    ? const ScheduleScreen()
                    : _currentPage == DrawerMenu.YourShift
                        ? const ShiftScreen()
                        : _currentPage == DrawerMenu.Patient
                            ? const PatientScreen()
                            : _currentPage == DrawerMenu.Helps
                                ? const HelpsScreen()
                                : _currentPage == DrawerMenu.ApplicationSetting
                                    ? const ApplicationSettingScreen()
                                    : const OverviewScreen(),
          ),
        ),
      ),
    );
  }
}
