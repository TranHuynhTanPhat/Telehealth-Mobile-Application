import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubit_medical_record/medical_record_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_patient_record/patient_record_cubit.dart';
import 'package:healthline/utils/translate.dart';

import '../../../../../res/style.dart';

class PatientRecordScreen extends StatefulWidget {
  const PatientRecordScreen({super.key});

  @override
  State<PatientRecordScreen> createState() => _PatientRecordScreenState();
}

class _PatientRecordScreenState extends State<PatientRecordScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
      builder: (context, state) {
        if (state.currentId != null) {
          context
              .read<PatientRecordCubit>()
              .fetchPatientRecord(state.currentId!);
        } else {
          Navigator.pop(context);
        }
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          extendBody: true,
          appBar: AppBar(
            title: Text(
              translate(context, 'medical_record'),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<PatientRecordCubit, PatientRecordState>(
            builder: (context, state) {
              return AbsorbPointer(
                absorbing: state is FetchPatientRecordLoading,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
