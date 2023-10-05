import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/ref_vaccination/components/export.dart';
import 'package:healthline/utils/translate.dart';

class RefVaccinationScreen extends StatelessWidget {
  const RefVaccinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VaccinationCubit(),
      child: Builder(builder: (context) {
        context.read<VaccinationCubit>().fetchData();
        return Scaffold(
          appBar: AppBar(
            elevation: 10,
            title: Text(
              translate(context, 'vaccination'),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: dimensHeight() * 10),
            child: BlocBuilder<VaccinationCubit, VaccinationState>(
              builder: (context, state) {
                if (state is VaccinationError) {
                  return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: dimensHeight() * 3),
                      child: Text(
                        "Can't load data",
                        style: Theme.of(context).textTheme.titleLarge,
                      ));
                } else if (state is VaccinationLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.diseaseAdult.isNotEmpty &&
                    state.diseaseChild.isNotEmpty) {
                  return ListVaccination(
                    diseaseAdult: state.diseaseAdult,
                    diseaseChild: state.diseaseChild,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
