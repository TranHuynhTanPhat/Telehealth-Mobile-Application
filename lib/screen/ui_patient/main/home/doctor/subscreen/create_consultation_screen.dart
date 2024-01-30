import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/form_medical_declaration.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/invoice_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/medical_record_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/payment_method_screen.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/timeline_doctor_screen.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class CreateConsultationScreen extends StatefulWidget {
  const CreateConsultationScreen({super.key, this.args});
  final String? args;

  @override
  State<CreateConsultationScreen> createState() =>
      _CreateConsultationScreenState();
}

class _CreateConsultationScreenState extends State<CreateConsultationScreen> {
  CreateConsultation _index = CreateConsultation.TimeLine;
  // ignore: unused_field
  PaymentMethod _paymentMethod = PaymentMethod.None;
  DoctorResponse? doctor;
  late ConsultationRequest request;
  String? patientName;
  String? doctorName;
  @override
  void initState() {
    request = ConsultationRequest();
    super.initState();
  }

  void updateRequest({
    String? doctorId,
    String? medicalRecord,
    String? date,
    List<int>? expectedTime,
    String? discountCode,
    String? patientName,
    String? doctorName,
    String? symptoms,
    String? medicalHistory,
    List<String>? patientRecords,
  }) {
    this.patientName = patientName ?? this.patientName;
    this.doctorName = doctorName ?? this.doctorName;
    request = request.copyWith(
        expectedTime: expectedTime?.join('-'),
        doctorId: doctorId,
        medicalRecord: medicalRecord,
        price: expectedTime != null
            ? doctor!.feePerMinutes! * 30 * expectedTime.length
            : null,
        discountCode: discountCode,
        date: date,
        symptoms: symptoms,
        medicalHistory: medicalHistory,
        patientRecords: patientRecords);
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (doctor == null) {
        doctor = DoctorResponse.fromJson(widget.args!);
        updateRequest(
          doctorId: doctor?.id,
          doctorName: doctor?.fullName,
        );
        if (doctor?.id == null) {
          throw 'not_found';
        }
        // print(doctor?.toJson());
      }
    } catch (e) {
      logPrint("ERROR$e");
      EasyLoading.showToast(translate(context, 'not_found'));
      Navigator.pop(context);
      return const SizedBox();
    }
    return BlocListener<ConsultationCubit, ConsultationState>(
      listener: (context, state) {
        if (state is CreateConsultationState) {
          if (state.blocState == BlocState.Successed) {
            EasyLoading.showToast(translate(context, "successfully"));
            Navigator.pushNamedAndRemoveUntil(
                context, mainScreenPatientName, (route) => false);
          } else if (state.blocState == BlocState.Pending) {
            EasyLoading.show(maskType: EasyLoadingMaskType.black);
          }
        }
        if (state.blocState == BlocState.Failed) {
          EasyLoading.showToast(translate(context, state.error));
        }
      },
      child: BlocBuilder<ConsultationCubit, ConsultationState>(
        builder: (context, state) {
          if (_index == CreateConsultation.TimeLine) {
            return TimelineDoctorScreen(
              doctor: doctor!,
              callback: (
                      {date,
                      discountCode,
                      doctorId,
                      doctorName,
                      expectedTime,
                      medicalHistory,
                      medicalRecord,
                      patientName,
                      patientRecords,
                      symptoms}) =>
                  updateRequest(
                      date: date,
                      discountCode: discountCode,
                      doctorId: doctorId,
                      medicalRecord: medicalRecord,
                      expectedTime: expectedTime,
                      patientName: patientName,
                      doctorName: doctorName,
                      symptoms: symptoms,
                      medicalHistory: medicalHistory,
                      patientRecords: patientRecords),
              nextPage: () {
                setState(() {
                  _index = CreateConsultation.MedicalRecord;
                });
              },
            );
          } else if (_index == CreateConsultation.MedicalRecord) {
            return MedicalRecordScreen(
              callback: (
                      {date,
                      discountCode,
                      doctorId,
                      doctorName,
                      expectedTime,
                      medicalHistory,
                      medicalRecord,
                      patientName,
                      patientRecords,
                      symptoms}) =>
                  updateRequest(
                      date: date,
                      discountCode: discountCode,
                      doctorId: doctorId,
                      medicalRecord: medicalRecord,
                      expectedTime: expectedTime,
                      patientName: patientName,
                      doctorName: doctorName,
                      symptoms: symptoms,
                      medicalHistory: medicalHistory,
                      patientRecords: patientRecords),
              nextPage: () {
                setState(() {
                  _index = CreateConsultation.FormMedicalDelaration;
                });
              },
              previousPage: () {
                setState(() {
                  _index = CreateConsultation.TimeLine;
                });
              },
            );
          } else if (_index == CreateConsultation.FormMedicalDelaration) {
            return FormMedicalDeclaration(
              callback: (
                      {date,
                      discountCode,
                      doctorId,
                      doctorName,
                      expectedTime,
                      medicalHistory,
                      medicalRecord,
                      patientName,
                      patientRecords,
                      symptoms}) =>
                  updateRequest(
                      date: date,
                      discountCode: discountCode,
                      doctorId: doctorId,
                      medicalRecord: medicalRecord,
                      expectedTime: expectedTime,
                      patientName: patientName,
                      doctorName: doctorName,
                      symptoms: symptoms,
                      medicalHistory: medicalHistory,
                      patientRecords: patientRecords),
              nextPage: () {
                setState(() {
                  _index = CreateConsultation.PaymentMethod;
                });
              },
              previousPage: () {
                setState(() {
                  _index = CreateConsultation.MedicalRecord;
                });
              },
              patientName: patientName,
            );
          } else if (_index == CreateConsultation.PaymentMethod) {
            return PaymentMethodScreen(
              callback: (payment) {
                _paymentMethod = payment;
              },
              nextPage: () {
                setState(() {
                  _index = CreateConsultation.Invoice;
                });
              },
              previousPage: () {
                setState(() {
                  _index = CreateConsultation.FormMedicalDelaration;
                });
              },
            );
          } else {
            return InvoiceScreen(
              previousPage: () {
                setState(() {
                  _index = CreateConsultation.PaymentMethod;
                });
              },
              request: request,
              patientName: patientName,
              doctorName: doctorName,
            );
          }
        },
      ),
    );
  }
}
