import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

import '../../../../utils/file_picker.dart';
import '../../../../utils/validate.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController _controllerBio;
  late TextEditingController _controllerEmail;

  final _formKey = GlobalKey<FormState>();
  late File? _file;
  // ignore: prefer_typing_uninitialized_variables
  var _image;
  bool errEmail = false;
  bool errBio = false;
  bool errAvatar = false;

  @override
  void initState() {
    _controllerBio = TextEditingController();
    _controllerEmail = TextEditingController();
    _file = null;
    _image = null;
    if (!mounted) return;
    context.read<DoctorProfileCubit>().fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorProfileCubit, DoctorProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileState) {
          if (state.blocState == BlocState.Failed) {
            EasyLoading.showToast(translate(context, state.error));
          }
        } else if (state is FetchProfileState) {
          if (state.blocState == BlocState.Failed) {
            Navigator.pop(context);
          }
        }
      },
      child: GestureDetector(
        onTap: () => KeyboardUtil.hideKeyboard(context),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          extendBody: true,
          appBar: AppBar(
            title: Text(
              translate(context, 'update_biography'),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
            builder: (context, state) {
              _controllerEmail.text = _controllerEmail.text.trim().isEmpty
                  ? state.profile.email ?? ''
                  : _controllerEmail.text;
              _controllerBio.text = _controllerBio.text.trim().isEmpty
                  ? state.profile.biography ?? ''
                  : _controllerBio.text;
              try {
                if (state.profile.avatar != null &&
                    state.profile.avatar != 'default' &&
                    state.profile.avatar != '') {
                  _image = _image ??
                      NetworkImage(
                        CloudinaryContext.cloudinary
                            .image(state.profile.avatar ?? '')
                            .toString(),
                      );
                } else {
                  _image = AssetImage(DImages.placeholder);
                }
              } catch (e) {
                logPrint(e);
                _image = AssetImage(DImages.placeholder);
              }
              return AbsorbPointer(
                absorbing: (state is UpdateProfileState &&
                        state.blocState == BlocState.Pending) ||
                    (state is FetchProfileState &&
                        state.blocState == BlocState.Pending),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensWidth() * 3,
                      vertical: dimensHeight() * 2),
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _file != null
                              ? CircleAvatar(
                                  radius: dimensWidth() * 10,
                                  backgroundColor: primary,
                                  backgroundImage: FileImage(_file!),
                                  onBackgroundImageError:
                                      (exception, stackTrace) =>
                                          AssetImage(DImages.placeholder),
                                  child: InkWell(
                                    splashColor: transparent,
                                    highlightColor: transparent,
                                    onTap: () async {
                                      _file =
                                          await FilePickerCustom().getImage();
                                      setState(() {});
                                    },
                                  ),
                                )
                              : CircleAvatar(
                                  radius: dimensWidth() * 10,
                                  backgroundImage: _image,
                                  onBackgroundImageError:
                                      (exception, stackTrace) => setState(() {
                                    _image = AssetImage(DImages.placeholder);
                                  }),
                                  child: InkWell(
                                    splashColor: transparent,
                                    highlightColor: transparent,
                                    onTap: () async {
                                      _file =
                                          await FilePickerCustom().getImage();
                                      setState(() {});
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.circlePlus,
                                      color: black26,
                                      size: dimensIcon() * 2,
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: EdgeInsets.only(top: dimensHeight() * 3),
                            child: TextFieldWidget(
                                label: translate(context, 'email'),
                                hint: translate(context, 'ex_email'),
                                controller: _controllerEmail,
                                validate: (value) =>
                                    Validate().validateEmail(context, value)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: dimensHeight() * 3),
                            child: TextFieldWidget(
                              label: translate(context, 'biography'),
                              controller: _controllerBio,
                              validate: (value) {
                                if (value!.split(' ').length < 100) {
                                  return translate(context,
                                      'biography_must_be_at_least_100_words');
                                }
                                return null;
                              },
                              maxLine: 10,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: dimensHeight() * 3),
                            width: double.infinity,
                            child: ElevatedButtonWidget(
                              text: translate(context, 'update'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  String? email;
                                  String? bio;
                                  if (state.profile.email !=
                                      _controllerEmail.text.trim()) {
                                    email = _controllerEmail.text.trim();
                                  }
                                  if (state.profile.biography !=
                                      _controllerBio.text.trim()) {
                                    bio = _controllerBio.text.trim();
                                  }
                                  context
                                      .read<DoctorProfileCubit>()
                                      .updateProfile(bio, _file?.path, email);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
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
