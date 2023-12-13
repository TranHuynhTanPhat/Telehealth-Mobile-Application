import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_application_update/application_update_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_res/res_cubit.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/components/badge_notification.dart';

import '../../../../../res/style.dart';
import '../../../../../utils/translate.dart';

class ApplicationSettingScreen extends StatelessWidget {
  const ApplicationSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResCubit, ResState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          backgroundColor: white,
          body: AbsorbPointer(
            absorbing: state is LanguageChanging,
            child: SafeArea(
              child: ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        dimensWidth(),
                      ),
                    ),
                    dense: true,
                    visualDensity: const VisualDensity(vertical: 0),
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
                      AppLocalizations.of(context).isVnLocale
                          ? FontAwesomeIcons.earthAsia
                          : FontAwesomeIcons.earthEurope,
                      size: dimensIcon() * .7,
                      color: color1F1F1F,
                    ),
                  ),
                  const Divider(),
                  BlocBuilder<ApplicationUpdateCubit, ApplicationUpdateState>(
                    builder: (context, state) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            dimensWidth(),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, updateName);
                        },
                        dense: true,
                        visualDensity: const VisualDensity(vertical: 0),
                        title: badgeNotification(
                            child: Text(
                              translate(context, 'update_application'),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            isShow: state is UpdateAvailable,
                            color: Theme.of(context).colorScheme.error,
                            top: 0,
                            end: 0),
                        leading: FaIcon(
                          FontAwesomeIcons.circleArrowDown,
                          size: dimensIcon() * .7,
                          color: Colors.green,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
