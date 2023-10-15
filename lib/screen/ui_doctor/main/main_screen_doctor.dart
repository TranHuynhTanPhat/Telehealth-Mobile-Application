import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/components/drawer_menu.dart';
import 'package:healthline/screen/ui_doctor/main/helps/helps_screen.dart';
import 'package:healthline/screen/ui_doctor/main/overview/overview_screen.dart';
import 'package:healthline/screen/ui_doctor/main/patient/patient_screen.dart';
import 'package:healthline/screen/ui_doctor/main/account_setting/account_setting_screen.dart';
import 'package:healthline/screen/ui_doctor/main/schedule/schedule_screen.dart';
import 'package:healthline/screen/widgets/badge_notification.dart';
import 'package:healthline/utils/translate.dart';

class MainScreenDoctor extends StatefulWidget {
  const MainScreenDoctor({super.key});

  @override
  State<MainScreenDoctor> createState() => _MainScreenDoctorState();
}

class _MainScreenDoctorState extends State<MainScreenDoctor> {
  DrawerMenus _currentPage = DrawerMenus.Overview;

  DateTime? currentBackPressTime;

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: BlocListener<SideMenuCubit, SideMenuState>(
        listener: (context, state) {
          if (state is SideMenuLoading) {
            EasyLoading.show();
          } else if (state is LogoutActionState) {
            EasyLoading.dismiss();
            Navigator.pushReplacementNamed(context, logInName);
          } else if (state is ErrorActionState) {
            EasyLoading.dismiss();
          } else if (state is DoctorAvatarSuccessfully) {
            _image = null;
          }
        },
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
                  _currentPage == DrawerMenus.Schedule
                      ? 'schedule'
                      : _currentPage == DrawerMenus.Patient
                          ? 'patient'
                          : _currentPage == DrawerMenus.AccountSetting
                              ? 'account_setting'
                              : _currentPage == DrawerMenus.Helps
                                  ? 'helps'
                                  : state.profile != null
                                      ? state.profile?.fullName ?? 'undefine'
                                      : 'overview',
                ),
              );
            }),
            leading:
                BlocBuilder<ApplicationUpdateCubit, ApplicationUpdateState>(
              builder: (context, state) {
                return badgeNotification(
                    IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const FaIcon(FontAwesomeIcons.bars),
                    ),
                    state is UpdateAvailable,
                    Theme.of(context).colorScheme.error,
                    7,
                    7);
              },
            ),
          ),
          drawer: Drawer(
            width: dimensWidth() * 40,
            backgroundColor: white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
                    builder: (context, state) {
                  if (state.profile != null) {
                    _image = _image ??
                        NetworkImage(
                          CloudinaryContext.cloudinary
                              .image(state.profile!.avatar ?? '')
                              .toString(),
                        );

                    return SizedBox(
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
                              onBackgroundImageError: (exception, stackTrace) =>
                                  setState(() {
                                _image = AssetImage(DImages.placeholder);
                              }),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              state.profile?.fullName ??
                                  translate(context, 'undefine'),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: white),
                            ),
                            Text(
                              state.profile?.email ??
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
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
                if (AppController.instance.authState == AuthState.AllAuthorized)
                  ListTile(
                    onTap: () {
                      EasyLoading.show();
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pushReplacementNamed(
                            context, mainScreenPatientName);
                      });
                    },
                    title: Text(
                      translate(context, 'use_patient_account'),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: color1F1F1F),
                    ),
                    leading: FaIcon(
                      FontAwesomeIcons.solidUser,
                      size: dimensIcon() * .5,
                      color: color1F1F1F,
                    ),
                  )
                else
                  const SizedBox(),
                Padding(
                  padding: EdgeInsets.only(
                      top: dimensHeight() * 2,
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
                  active: _currentPage == DrawerMenus.Overview,
                  press: () {
                    setState(() {
                      _currentPage = DrawerMenus.Overview;
                    });
                  },
                  label: 'overview',
                  icon: FontAwesomeIcons.houseMedical,
                ),
                LabelDrawer(
                  active: _currentPage == DrawerMenus.Schedule,
                  label: 'schedule',
                  icon: FontAwesomeIcons.solidCalendar,
                  press: () {
                    setState(() {
                      _currentPage = DrawerMenus.Schedule;
                    });
                  },
                ),
                LabelDrawer(
                  active: _currentPage == DrawerMenus.Patient,
                  label: 'patient',
                  icon: FontAwesomeIcons.hospitalUser,
                  press: () {
                    setState(() {
                      _currentPage = DrawerMenus.Patient;
                    });
                  },
                ),
                LabelDrawer(
                  active: _currentPage == DrawerMenus.AccountSetting,
                  label: 'account_setting',
                  icon: FontAwesomeIcons.userGear,
                  press: () {
                    setState(() {
                      _currentPage = DrawerMenus.AccountSetting;
                    });
                  },
                ),
                BlocBuilder<ApplicationUpdateCubit, ApplicationUpdateState>(
                  builder: (context, state) {
                    return LabelDrawer(
                      active: _currentPage == DrawerMenus.ApplicationSetting,
                      label: 'application_setting',
                      icon: FontAwesomeIcons.gear,
                      isShowBadge: state is UpdateAvailable,
                      press: () {
                        Navigator.pushNamed(context, applicationSettingName);
                      },
                    );
                  },
                ),
                const Spacer(),
                LabelDrawer(
                  active: _currentPage == DrawerMenus.Helps,
                  label: 'helps',
                  icon: FontAwesomeIcons.solidCircleQuestion,
                  press: () {
                    setState(() {
                      _currentPage = DrawerMenus.Helps;
                    });
                  },
                ),
                ListTile(
                  onTap: () {
                    AppLocalizations.of(context).isVnLocale
                        ? context.read<ResCubit>().toEnglish()
                        : context.read<ResCubit>().toVietnamese();
                  },
                  title: Text(
                    AppLocalizations.of(context).isVnLocale
                        ? translate(context, 'en')
                        : translate(context, 'vi'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: color1F1F1F),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.language,
                    size: dimensIcon() * .5,
                    color: color1F1F1F,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: dimensHeight() * 5),
                  child: ListTile(
                    onTap: () {
                      // RestClient().logout();

                      context.read<SideMenuCubit>().logout();
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.arrowRightFromBracket,
                      size: dimensIcon() * .7,
                      color: color9D4B6C,
                    ),
                    title: Text(
                      translate(context, 'log_out'),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: color9D4B6C),
                    ),
                  ),
                ),
              ],
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
          body: _currentPage == DrawerMenus.AccountSetting
              ? const SettingScreen()
              : _currentPage == DrawerMenus.Schedule
                  ? const ScheduleScreen()
                  : _currentPage == DrawerMenus.Patient
                      ? const PatientScreen()
                      : _currentPage == DrawerMenus.Helps
                          ? const HelpsScreen()
                          : const OverviewScreen(),
        ),
      ),
    );
  }
}
