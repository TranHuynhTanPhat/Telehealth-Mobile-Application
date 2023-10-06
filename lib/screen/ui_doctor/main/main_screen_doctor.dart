import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/components/drawer_menu.dart';
import 'package:healthline/screen/ui_doctor/main/helps/helps_screen.dart';
import 'package:healthline/screen/ui_doctor/main/overview/overview_screen.dart';
import 'package:healthline/screen/ui_doctor/main/patient/patient_screen.dart';
import 'package:healthline/screen/ui_doctor/main/setting/setting_screen.dart';
import 'package:healthline/screen/ui_doctor/main/schedule/schedule_screen.dart';
import 'package:healthline/utils/translate.dart';

class MainScreenDoctor extends StatefulWidget {
  const MainScreenDoctor({super.key});

  @override
  State<MainScreenDoctor> createState() => _MainScreenDoctorState();
}

class _MainScreenDoctorState extends State<MainScreenDoctor> {
  DrawerMenus _currentPage = DrawerMenus.Overview;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SideMenuCubit(),
      child: BlocListener<SideMenuCubit, SideMenuState>(
        listener: (context, state) {
          if (state is SideMenuLoading) {
            EasyLoading.show();
          } else if (state is LogoutActionState) {
            EasyLoading.dismiss();
            Navigator.pushReplacementNamed(context, logInName);
          } else if (state is ErrorActionState) {
            EasyLoading.dismiss();
          }
        },
        child: Builder(builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            backgroundColor: white,
            appBar: AppBar(
                title: Text(translate(
                    context,
                    _currentPage == DrawerMenus.Schedule
                        ? 'schedule'
                        : _currentPage == DrawerMenus.Patient
                            ? 'patient'
                            : _currentPage == DrawerMenus.Setting
                                ? 'setting'
                                : _currentPage == DrawerMenus.Helps
                                    ? 'helps'
                                    : "Bs. Lê Đình Trường"))),
            drawer: Drawer(
              width: dimensWidth() * 40,
              backgroundColor: white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            backgroundImage: AssetImage(DImages.placeholder),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Bs. Lê Đình Trường',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: white),
                          ),
                          Text(
                            'leditruong@gmail.com',
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
                  AppController.instance.authState == AuthState.AllAuthorized
                      ? ListTile(
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
                      : const SizedBox(),
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
                    lable: 'overview',
                    icon: FontAwesomeIcons.houseMedical,
                  ),
                  LabelDrawer(
                    active: _currentPage == DrawerMenus.Schedule,
                    lable: 'schedule',
                    icon: FontAwesomeIcons.solidCalendar,
                    press: () {
                      setState(() {
                        _currentPage = DrawerMenus.Schedule;
                      });
                    },
                  ),
                  LabelDrawer(
                    active: _currentPage == DrawerMenus.Patient,
                    lable: 'patient',
                    icon: FontAwesomeIcons.hospitalUser,
                    press: () {
                      setState(() {
                        _currentPage = DrawerMenus.Patient;
                      });
                    },
                  ),
                  LabelDrawer(
                    active: _currentPage == DrawerMenus.Setting,
                    lable: 'setting',
                    icon: FontAwesomeIcons.gear,
                    press: () {
                      setState(() {
                        _currentPage = DrawerMenus.Setting;
                      });
                    },
                  ),
                  const Spacer(),
                  LabelDrawer(
                    active: _currentPage == DrawerMenus.Helps,
                    lable: 'helps',
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
            body: _currentPage == DrawerMenus.Setting
                ? const SettingScreen()
                : _currentPage == DrawerMenus.Schedule
                    ? const ScheduleScreen()
                    : _currentPage == DrawerMenus.Patient
                        ? const PatientScreen()
                        : _currentPage == DrawerMenus.Helps
                            ? const HelpsScreen()
                            : const OverviewScreen(),
          );
        }),
      ),
    );
  }
}
