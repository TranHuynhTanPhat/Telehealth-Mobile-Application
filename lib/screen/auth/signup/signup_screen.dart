import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/auth/signup/components/exports.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKeyProfile = GlobalKey<FormState>();
  final _formKeyContact = GlobalKey<FormState>();
  final _formKeySecurity = GlobalKey<FormState>();

  // late AnimationController _animationController;
  // late Animation<double> animationProfile;
  // late Animation<double> animationContact;
  // late Animation<double> animationSecurity;

  late TextEditingController _controllerFullName;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerConfirmPassword;
  late TextEditingController _controllerGender;
  late TextEditingController _controllerBirthday;
  late TextEditingController _controllerAddress;
  late TextEditingController _controllerEmail;

  late SignUp step;

  String? conflictPhone;
  String? confictEmail;

  bool _agreeTermsAndConditions = false;
  String? _gender;

  @override
  void initState() {
    step = SignUp.Instruction;

    _controllerFullName = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    _controllerBirthday = TextEditingController();
    _controllerGender = TextEditingController();
    _controllerAddress = TextEditingController();
    _controllerEmail = TextEditingController();
    // _animationController =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 3))
    //       ..forward()
    //       ..addListener(() {
    //         if (_animationController.isCompleted) {
    //           Future.delayed(const Duration(milliseconds: 500), () {
    //             _animationController.repeat();
    //           });
    //         }
    //       });
    // ;
    // animationProfile = Tween<double>(begin: .5, end: 1).animate(CurvedAnimation(
    //     parent: _animationController, curve: Curves.fastOutSlowIn));

    // animationContact = Tween<double>(begin: .5, end: 1).animate(
    //   CurvedAnimation(
    //       parent: _animationController, curve: Curves.fastOutSlowIn),
    // );
    // animationSecurity = Tween<double>(begin: .5, end: 1).animate(
    //   CurvedAnimation(
    //       parent: _animationController, curve: Curves.fastOutSlowIn),
    // );
    super.initState();
  }

  @override
  void dispose() {
    // _animationController.dispose();
    _controllerFullName.dispose();
    _controllerPhone.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    _controllerBirthday.dispose();
    _controllerGender.dispose();
    _controllerAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is RegisterAccountState) {
              if (state.blocState == BlocState.Pending) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else if (state.blocState == BlocState.Successed) {
                EasyLoading.showToast(translate(context, 'success_register'));
                Navigator.pushReplacementNamed(context, logInName);
              } else if (state.blocState == BlocState.Failed) {
                try {
                  if (state.error!
                      .contains('phone_number_has_been_registered')) {
                    setState(() {
                      step = SignUp.Contact;
                      conflictPhone ??= _controllerPhone.text.trim();
                    });
                  }
                  if (state.error!.contains("email_has_been_registered")) {
                    setState(() {
                      step = SignUp.Contact;
                      confictEmail ??= _controllerEmail.text.trim();
                    });
                  }
                } catch (e) {
                  logPrint(e);
                }
                EasyLoading.showToast(translate(context, state.error));
              }
            }
          },
          child: GestureDetector(
            onTap: () => KeyboardUtil.hideKeyboard(context),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
                  return AbsorbPointer(
                    absorbing: state.blocState == BlocState.Pending,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(vertical: dimensHeight() * 10),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 3),
                          child: const HeaderSignUp(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: dimensWidth() * 3,
                              right: dimensWidth() * 3,
                              top: dimensHeight() * 5),
                          child: Column(
                            children: [
                              Visibility(
                                visible: step == SignUp.Instruction,
                                child: Instructions(
                                  onPressed: () {
                                    setState(() {
                                      step = SignUp.Profile;
                                    });
                                  },
                                ),
                              ),
                              Visibility(
                                visible: step == SignUp.Profile,
                                child: ProfileForm(
                                  backPressed: () {
                                    setState(() {
                                      step = SignUp.Instruction;
                                    });
                                  },
                                  continuePressed: () {
                                    setState(() {
                                      step = SignUp.Contact;
                                    });
                                  },
                                  formKey: _formKeyProfile,
                                  controllerFullName: _controllerFullName,
                                  controllerBirthday: _controllerBirthday,
                                  controllerGender: _controllerGender,
                                  controllerAddress: _controllerAddress,
                                  gender: _gender,
                                  genderPressed: (value) {
                                    _gender = value;
                                  },
                                ),
                              ),
                              Visibility(
                                visible: step == SignUp.Contact,
                                child: ContactForm(
                                  backPressed: () {
                                    setState(() {
                                      step = SignUp.Profile;
                                    });
                                  },
                                  continuePressed: () {
                                    setState(() {
                                      step = SignUp.Secutiry;
                                    });
                                  },
                                  formKey: _formKeyContact,
                                  conflictEmail: confictEmail,
                                  conflictPhone: conflictPhone,
                                  controllerEmail: _controllerEmail,
                                  controllerPhone: _controllerPhone,
                                ),
                              ),
                              Visibility(
                                visible: step == SignUp.Secutiry,
                                child: PasswordForm(
                                  backPressed: () {
                                    setState(() {
                                      step = SignUp.Contact;
                                    });
                                  },
                                  createAccountPressed: () {
                                    context
                                        .read<AuthenticationCubit>()
                                        .registerAccount(
                                          _controllerFullName.text.trim(),
                                          Validate().changePhoneFormat(
                                              _controllerPhone.text.trim()),
                                          _controllerEmail.text.trim(),
                                          _controllerPassword.text.trim(),
                                          _controllerConfirmPassword.text.trim(),
                                          _gender!,
                                          _controllerBirthday.text.trim(),
                                          _controllerAddress.text.trim(),
                                        );
                                  },
                                  formKey: _formKeySecurity,
                                  controllerPassword: _controllerPassword,
                                  controllerConfirmPassword:
                                      _controllerConfirmPassword,
                                  agreeTermsAndConditions:
                                      _agreeTermsAndConditions,
                                  agreeTermsAndConditionsPressed: (value) {
                                    setState(() {
                                      _agreeTermsAndConditions = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 3),
                          child: const OptionSignUp(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
