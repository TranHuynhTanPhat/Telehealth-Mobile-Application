import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen(
      {super.key,
      required this.previousPage,
      required this.request,
      this.doctorName,
      this.patientName});
  final VoidCallback previousPage;
  final ConsultationRequest request;
  final String? doctorName;
  final String? patientName;
  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    List<int> time = [];
    try {
      time = widget.request.expectedTime
              ?.split('-')
              .map((e) => int.parse(e))
              .toList() ??
          [int.parse(widget.request.expectedTime!)];
    } catch (e) {
      EasyLoading.showToast(translate(context, 'failure'));
    }
    String expectedTime =
        '${convertIntToTime(time.first - 1)} - ${convertIntToTime(time.last)}';
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => widget.previousPage(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        extendBody: true,
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(
              dimensWidth() * 10, 0, dimensWidth() * 10, dimensHeight() * 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.0), white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ElevatedButtonWidget(
              text: translate(context, 'payment'),
              onPressed: () {
                // Navigator.pushNamed(context, invoiceName);
                // state is CreateConsultationState &&
                //         state.blocState == BlocState.Successed
                //     ? Navigator.pushNamedAndRemoveUntil(
                //         context, mainScreenPatientName, (route) => false)
                // :
                context
                    .read<ConsultationCubit>()
                    .createConsultation(consultation: widget.request);
              }),
        ),
        appBar: AppBar(
          title: Text(
            translate(context, 'appointment_information'),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
              vertical: dimensHeight(), horizontal: dimensWidth() * 3),
          children: [
            Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(dimensWidth() * 2),
                border: Border.all(width: 2, color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: dimensHeight() * .5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${translate(context, 'created_at')}: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Expanded(
                        child: Text(
                          formatDayMonthYear(context, DateTime.now()),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${translate(context, 'doctor')}: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Expanded(
                        child: Text(
                          widget.doctorName ?? translate(context, 'undefine'),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dimensHeight() * .5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${translate(context, 'patient')}: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Expanded(
                        child: Text(
                          widget.patientName ?? translate(context, 'undefine'),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dimensHeight() * .5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${translate(context, 'day')}: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Expanded(
                        child: Text(
                          widget.request.date ?? translate(context, 'undefine'),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dimensHeight() * .5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${translate(context, 'time')}: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Expanded(
                        child: Text(
                          expectedTime,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 3,
                    color: black26,
                  ),
                  SizedBox(
                    height: dimensHeight() * .5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          '${translate(context, 'total')}: ',
                          style: Theme.of(context).textTheme.labelLarge,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Text(
                        convertToVND(widget.request.price!),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
