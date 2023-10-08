import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/vaccination/components/export.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class VaccinationScreen extends StatefulWidget {
  const VaccinationScreen({super.key});

  @override
  State<VaccinationScreen> createState() => _VaccinationScreenState();
}

class _VaccinationScreenState extends State<VaccinationScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VaccinationCubit(),
        ),
        BlocProvider(
          create: (context) => HealthInfoCubit(),
        ),
      ],
      child: BlocBuilder<HealthInfoCubit, HealthInfoState>(
        builder: (context, state) {
          UserResponse user = state.subUsers[state.currentUser];

          int age = calculateAge(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .parse(user.dateOfBirth!));
          context.read<VaccinationCubit>().fetchVaccination(age);
          return BlocConsumer<VaccinationCubit, VaccinationState>(
            listenWhen: (previous, current) => current is FetchVaccination,
            buildWhen: (previous, current) =>
                current is FetchInjectedVaccination,
            listener: (context, state) {
              if (state is VaccinationLoaded) {
                context
                    .read<VaccinationCubit>()
                    .fetchInjectedVaccination(user.id!);
              }
            },
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
                        onTap: () =>
                            Navigator.pushNamed(context, addVaccinationName),
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
                  absorbing: state is FetchInjectedVaccinationLoading ||
                      state is VaccinationLoading,
                  child: const ListInjectedVaccination(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
