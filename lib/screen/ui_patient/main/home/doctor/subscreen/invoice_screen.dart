import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/responses/discount_response.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({
    super.key,
    required this.previousPage,
    required this.request,
    required this.doctor,
    this.patientName,
    this.patientAge,
  });
  final VoidCallback previousPage;
  final ConsultationRequest request;
  final DoctorResponse doctor;
  final String? patientName;
  final int? patientAge;
  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  bool _usePoints = false;
  DiscountResponse? dis;
  Timer? timer;
  final TextEditingController _discount = TextEditingController();
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
        '${convertIntToTime(time.first)} - ${convertIntToTime(time.last + 1)}';
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => widget.previousPage(),
      child: GestureDetector(
        onTap: () => KeyboardUtil.hideKeyboard(context),
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
                  ConsultationRequest request = widget.request;
                  if (dis != null && dis?.code != null) {
                    request.discountCode = dis?.code;
                  }
                  context
                      .read<ConsultationCubit>()
                      .createConsultation(consultation: request);
                }),
          ),
          appBar: AppBar(
            title: Text(
              translate(context, 'appointment_information'),
            ),
          ),
          body: BlocBuilder<PatientProfileCubit, PatientProfileState>(
              builder: (context, state) {
            return ListView(
              // padding: EdgeInsets.symmetric(
              //     vertical: dimensHeight(), horizontal: dimensWidth() * 3),
              shrinkWrap: true,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     color: white,
                //     borderRadius: BorderRadius.circular(dimensWidth() * 2),
                //     border: Border.all(width: 2, color: Colors.grey.shade300),
                //   ),
                //   padding: EdgeInsets.symmetric(
                //       horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
                //   child:
                //    Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                // SizedBox(
                //   height: dimensHeight() * .5,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensWidth() * 3,
                      vertical: dimensHeight() * 2),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${translate(context, 'patient')}: ',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Expanded(
                            child: Text(
                              widget.patientName ??
                                  translate(context, 'undefine'),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                      if (widget.patientAge != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${translate(context, 'age')}: ',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Expanded(
                              child: Text(
                                "${widget.patientAge}",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      if (widget.request.symptoms != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${translate(context, 'symptoms')}: ',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            Expanded(
                              child: Text(
                                widget.request.symptoms!.isEmpty
                                    ? translate(context, 'empty')
                                    : widget.request.symptoms!,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                const Divider(
                  thickness: 10,
                  color: colorF8F9FD,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensWidth() * 3,
                      vertical: dimensHeight() * 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: dimensWidth() * 7,
                        width: dimensWidth() * 7,
                        margin: EdgeInsets.fromLTRB(
                          0,
                          dimensHeight(),
                          dimensWidth(),
                          dimensHeight(),
                        ),
                        decoration: const BoxDecoration(
                          color: white,
                        ),
                        child: Image.asset(
                          DImages.placeholder,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${translate(context, 'doctor')}: ',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.doctor.fullName ??
                                        translate(context, 'undefine'),
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              ],
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
                                    widget.request.date ??
                                        translate(context, 'undefine'),
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              ],
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
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${convertToVND(widget.doctor.feePerMinutes ?? 0)}/${translate(context, 'minute')}",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 10,
                  color: colorF8F9FD,
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Text(
                //       '${translate(context, 'created_at')}: ',
                //       style: Theme.of(context).textTheme.labelLarge,
                //     ),
                //     Expanded(
                //       child: Text(
                //         formatDayMonthYear(context, DateTime.now()),
                //         style: Theme.of(context).textTheme.titleSmall,
                //       ),
                //     ),
                //   ],
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensWidth() * 3,
                      vertical: dimensHeight() * 2),
                  child: Column(
                    children: [
                      if (state.profile.point != null &&
                          state.profile.point! > 0)
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.coins,
                              color: colorDF9F1E,
                              size: dimensIcon(),
                            ),
                            SizedBox(
                              width: dimensWidth(),
                            ),
                            Expanded(
                              child: Text(
                                translate(context, 'reward_points'),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            Switch(
                              value: _usePoints,
                              activeColor: colorDF9F1E,
                              activeTrackColor: colorDF9F1E.withOpacity(.2),
                              splashRadius: 1,
                              onChanged: (value) => setState(() {
                                _usePoints = value;
                              }),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: dimensHeight(),
                      ),
                      TextFieldWidget(
                        validate: (value) => null,
                        controller: _discount,
                        label: translate(context, 'discount_code'),
                        onChanged: (p0) {
                          if (timer != null) {
                            setState(() {
                              timer?.cancel();
                            });
                          }
                          setState(() {
                            timer = Timer(const Duration(milliseconds: 800),
                                () async {
                              if (_discount.text.isNotEmpty) {
                                dis = await context
                                    .read<ConsultationCubit>()
                                    .checkDiscount(code: _discount.text);
                              } else {
                                dis = null;
                              }
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 10,
                  color: colorF8F9FD,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensWidth() * 3,
                      vertical: dimensHeight() * 2),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${translate(context, 'total_medical_examination_fee')}: ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Expanded(
                            child: Text(
                              convertToVND(widget.request.price!),
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      if (dis != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${translate(context, 'total_discount')}: ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Expanded(
                              child: Text(
                                convertToVND(dis?.value ?? 0),
                                style: Theme.of(context).textTheme.titleSmall,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      if (state.profile.point != null &&
                          state.profile.point! > 0 &&
                          _usePoints)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${translate(context, 'reward_points')}: ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Expanded(
                              child: Text(
                                convertToVND(state.profile.point ?? 0),
                                style: Theme.of(context).textTheme.titleSmall,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: dimensHeight(),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${translate(context, 'total')}: ',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Expanded(
                            child: Text(
                              convertToVND(((widget.request.price ?? 0) -
                                  (dis?.value ?? 0))),
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
