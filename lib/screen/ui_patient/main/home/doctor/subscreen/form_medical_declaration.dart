import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class FormMedicalDeclaration extends StatefulWidget {
  const FormMedicalDeclaration({super.key});

  @override
  State<FormMedicalDeclaration> createState() => _FormMedicalDeclarationState();
}

class _FormMedicalDeclarationState extends State<FormMedicalDeclaration> {
  bool commit = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        extendBody: true,
        appBar: AppBar(
          title: Text(
            translate(context, 'medical_declaration'),
          ),
        ),
        bottomNavigationBar:
               Container(
                  padding: EdgeInsets.fromLTRB(dimensWidth() * 10, 0,
                      dimensWidth() * 10, dimensHeight() * 3),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.0), white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ElevatedButtonWidget(
                      text: translate(context, 'book_appointment_now'),
                      onPressed: () {
                        // context.read<ConsultationCubit>().updateRequest(
                        //     medicalRecord: medicalId, patientName: patientName);
                        Navigator.pushNamed(context, paymentMethodsName);
                      }),
                ),
        body: ListView(
          shrinkWrap: false,
          padding: EdgeInsets.symmetric(
            horizontal: dimensWidth() * 3,
          ),
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: dimensHeight() * 2),
              child: Text(
                '1. ${translate(context, 'personal_information_of_the_declarant')}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.visible,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * .5),
              child: Row(
                children: [
                  Text(
                    '${translate(context, 'full_name')}: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.visible,
                  ),
                  Expanded(
                    child: Text(
                      'name',
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * .5),
              child: Row(
                children: [
                  Text(
                    '${translate(context, 'birthday')}: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.visible,
                  ),
                  Expanded(
                    child: Text(
                      '0/0/0',
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * .5),
              child: Row(
                children: [
                  Text(
                    '${translate(context, 'gender')}: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.visible,
                  ),
                  Expanded(
                    child: Text(
                      'Nam',
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
              child: Text(
                '2. ${translate(context, 'signs_of_the_disease_appeared_recently')}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.visible,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * .5),
              child: TextFieldWidget(
                validate: (value) => null,
                hint: translate(context,
                    'please_tell_us_about_your_current_health_condition'),
                maxLine: 5,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
              child: Text(
                '3. ${translate(context, 'medical_history')}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.visible,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * 3),
              child: TextFieldWidget(
                validate: (value) => null,
                hint: translate(
                    context, 'please_tell_us_about_your_medical_history'),
                maxLine: 5,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * .5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      side: const BorderSide(width: 1),
                      value: commit,
                      onChanged: (value) => setState(
                        () {
                          commit = value!;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: dimensWidth(),
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: transparent,
                      highlightColor: transparent,
                      onTap: () => setState(() {
                        commit = !commit;
                      }),
                      child: Text(
                        "${translate(context, 'commit_medical_declaration')} ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
