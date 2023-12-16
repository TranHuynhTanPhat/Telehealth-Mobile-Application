// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/account_setting/contact/components/export.dart';
import 'package:healthline/screen/widgets/cancel_button.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    context.read<PatientProfileCubit>().fetProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientProfileCubit, PatientProfileState>(
      listener: (context, state) {
        if (state.blocState == BlocState.Pending) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
        } else if (state.blocState == BlocState.Failed) {
          EasyLoading.showToast(
              translate(context, state.error.toString().toLowerCase()));
          Navigator.pop(context);
        } else if (state.blocState == BlocState.Successed) {
          EasyLoading.dismiss();
          if (state is UpdateContactState) {
            EasyLoading.showToast(translate(context, 'successfully'));
          }
        }
      },
      child: GestureDetector(
        onTap: () => KeyboardUtil.hideKeyboard(context),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          backgroundColor: white,
          appBar: AppBar(
            elevation: 10,
            title: Text(
              translate(context, 'edit_contact_info'),
            ),
            leadingWidth: dimensWidth() * 10,
            leading: cancelButton(context),
          ),
          body: BlocBuilder<PatientProfileCubit, PatientProfileState>(
            builder: (context, state) {
              return AbsorbPointer(
                absorbing: state.blocState == BlocState.Pending,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                  children: const [
                    EditContactForm(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
