import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/main/health_info/components/export.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';

class ListSubUser extends StatefulWidget {
  const ListSubUser({
    super.key,
  });

  @override
  State<ListSubUser> createState() => _ListSubUserState();
}

class _ListSubUserState extends State<ListSubUser> {
  final _formKey = GlobalKey<FormState>();

  Future<void> showUpdateDialogInput(
      BuildContext context, UserResponse subUser) async {
    final medicalRecordCubit = context.read<MedicalRecordCubit>();
    await showModalBottomSheet(
      // barrierDismissible: true,
      barrierColor: black26,
      backgroundColor: transparent,
      elevation: 0,
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) => BlocProvider.value(
        value: medicalRecordCubit,
        child: UpdateSubUserInputDialog(
          userResponse: subUser,
        ),
      ),
    );
    // if (result == true) {
    //   medicalRecordCubit.fetchMedicalRecord();
    // }
  }

  Future<void> showDialogInput(BuildContext context) async {
    final medicalRecordCubit = context.read<MedicalRecordCubit>();
    await showModalBottomSheet(
        barrierColor: black26,
        backgroundColor: transparent,
        elevation: 0,
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (context) => BlocProvider.value(
              value: medicalRecordCubit,
              child: SubUserInputDialog(formKey: _formKey),
            ));
    // if (result == true) {
    //   medicalRecordCubit.fetchMedicalRecord();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
              onTap: () => showDialogInput(context),
              child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: dimensWidth(),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: dimensWidth(),
                    vertical: dimensHeight() * .5,
                  ),
                  alignment: Alignment.center,
                  width: dimensWidth() * 5,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(dimensWidth() * 2),
                  ),
                  child: const FaIcon(FontAwesomeIcons.circlePlus)),
            ),
            if (state is FetchSubUserLoading)
              ...shimmerBuilder()
            else
              ...state.subUsers.map((e) {
                // int index =
                //     state.subUsers.indexWhere((element) => element.id == e.id);
                return Stack(
                  children: [
                    InkWell(
                      splashColor: transparent,
                      highlightColor: transparent,
                      onTap: () {
                        if (e.id != state.currentId) {
                          context
                              .read<MedicalRecordCubit>()
                              .updateCurrentId(e.id!);
                        }
                      },
                      child: SubUserCard(
                          subUser: e, active: e.id == state.currentId),
                    ),
                    if (e.id == state.currentId)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () => showUpdateDialogInput(context, e),
                          child: Container(
                            padding: EdgeInsets.all(dimensWidth()),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(180),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.1),
                                  spreadRadius: dimensWidth() * .4,
                                  blurRadius: dimensWidth() * .4,
                                ),
                              ],
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.userPen,
                              size: dimensIcon() * .5,
                              color: color1F1F1F,
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(),
                  ],
                );
              }).toList(),
          ],
        );
      },
    );
  }

  List<Widget> shimmerBuilder() {
    return List<Widget>.generate(
      1,
      (index) => Container(
        padding: EdgeInsets.all(dimensWidth() * .5),
        margin: EdgeInsets.symmetric(
            vertical: dimensWidth(), horizontal: dimensWidth() * .5),
        child: const ShimmerWidget.rectangular(
          height: double.maxFinite,
          width: 80,
        ),
      ),
    );
  }
}
