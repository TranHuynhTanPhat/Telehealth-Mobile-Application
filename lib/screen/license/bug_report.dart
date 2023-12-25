import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_license/license_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';

class BugReportScreen extends StatefulWidget {
  const BugReportScreen({super.key});

  @override
  State<BugReportScreen> createState() => _BugReportScreenState();
}

class _BugReportScreenState extends State<BugReportScreen> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerFullName;
  late TextEditingController _controllerFeedback;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controllerEmail = TextEditingController();
    _controllerFullName = TextEditingController();
    _controllerFeedback = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LicenseCubit licenseCubit = LicenseCubit();
    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        backgroundColor: white,
        appBar: AppBar(
          title: Text(
            translate(context, 'bug_report'),
          ),
          // leadingWidth: dimensWidth() * 10,
          // leading: cancelButton(context),
        ),
        body: SafeArea(
          bottom: true,
          child: BlocConsumer<LicenseCubit, LicenseState>(
              bloc: licenseCubit,
              listener: (context, state) {
                if (state is BugReportState) {
                  if (state.blocState == BlocState.Pending) {
                    EasyLoading.show(maskType: EasyLoadingMaskType.black);
                  } else if (state.blocState == BlocState.Successed) {
                    EasyLoading.showToast(translate(context, 'successfully'));
                    Navigator.pop(context);
                  } else {
                    EasyLoading.showToast(translate(context, 'failure'));
                  }
                }
              },
              builder: (context, state) {
                return AbsorbPointer(
                  absorbing: state is BugReportState &&
                      state.blocState == BlocState.Pending,
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: dimensHeight() * 3,
                                  top: dimensHeight() * 3),
                              child: TextFieldWidget(
                                label: translate(context, 'email'),
                                hint: translate(context, 'ex_email'),
                                controller: _controllerEmail,
                                validate: (value) =>
                                    Validate().validateEmail(context, value),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: dimensHeight() * 3,
                              ),
                              child: TextFieldWidget(
                                validate: (value) {
                                  if (_controllerFullName.text.trim() == '') {
                                    return translate(
                                        context, 'please_enter_full_name');
                                  } else if (_controllerFullName.text.trim()
                                          .split(' ')
                                          .length <
                                      2) {
                                    return translate(context,
                                        'full_name_must_be_longer_than_or_equal_to_2_characters');
                                  }
                                  return null;
                                },
                                controller: _controllerFullName,
                                label: translate(context, 'full_name'),
                                hint: translate(context, 'ex_full_name'),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: dimensHeight() * 2),
                              child: TextFieldWidget(
                                validate: (value) {
                                  if (_controllerFeedback.text.trim() == '') {
                                    return translate(
                                        context, 'please_enter_feedback');
                                  }
                                  return null;
                                },
                                // onChanged: (value) => _controllerFeedback.text =
                                //     _controllerFeedback.text.trim(),
                                controller: _controllerFeedback,
                                label: translate(context, 'feedbacks'),
                                maxLine: 10,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: dimensHeight()),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  icon: FaIcon(
                                    FontAwesomeIcons.paperPlane,
                                    size: dimensIcon() * .6,
                                    color: white,
                                  ),
                                  label: Text(translate(context, 'send'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(color: white)),
                                  style: ButtonStyle(
                                    padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          vertical: dimensHeight() * 2,
                                          horizontal: dimensWidth() * 2.5),
                                    ),
                                    backgroundColor:
                                        const MaterialStatePropertyAll(primary),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      licenseCubit.reportBugState(
                                          email: _controllerEmail.text.trim(),
                                          fullName: _controllerFullName.text.trim(),
                                          feedback: _controllerFeedback.text.trim());
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
