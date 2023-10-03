import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/main/health_info/components/export.dart';
import 'package:healthline/screens/main/health_info/components/subuser_input_dialog.dart';

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
    await showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => SubUserInputDialog(formKey: _formKey))
        .whenComplete(
            () => context.read<HealthInfoCubit>().fetchMedicalRecord());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthInfoCubit, HealthInfoState>(
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
            ...state.subUsers
                .map(
                  (e) => SubUserCard(subUser: e, index: state.subUsers.indexWhere((element) => element.id==e.id)),
                )
                .toList(),
          ],
        );
      },
    );
  }
}
