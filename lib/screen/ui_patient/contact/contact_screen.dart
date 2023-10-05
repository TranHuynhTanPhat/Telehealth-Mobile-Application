// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/contact/components/export.dart';
import 'package:healthline/screen/widgets/cancle_button.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late ContactCubit _contactCubit;
  @override
  void initState() {
    _contactCubit = ContactCubit();
    _contactCubit.fetchContact();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _contactCubit,
      child: BlocListener<ContactCubit, ContactState>(
        listener: (context, state) {
          if (state is ContactError) {
            EasyLoading.dismiss();
            Navigator.pop(context);
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
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                    children: const [
                      EditContactForm(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
