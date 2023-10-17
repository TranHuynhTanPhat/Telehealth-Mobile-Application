import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_application_update/application_update_cubit.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/widgets/badge_notification.dart';

import '../../../../../res/style.dart';
import '../../../../../utils/translate.dart';

class ApplicationSettingScreen extends StatelessWidget {
  const ApplicationSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationUpdateCubit, ApplicationUpdateState>(
        builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        backgroundColor: white,
        // appBar: AppBar(
        //   title: Text(
        //     translate(context, 'application_setting'),
        //   ),
        // ),
        body: SafeArea(
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
                onTap: () {
                  Navigator.pushNamed(context, updateName);
                },
                dense: true,
                visualDensity: const VisualDensity(vertical: 0),
                title: badgeNotification(
                    Text(
                      translate(context, 'update_application'),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: color1F1F1F),
                    ),
                    state is UpdateAvailable,
                    Theme.of(context).colorScheme.error,
                    0,
                    0),
                leading: FaIcon(
                  FontAwesomeIcons.circleArrowDown,
                  size: dimensIcon(),
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
