import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/injected_vaccination_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_patient/vaccination/components/export.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';

class VaccinationScreen extends StatefulWidget {
  const VaccinationScreen({super.key});

  @override
  State<VaccinationScreen> createState() => _VaccinationScreenState();
}

class _VaccinationScreenState extends State<VaccinationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubUserCubit, SubUserState>(
      builder: (context, state) {
        UserResponse user = state.subUsers[state.currentUser];

        int age = calculateAge(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .parse(user.dateOfBirth!));
        context.read<VaccineRecordCubit>().updateAge(age, user.id!);
        context
            .read<VaccineRecordCubit>()
            .fetchInjectedVaccination(state.subUsers[state.currentUser].id!);

        return BlocBuilder<VaccineRecordCubit, VaccineRecordState>(
          buildWhen: (previous, current) => current is FetchInjectedVaccination,
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: true,
              backgroundColor: white,
              appBar: AppBar(
                title: Text(
                  translate(context, 'vaccination_record'),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: dimensWidth() * 3),
                    child: InkWell(
                      onTap: () async {
                        InjectedVaccinationResponse result =
                            await Navigator.pushNamed(
                                    context, addVaccinationName)
                                as InjectedVaccinationResponse;
                        // ignore: use_build_context_synchronously
                        context
                            .read<VaccineRecordCubit>()
                            .updateInjectedVaccinations(result);
                      },
                      splashColor: transparent,
                      highlightColor: transparent,
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        color: color1F1F1F,
                        size: dimensIcon() * .7,
                      ),
                    ),
                  ),
                ],
              ),
              body: AbsorbPointer(
                absorbing: state is FetchInjectedVaccinationLoading,
                child: const ListInjectedVaccination(),
              ),
            );
          },
        );
      },
    );
  }
}
