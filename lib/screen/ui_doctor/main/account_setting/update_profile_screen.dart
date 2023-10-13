import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class UpdateBiographyScreen extends StatefulWidget {
  const UpdateBiographyScreen({super.key});

  @override
  State<UpdateBiographyScreen> createState() => _UpdateBiographyScreenState();
}

class _UpdateBiographyScreenState extends State<UpdateBiographyScreen> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorProfileCubit, DoctorProfileState>(
      listenWhen: (previous, current) => current is DoctorBiographyState,
      listener: (context, state) {
        if (state is DoctorBiographyError) {
          EasyLoading.showToast(
            translate(
              context,
              state.message.toString().toLowerCase(),
            ),
          );
        } else if (state is DoctorBiographyUpdating) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
        } else if (state is DoctorBiographySuccessfully) {
          EasyLoading.showToast(translate(context, 'successfully'));
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
              _controller.text = _controller.text.isEmpty
                  ? state.profile?.biography ?? ''
                  : _controller.text;

              return AbsorbPointer(
                absorbing: state is DoctorBiographyUpdating,
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensWidth() * 3,
                      vertical: dimensHeight() * 2),
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFieldWidget(
                            label: translate(context, 'biography'),
                            controller: _controller,
                            validate: (value) {
                              if (value!.split(' ').length < 100) {
                                return translate(context,
                                    'biography_must_be_at_least_100_words');
                              }
                              return null;
                            },
                            maxLine: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: dimensHeight() * 1.5),
                            width: double.infinity,
                            child: ElevatedButtonWidget(
                              text: translate(context, 'update'),
                              onPressed: _controller.text !=
                                      state.profile?.biography
                                  ? () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        context
                                            .read<DoctorProfileCubit>()
                                            .updateBio(_controller.text);
                                      }
                                    }
                                  : null,
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
