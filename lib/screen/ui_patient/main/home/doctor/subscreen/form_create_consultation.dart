// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
// import 'package:healthline/data/api/models/requests/consultation_request.dart';
// import 'package:healthline/res/style.dart';
// import 'package:healthline/screen/widgets/elevated_button_widget.dart';
// import 'package:healthline/utils/currency_util.dart';
// import 'package:healthline/utils/date_util.dart';
// import 'package:healthline/utils/time_util.dart';
// import 'package:healthline/utils/translate.dart';

// class FormConsultationScreen extends StatefulWidget {
//   const FormConsultationScreen({super.key, required this.request});
//   final ConsultationRequest request;

//   @override
//   State<FormConsultationScreen> createState() => _FormConsultationScreenState();
// }

// class _FormConsultationScreenState extends State<FormConsultationScreen> {
//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<int> time = [];
//     try {
//       time = state.request.expectedTime
//               ?.split('-')
//               .map((e) => int.parse(e))
//               .toList() ??
//           [int.parse(state.request.expectedTime!)];
//     } catch (e) {
//       EasyLoading.showToast(translate(context, 'failure'));
//     }
//     String expectedTime =
//         '${convertIntToTime(time.first - 1)} - ${convertIntToTime(time.last)}';
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: white,
//       extendBody: true,
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.fromLTRB(
//             dimensWidth() * 10, 0, dimensWidth() * 10, dimensHeight() * 3),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.white.withOpacity(0.0), white],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: ElevatedButtonWidget(
//             text: translate(
//                 context,
//                 state is CreateConsultationState &&
//                         state.blocState == BlocState.Successed
//                     ? 'home'
//                     : 'payment'),
//             onPressed: () {
//               // Navigator.pushNamed(context, invoiceName);
//               // state is CreateConsultationState &&
//               //         state.blocState == BlocState.Successed
//               //     ? Navigator.pushNamedAndRemoveUntil(
//               //         context, mainScreenPatientName, (route) => false)
//               //     :
//               context.read<ConsultationCubit>().createConsultation();
//             }),
//       ),
//       appBar: AppBar(
//         title: Text(
//           translate(context, 'appointment_information'),
//         ),
//       ),
//       body: AbsorbPointer(
//         absorbing: state is CreateConsultationState &&
//             state.blocState == BlocState.Pending,
//         child: ListView(
//           padding: EdgeInsets.symmetric(
//               vertical: dimensHeight(), horizontal: dimensWidth() * 3),
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: white,
//                 borderRadius: BorderRadius.circular(dimensWidth() * 2),
//                 border: Border.all(width: 2, color: Colors.grey.shade300),
//               ),
//               padding: EdgeInsets.symmetric(
//                   horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: dimensHeight() * .5,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${translate(context, 'created_at')}: ',
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                       Expanded(
//                         child: Text(
//                           formatDayMonthYear(context, DateTime.now()),
//                           style: Theme.of(context).textTheme.titleSmall,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${translate(context, 'doctor')}: ',
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                       Expanded(
//                         child: Text(
//                           state.doctorName ?? translate(context, 'undefine'),
//                           style: Theme.of(context).textTheme.titleSmall,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: dimensHeight() * .5,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${translate(context, 'patient')}: ',
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                       Expanded(
//                         child: Text(
//                           state.patientName ?? translate(context, 'undefine'),
//                           style: Theme.of(context).textTheme.titleSmall,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: dimensHeight() * .5,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${translate(context, 'day')}: ',
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                       Expanded(
//                         child: Text(
//                           state.request.date ?? translate(context, 'undefine'),
//                           style: Theme.of(context).textTheme.titleSmall,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: dimensHeight() * .5,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${translate(context, 'time')}: ',
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                       Expanded(
//                         child: Text(
//                           expectedTime,
//                           style: Theme.of(context).textTheme.titleSmall,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Divider(
//                     thickness: 3,
//                     color: black26,
//                   ),
//                   SizedBox(
//                     height: dimensHeight() * .5,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           '${translate(context, 'total')}: ',
//                           style: Theme.of(context).textTheme.labelLarge,
//                           textAlign: TextAlign.right,
//                         ),
//                       ),
//                       Text(
//                         convertToVND(state.request.price!),
//                         style: Theme.of(context).textTheme.titleSmall,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
