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

  late TextEditingController _controllerGender;

  List<String> folderName = ['default'];

  @override
  void initState() {
    _file = null;
    size = 0;
    extension = '';
    fileName = '';

    _controllerGender = TextEditingController();
    super.initState();
  }

  void getFolderName(List<PatientRecordResponse> records) {
    for (var element in records) {
      if (element.folderName != null &&
          !folderName.contains(element.folderName)) {
        folderName.add(element.folderName!);
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
        translate(context, '${translate(context, 'max_file_size')}: 10MB'),
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
    return BlocBuilder<PatientRecordCubit, PatientRecordState>(
      builder: (context, state) {
        getFolderName(state.records);
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
              absorbing: false,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                        translate(context, 'upload_your_file'),
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
                                      '${translate(context, 'max_file_size')}: 10MB',
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.visible,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: secondary.withOpacity(.5)),
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
                                  _file = await FilePickerCustom().chooseFile();
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
                        if (_file != null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensHeight() * 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: MenuAnchor(
                                    style: MenuStyle(
                                      elevation:
                                          const MaterialStatePropertyAll(10),
                                      // shadowColor: MaterialStatePropertyAll(black26),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              dimensWidth() * 3),
                                        ),
                                      ),
                                      backgroundColor:
                                          const MaterialStatePropertyAll(white),
                                      surfaceTintColor:
                                          const MaterialStatePropertyAll(white),
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
                                        onTap: () {
                                          if (folderName.isNotEmpty) {
                                            if (controller.isOpen) {
                                              controller.close();
                                            } else {
                                              controller.open();
                                            }
                                          }
                                        },
                                        readOnly: false,
                                        label: translate(context, 'folder'),
                                        hint: translate(context,
                                            'choose_folder_or_enter_new_folder'),
                                        controller: _controllerGender,
                                        validate: (value) => value!.isEmpty
                                            ? translate(
                                                context, 'please_choose')
                                            : null,
                                        prefixIcon: IconButton(
                                          onPressed: null,
                                          icon: FaIcon(
                                            FontAwesomeIcons.folder,
                                            color: colorDF9F1E.withOpacity(.5),
                                          ),
                                        ),
                                      );
                                    },
                                    menuChildren: folderName
                                        .map(
                                          (e) => MenuItemButton(
                                            style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        white)),
                                            onPressed: () => setState(() {
                                              _controllerGender.text =
                                                  translate(
                                                      context, e.toLowerCase());
                                            }),
                                            child: Text(e),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_file != null && _controllerGender.text.isNotEmpty)
                          ElevatedButtonWidget(
                            text: translate(context, 'upload_file'),
                            onPressed: () {},
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
