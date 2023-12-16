import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import "package:healthline/routes/app_pages.dart";
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/translate.dart';

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  String? medicalId;
  String? patientName;
  @override
  void initState() {
    if (!mounted) return;
    context.read<MedicalRecordCubit>().fetchMedicalRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          extendBody: true,
          bottomNavigationBar: medicalId != null
              ? Container(
                  padding: EdgeInsets.fromLTRB(dimensWidth() * 10, 0,
                      dimensWidth() * 10, dimensHeight() * 3),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.0), white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ElevatedButtonWidget(
                      text: translate(context, 'book_appointment_now'),
                      onPressed: () {
                        context.read<ConsultationCubit>().updateRequest(
                            medicalRecord: medicalId, patientName: patientName);
                        Navigator.pushNamed(context, paymentMethodsName);
                      }),
                )
              : null,
          appBar: AppBar(
            title: Text(
              translate(context, 'medical_record'),
            ),
          ),
          body: AbsorbPointer(
            // absorbing: state is FetchScheduleLoading && state.schedules.isEmpty,
            absorbing: false,
            child: ListView(
              padding: EdgeInsets.symmetric(
                  vertical: dimensHeight() * 3, horizontal: dimensWidth() * 3),
              children: state.subUsers
                  .map(
                    (e) => ListTile(
                      title: Text(
                        e.fullName ?? translate(context, 'undefine'),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: color1F1F1F),
                      ),
                      subtitle: Text(
                        "${translate(context, 'relationship')}: ${translate(context, e.relationship?.name.toLowerCase() ?? 'you')}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: color1F1F1F),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          dimensWidth(),
                        ),
                      ),
                      onTap: () => setState(() {
                        // _payment = PaymentMethod.Momo;
                        medicalId = e.id;
                        patientName = e.fullName;
                      }),
                      dense: true,
                      visualDensity: const VisualDensity(vertical: 0),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: dimensWidth(),
                        vertical: dimensHeight(),
                      ),
                      trailing: Radio<String>(
                        value: e.id!,
                        groupValue: medicalId,
                        onChanged: (String? value) {
                          setState(() {
                            // _payment = value ?? PaymentMethod.None;
                            medicalId = value;
                            patientName = e.fullName;
                          });
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
