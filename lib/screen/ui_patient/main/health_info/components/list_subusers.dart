import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/main/health_info/components/export.dart';
import 'package:healthline/screen/ui_patient/main/health_info/components/subuser_input_dialog.dart';
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

  Future<void> showDialogInput(BuildContext context) async {
    final subUserCubit = context.read<SubUserCubit>();
    final result = await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => BlocProvider.value(
              value: subUserCubit,
              child: SubUserInputDialog(formKey: _formKey),
            ));
    if (result == true) {
      // ignore: use_build_context_synchronously
      context.read<SubUserCubit>().fetchMedicalRecord();
    }
    // .whenComplete(
    //     () => context.read<HealthInfoCubit>().fetchMedicalRecord());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubUserCubit, SubUserState>(
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
              ...state.subUsers
                  .map(
                    (e) => SubUserCard(
                        subUser: e,
                        index: state.subUsers
                            .indexWhere((element) => element.id == e.id)),
                  )
                  .toList(),
          ],
        );
      },
    );
  }

  List<Widget> shimmerBuilder() {
    return List<Widget>.generate(
      6,
      (index) => Container(
        padding: EdgeInsets.all(dimensWidth() * .5),
        margin: EdgeInsets.symmetric(
            vertical: dimensWidth(), horizontal: dimensWidth() * .5),
        child: ShimmerWidget.retangular(
          height: double.maxFinite,
          width: dimensWidth() * 9,
        ),
      ),
    );
  }
}
