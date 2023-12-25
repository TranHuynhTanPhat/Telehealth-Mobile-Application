import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_patient_record/patient_record_cubit.dart';
import 'package:healthline/data/api/models/responses/patient_record_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/file_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/file_picker.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class AddPatientRecordScreen extends StatefulWidget {
  const AddPatientRecordScreen({super.key});

  @override
  State<AddPatientRecordScreen> createState() => _AddPatientRecordScreenState();
}

class _AddPatientRecordScreenState extends State<AddPatientRecordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late PlatformFile? _file;
  late int size;
  late String extension;
  late String fileName;

  late TextEditingController _controllerfolderNames;

  List<String> folderNames = [];

  @override
  void initState() {
    _file = null;
    size = 0;
    extension = '';
    fileName = '';

    _controllerfolderNames = TextEditingController();
    super.initState();
  }

  void getfolderNames(List<PatientRecordResponse> records) {
    for (var element in records) {
      if (element.folder != null &&
          !folderNames.contains(element.folder) &&
          element.folder != 'default') {
        folderNames.add(element.folder!);
      }
    }
  }

  Future<void> chooseFile(BuildContext context) async {
    _file = await FilePickerCustom().chooseFile();
    double sizeInMb = _file!.size / (1024 * 1024);
    if (sizeInMb > 10) {
      _file = null;
      if (!mounted) return;
      EasyLoading.showToast(
        translate(context, '${translate(context, 'max_file_size')}: 10 MB'),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_file != null) {
      size = _file?.size ?? 0;
      extension = _file?.extension ?? '';
      fileName = _file?.name ?? '';
    }
    return BlocListener<PatientRecordCubit, PatientRecordState>(
      listener: (context, state) {
        if (state is AddPatientRecordLoaded) {
          EasyLoading.showToast(translate(context, 'successfully'));
          Navigator.pop(context, true);
        }
      },
      child: BlocBuilder<PatientRecordCubit, PatientRecordState>(
        builder: (context, state) {
          getfolderNames(state.records);
          return GestureDetector(
            onTap: () {
              KeyboardUtil.hideKeyboard(context);
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  translate(context, 'add_patient_record'),
                ),
              ),
              body: AbsorbPointer(
                absorbing: state is AddPatientRecordLoading,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(
                      vertical: dimensHeight() * 3,
                      horizontal: dimensWidth() * 3),
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_file == null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dimensHeight()),
                                  child: FaIcon(
                                    FontAwesomeIcons.cloudArrowUp,
                                    size: dimensWidth() * 20,
                                    color: primary.withOpacity(.6),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dimensHeight()),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          translate(
                                              context, 'upload_your_file'),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w900,
                                                  color: secondary),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dimensHeight()),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          translate(context,
                                              'browse_and_choose_the_file_you_want_to_upload'),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: secondary),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${translate(context, 'max_file_size')}: 10 MB',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.visible,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    secondary.withOpacity(.5)),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dimensHeight() * 3),
                                  child: ElevatedButtonWidget(
                                    text: translate(context, 'choose_file'),
                                    onPressed: () async {
                                      await chooseFile(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          if (_file != null)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        translate(context, 'file'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: FileWidget(
                                      extension: extension,
                                      title: fileName,
                                    )),
                                    IconButton(
                                      onPressed: () async {
                                        _file = await FilePickerCustom()
                                            .chooseFile();
                                        setState(() {});
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.arrowsRotate,
                                        size: dimensIcon() * .7,
                                        color: primary,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: dimensHeight() * 3),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          translate(context,
                                              'enter_folder_name_or_default'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (_file != null)
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: MenuAnchor(
                                          style: MenuStyle(
                                            fixedSize: MaterialStatePropertyAll(
                                                Size.fromHeight(
                                                    dimensHeight() * 30)),
                                            elevation:
                                                const MaterialStatePropertyAll(
                                                    10),
                                            // shadowColor: MaterialStatePropertyAll(black26),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        dimensWidth() * 3),
                                              ),
                                            ),
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    white),
                                            surfaceTintColor:
                                                const MaterialStatePropertyAll(
                                                    white),
                                            padding: MaterialStatePropertyAll(
                                              EdgeInsets.symmetric(
                                                horizontal: dimensWidth() * 2,
                                                vertical: dimensHeight(),
                                              ),
                                            ),
                                          ),
                                          builder: (BuildContext context,
                                              MenuController controller,
                                              Widget? child) {
                                            return TextFieldWidget(
                                              onChanged: (value) =>
                                                  _controllerfolderNames.text =
                                                      _controllerfolderNames
                                                          .text
                                                          .replaceAll('/', ''),
                                              onTap: () {
                                                if (folderNames.isNotEmpty) {
                                                  if (controller.isOpen) {
                                                    controller.close();
                                                  } else {
                                                    controller.open();
                                                  }
                                                }
                                              },
                                              enabledBorderColor: transparent,
                                              focusedBorderColor: transparent,
                                              readOnly: false,
                                              // label: translate(context, 'folder'),
                                              hint:
                                                  translate(context, 'default'),
                                              controller:
                                                  _controllerfolderNames,
                                              validate: (value) => value!
                                                      .isEmpty
                                                  ? translate(
                                                      context, 'please_choose')
                                                  : null,
                                              prefixIcon: IconButton(
                                                onPressed: null,
                                                icon: FaIcon(
                                                  controller.isOpen
                                                      ? FontAwesomeIcons
                                                          .folderOpen
                                                      : FontAwesomeIcons
                                                          .solidFolder,
                                                  color: colorDF9F1E,
                                                ),
                                              ),
                                            );
                                          },
                                          menuChildren: folderNames
                                              .map(
                                                (e) => MenuItemButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              white)),
                                                  onPressed: () => setState(() {
                                                    _controllerfolderNames
                                                        .text = e;
                                                  }),
                                                  child: Row(
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .solidFolder,
                                                        color: colorDF9F1E,
                                                        size: dimensIcon() * .5,
                                                      ),
                                                      SizedBox(
                                                        width: dimensWidth(),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            right:
                                                                dimensWidth() *
                                                                    2),
                                                        child: Text(
                                                          e,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: dimensHeight() * 3),
                                  child: ElevatedButtonWidget(
                                    text: translate(context, 'upload_file'),
                                    onPressed: () {
                                      KeyboardUtil.hideKeyboard(context);
                                      context
                                          .read<PatientRecordCubit>()
                                          .addPatientRecord(
                                              _file!.path!,
                                              _controllerfolderNames
                                                      .text.isNotEmpty
                                                  ? _controllerfolderNames.text
                                                  : null,
                                              size);
                                    },
                                  ),
                                )
                              ],
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
