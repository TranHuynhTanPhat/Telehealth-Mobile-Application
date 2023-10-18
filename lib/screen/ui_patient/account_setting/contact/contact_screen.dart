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
    context.read<ContactCubit>().fetchContact();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactCubit, ContactState>(
      listener: (context, state) {
        if (state is ContactLoading) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
        } else if (state is ContactError) {
          EasyLoading.showToast(state.message);
          Navigator.pop(context);
        } else if (state is ContactUpdate) {
          EasyLoading.showToast(translate(context, state.response.message));
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
          body: BlocBuilder<ContactCubit, ContactState>(
            builder: (context, state) {
              return AbsorbPointer(
                absorbing: state is ContactLoading,
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
