import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_patient/main/health_info/vaccination/components/export.dart';
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
    return BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
      builder: (context, state) {
        UserResponse user = state.subUsers
            .firstWhere((element) => element.id == state.currentId);

        int age = calculateAge(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .parse(user.dateOfBirth!));
        context.read<VaccineRecordCubit>().updateAge(age, user.id!);
        context.read<VaccineRecordCubit>().fetchVaccinationRecord(state.subUsers
            .firstWhere((element) => element.id == state.currentId)
            .id!);

        return BlocBuilder<VaccineRecordCubit, VaccineRecordState>(
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
                  if (state.blocState != BlocState.Pending)
                    Padding(
                      padding: EdgeInsets.only(right: dimensWidth() * 3),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.pushNamed(
                              context, addVaccinationName);
                        },
                        borderRadius: BorderRadius.circular(180),
                        child: Padding(
                          padding: EdgeInsets.all(dimensWidth()),
                          child: FaIcon(
                            FontAwesomeIcons.plus,
                            color: color1F1F1F,
                            size: dimensIcon() * .7,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              body: AbsorbPointer(
                absorbing: state.blocState == BlocState.Pending,
                child: const ListInjectedVaccination(),
              ),
            );
          },
        );
      },
    );
  }
}
