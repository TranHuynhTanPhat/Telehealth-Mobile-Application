import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: white,
      body: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
        builder: (context, state) {
          if (state is FetchPatientState && state.patients.isNotEmpty) {
            return ListView(
              shrinkWrap: true,
              children: state.patients
                  .map((e) => ExpansionTile(
                        title: Text(
                          e.email ?? translate(context, 'undefine'),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        subtitle: Text(
                          e.phone ?? translate(context, 'undefine'),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        children: const [
                          //   Padding(
                          //   padding: EdgeInsets.symmetric(vertical: dimensHeight(),
                          //       horizontal: dimensWidth() * 3),
                          //   child: Text(e['answer']!, style: Theme.of(context).textTheme.bodyLarge,),
                          // )
                        ],
                      ))
                  .toList(),
            );
          } else {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          translate(context, 'empty'),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  color: color1F1F1F.withOpacity(.05),
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: dimensHeight() * 3,
                  // ),
                  FaIcon(
                    FontAwesomeIcons.boxOpen,
                    color: color1F1F1F.withOpacity(.05),
                    size: dimensWidth() * 30,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
