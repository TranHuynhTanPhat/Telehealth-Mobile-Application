import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubit_doctor/doctor_cubit.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/components/doctor_card.dart';
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
            return ListView(
              shrinkWrap: true,
              children: [
                ...state.wishDoctors.map(
                  (e) => DoctorCard(doctor: e),
                ),
              ],
            );
          },
        ));
  }
}
