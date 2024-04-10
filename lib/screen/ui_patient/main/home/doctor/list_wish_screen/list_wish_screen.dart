import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubit_doctor/doctor_cubit.dart';
import 'package:healthline/res/colors.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/list_wish_screen/components/export.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/utils/translate.dart';

class ListWishScreen extends StatefulWidget {
  const ListWishScreen({super.key});

  @override
  State<ListWishScreen> createState() => _ListWishScreenState();
}

class _ListWishScreenState extends State<ListWishScreen> {
  @override
  void initState() {
    if (!mounted) return;
    context.read<DoctorCubit>().getWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            translate(context, 'wish_list'),
          ),
        ),
        body: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            if (state.wishDoctors.isNotEmpty) {
              return ListView(
                shrinkWrap: false,
                padding: EdgeInsets.symmetric(
                    horizontal: dimensWidth() * 3,
                    vertical: dimensHeight() * 2),
                children: [
                  ...state.wishDoctors.map(
                    (e) => DoctorCard(doctor: e),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  buildShimmer(),
                ],
              );
            }
          },
        ));
  }
}

Widget buildShimmer() => Container(
      margin: EdgeInsets.fromLTRB(
          dimensWidth() * 3, dimensHeight() * 2, dimensWidth() * 3, 0),
      padding: EdgeInsets.all(dimensWidth() * 2),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            spreadRadius: dimensWidth() * .4,
            blurRadius: dimensWidth() * .4,
          ),
        ],
        borderRadius: BorderRadius.circular(dimensWidth() * 3),
        border: Border.all(color: colorA8B1CE.withOpacity(.2), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerWidget.circular(
                width: dimensWidth() * 7,
                height: dimensWidth() * 7,
              ),
              SizedBox(
                width: dimensWidth() * 2.5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget.rectangular(height: dimensHeight() * 2.5),
                    SizedBox(
                      height: dimensHeight(),
                    ),
                    ShimmerWidget.rectangular(height: dimensHeight() * 1.5),
                    // InkWell(
                    //   splashColor: transparent,
                    //   highlightColor: transparent,
                    //   onTap: () {
                    //     if (widget.doctor.id != null) {
                    //       DateTime dateTime = DateTime.now();
                    //       context.read<ConsultationCubit>().fetchTimeline(
                    //           doctorId: widget.doctor.id!,
                    //           date:
                    //               '${dateTime.day + 1}/${dateTime.month}/${dateTime.year}');
                    //       Navigator.pushNamed(
                    //         context,
                    //         createConsultationName,
                    //         arguments: widget.doctor.toJson(),
                    //       );
                    //     } else {
                    //       EasyLoading.showToast(
                    //           translate(context, 'cant_load_data'));
                    //       Navigator.pop(context);
                    //     }
                    //   },
                    //   child: Container(
                    //     width: dimensWidth() * 17,
                    //     padding: EdgeInsets.all(dimensWidth() * .8),
                    //     decoration: const BoxDecoration(
                    //       color: primary,
                    //       borderRadius: BorderRadius.all(
                    //         Radius.circular(100),
                    //       ),
                    //     ),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         FaIcon(
                    //           FontAwesomeIcons.solidCalendarPlus,
                    //           size: dimensIcon() * .4,
                    //           color: white,
                    //         ),
                    //         SizedBox(
                    //           width: dimensWidth() * .3,
                    //         ),
                    //         Expanded(
                    //           child: Text(
                    //             translate(context, 'book_appointment_now'),
                    //             maxLines: 1,
                    //             overflow: TextOverflow.ellipsis,
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodySmall
                    //                 ?.copyWith(color: white),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: dimensHeight(),
          ),
          ShimmerWidget.rectangular(height: dimensHeight() * 10)
        ],
      ),
    );
