import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/main/home/docs_vaccination/components/export.dart';
import 'package:healthline/utils/translate.dart';

class DocsVaccinationScreen extends StatelessWidget {
  const DocsVaccinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      context.read<DocsVaccinationCubit>().fetchVaccinationFromStorage();
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            translate(context, 'vaccination'),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: dimensHeight() * 10),
          child: BlocBuilder<DocsVaccinationCubit, DocsVaccinationState>(
            builder: (context, state) {
              if (state.blocState == BlocState.Failed) {
                return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: dimensHeight() * 3),
                    child: Text(
                      "Can't load data",
                      style: Theme.of(context).textTheme.titleLarge,
                    ));
              } else if (state.blocState==BlocState.Pending) {
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
    });
  }
}
