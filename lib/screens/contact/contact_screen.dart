// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/app/cubits/cubit_profile/profile_cubit.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screens/contact/components/export.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(UserRepository()),
      child: Builder(builder: (context) {
        return BlocConsumer<ProfileCubit, ProfileState>(
          bloc: context.read<ProfileCubit>(),
          listener: (context, state) {
            if (state is ProfileUpdated) {
              EasyLoading.showToast("update_success");
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: true,
              backgroundColor: white,
              appBar:
                  AppBar(title: Text(translate(context, 'edit_contact_info'))),
              body: GestureDetector(
                onTap: () => KeyboardUtil.hideKeyboard(context),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                  children: const [
                    // Stack(
                    //   children: [
                    //     Center(
                    //       child: _file == null
                    //           ? CircleAvatar(
                    //               backgroundColor: primary,
                    //               backgroundImage:
                    //                   AssetImage(DImages.placeholder),
                    //               onBackgroundImageError:
                    //                   (exception, stackTrace) =>
                    //                       AssetImage(DImages.placeholder),
                    //               radius: dimensWidth() * 15,
                    //             )
                    //           : CircleAvatar(
                    //               backgroundColor: primary,
                    //               backgroundImage: FileImage(_file!),
                    //               onBackgroundImageError:
                    //                   (exception, stackTrace) =>
                    //                       AssetImage(DImages.placeholder),
                    //               radius: dimensWidth() * 15,
                    //             ),
                    //     ),
                    //     Positioned(
                    //       bottom: 0,
                    //       right: dimensWidth() * 13,
                    //       child: InkWell(
                    //         splashColor: transparent,
                    //         highlightColor: transparent,
                    //         onTap: () async => getFile(),
                    //         child: Container(
                    //           padding: EdgeInsets.all(dimensWidth() * 1.5),
                    //           decoration: BoxDecoration(
                    //             color: white,
                    //             borderRadius: BorderRadius.circular(100),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Colors.grey.withOpacity(.1),
                    //                 spreadRadius: dimensWidth() * .4,
                    //                 blurRadius: dimensWidth() * .4,
                    //               ),
                    //             ],
                    //           ),
                    //           child: const FaIcon(
                    //             FontAwesomeIcons.pen,
                    //             color: primary,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   padding: EdgeInsets.only(top: dimensWidth() * 2),
                    //   child: Text(
                    //     "Tran Huynh Tan Phat",
                    //     style: Theme.of(context).textTheme.titleLarge,
                    //   ),
                    // ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   padding: EdgeInsets.only(top: dimensWidth() * .5),
                    //   child: Text(
                    //     "0389052819",
                    //     style: Theme.of(context).textTheme.bodyLarge,
                    //   ),
                    // ),
                    EditContactForm(),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
