import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/vaccination/components/export.dart';
import 'package:healthline/utils/translate.dart';

class VaccinationScreen extends StatelessWidget {
  const VaccinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VaccinationCubit(),
      child: Builder(builder: (context) {
        context.read<VaccinationCubit>().fetchData();
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
                  onTap: () => Navigator.pushNamed(context, addVaccinationName),
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
          body: const ListInjectedVaccination(),
        );
      }),
    );
  }
}
