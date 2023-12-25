import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';

class EditContactForm extends StatefulWidget {
  const EditContactForm({
    super.key,
  });

  @override
  State<EditContactForm> createState() => _EditContactFormState();
}

class _EditContactFormState extends State<EditContactForm> {
  // late TextEditingController _controllerFullName;
  // late TextEditingController _controllerBirthday;
  // late TextEditingController _controllerGender;
  late TextEditingController _controllerEmail;
  // late TextEditingController _controllerAddress;
  late TextEditingController _controllerPhone;

  // late File? _file;

  late String gender;

  final _formKey = GlobalKey<FormState>();

  List<String> genders = ['Male', 'Female'];

  @override
  void initState() {
    // _controllerFullName = TextEditingController();
    // _controllerBirthday = TextEditingController();
    // _controllerGender = TextEditingController();
    _controllerEmail = TextEditingController();
    // _controllerAddress = TextEditingController();
    _controllerPhone = TextEditingController();

    gender = genders.last;

    // _file = null;

    super.initState();
  }

  // getFile() async {
  //   FilePickerResult? result = await FilePicker.platform
  //       .pickFiles(type: FileType.image, allowMultiple: false);

  //   if (result != null) {
  //     final file = File(result.files.single.path!);
  //     _file = file;
  //     setState(() {});
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Please select file'),
  //     ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientProfileCubit, PatientProfileState>(
        builder: (context, state) {
      state.profile.phone != null
          ? _controllerPhone.text = state.profile.phone!.replaceFirst('+84', '')
          : '';
      _controllerEmail.text = state.profile.email ?? '';
      return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: dimensHeight() * 3, top: dimensHeight() * 2),
              child: TextFieldWidget(
                readOnly: true,
                validate: (value) {
                  // return Validate()
                  //     .validatePhone(context, _controllerPhone.text);
                  return null;
                },
                prefix: Padding(
                  padding: EdgeInsets.only(right: dimensWidth() * .5),
                  child: Text(
                    '+84',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                controller: _controllerPhone,
                label: translate(context, 'phone'),
                textInputType: TextInputType.phone,
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       vertical: dimensHeight(),
            //       horizontal: dimensWidth() * 3),
            //   child: TextFieldWidget(
            //       label: translate(context, 'full_name'),
            //       hint: translate(context, 'ex_full_name'),
            //       controller: _controllerFullName,
            //       validate: (value) => value!.isEmpty
            //           ? translate(
            //               context, 'please_enter_full_name')
            //           : null),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       vertical: dimensHeight(),
            //       horizontal: dimensWidth() * 3),
            //   child: TextFieldWidget(
            //     onTap: () async {
            //       DateTime? date = await showDatePicker(
            //           initialEntryMode: DatePickerEntryMode
            //               .calendarOnly,
            //           initialDatePickerMode: DatePickerMode.day,
            //           context: context,
            //           initialDate:
            //               _controllerBirthday.text.isNotEmpty
            //                   ? DateFormat('dd/MM/yyyy')
            //                       .parse(_controllerBirthday.text)
            //                   : DateTime.now(),
            //           firstDate: DateTime(1900),
            //           lastDate: DateTime.now());
            //       if (date != null) {
            //         _controllerBirthday.text =
            //             // ignore: use_build_context_synchronously
            //             formatDayMonthYear(context, date);
            //       }
            //     },
            //     readOnly: true,
            //     label: translate(context, 'birthday'),
            //     // hint: translate(context, 'ex_full_name'),
            //     controller: _controllerBirthday,
            //     validate: (value) => value!.isEmpty
            //         ? translate(context, 'please_choose_day_of_birth')
            //         : null,
            //     suffixIcon: const IconButton(
            //         onPressed: null,
            //         icon: FaIcon(FontAwesomeIcons.calendar)),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       vertical: dimensHeight(),
            //       horizontal: dimensWidth() * 3),
            //   child: MenuAnchor(
            //     style: MenuStyle(
            //       elevation: const MaterialStatePropertyAll(10),
            //       // shadowColor: MaterialStatePropertyAll(black26),
            //       shape: MaterialStateProperty.all<
            //           RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(
            //               dimensWidth() * 3),
            //         ),
            //       ),
            //       backgroundColor:
            //           const MaterialStatePropertyAll(white),
            //       surfaceTintColor:
            //           const MaterialStatePropertyAll(white),
            //       padding: MaterialStatePropertyAll(
            //           EdgeInsets.only(
            //               right: dimensWidth() * 25,
            //               left: dimensWidth() * 2,
            //               top: dimensHeight(),
            //               bottom: dimensHeight())),
            //     ),
            //     builder: (BuildContext context,
            //         MenuController controller, Widget? child) {
            //       return TextFieldWidget(
            //         onTap: () {
            //           if (controller.isOpen) {
            //             controller.close();
            //           } else {
            //             controller.open();
            //           }
            //         },
            //         readOnly: true,
            //         label: translate(context, 'gender'),
            //         // hint: translate(context, 'ex_full_name'),
            //         controller: _controllerGender,
            //         validate: (value) => value!.isEmpty
            //             ? translate(
            //                 context, 'please_choose_gender')
            //             : null,
            //         suffixIcon: const IconButton(
            //             onPressed: null,
            //             icon: FaIcon(FontAwesomeIcons.caretDown)),
            //       );
            //     },
            //     menuChildren: genders
            //         .map(
            //           (e) => MenuItemButton(
            //             style: const ButtonStyle(
            //                 backgroundColor:
            //                     MaterialStatePropertyAll(white)),
            //             onPressed: () => setState(() {
            //               _controllerGender.text =
            //                   translate(context, e.toLowerCase());
            //               gender = e;
            //             }),
            //             child: Text(
            //               translate(context, e.toLowerCase()),
            //             ),
            //           ),
            //         )
            //         .toList(),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * 3),
              child: TextFieldWidget(
                  readOnly: state.blocState == BlocState.Pending,
                  label: translate(context, 'email'),
                  hint: translate(context, 'ex_email'),
                  controller: _controllerEmail,
                  validate: (value) =>
                      Validate().validateEmail(context, value)),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       vertical: dimensHeight(),
            //       horizontal: dimensWidth() * 3),
            //   child: TextFieldWidget(
            //     label: translate(context, 'address'),
            //     // hint: translate(context, 'ex_email'),
            //     controller: _controllerAddress,
            //     validate: (value) => null,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * 3),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButtonWidget(
                  text: translate(context, 'update_information'),
                  onPressed: _controllerEmail.text.trim() != state.profile.email
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            context
                                .read<PatientProfileCubit>()
                                .updateEmail(_controllerEmail.text.trim());
                          }
                        }
                      : null,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
