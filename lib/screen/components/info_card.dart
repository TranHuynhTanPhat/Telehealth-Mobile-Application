import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BlocBuilder<HealthInfoCubit, HealthInfoState>(
        builder: (context, state) {
          return Row(
            children: [
              Text(
                state.subUsers.isNotEmpty
                    ? state.subUsers
                            .firstWhere((element) => element.isMainProfile!)
                            .fullName ??
                        translate(context, 'undefine')
                    : translate(context, 'undefine'),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: white),
              ),
            ],
          );
        },
      ),
      subtitle: Text(
        translate(
            context,
            AppController.instance.authState == AuthState.PatientAuthorized
                ? 'patient'
                : 'doctor'),
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: white.withOpacity(.5)),
      ),
    );
  }
}
