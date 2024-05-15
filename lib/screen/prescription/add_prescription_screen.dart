import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/responses/drug_response.dart';
import 'package:healthline/data/api/models/responses/prescription_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/prescription/components/export.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AddPrescriptionScreen extends StatefulWidget {
  const AddPrescriptionScreen(
      {super.key, required this.prescriptionResponse, this.consultationId});
  final PrescriptionResponse? prescriptionResponse;
  final String? consultationId;

  @override
  State<AddPrescriptionScreen> createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  late PrescriptionResponse prescriptionResponse;
  late List<DrugModal> drugModal;
  late TextEditingController _controllerDiagnose;
  late TextEditingController _controllerNotice;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (!mounted) return;
    if (widget.prescriptionResponse == null || widget.consultationId == null) {
      return;
    }
    prescriptionResponse = widget.prescriptionResponse!;
    prescriptionResponse = prescriptionResponse.copyWith(
        patientAddress: prescriptionResponse.patientAddress ?? "empty",
        gender: prescriptionResponse.gender ?? "Male",
        diagnosis: prescriptionResponse.diagnosis ?? "",
        notice: prescriptionResponse.notice ?? "");
    drugModal = [];
    _controllerDiagnose = TextEditingController();
    _controllerNotice = TextEditingController();
    super.initState();
  }

  Future<void> modelBottomSheet({DrugModal? drug}) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        ConsultationCubit consultationCubit = context.read<ConsultationCubit>();
        return DraggableScrollableSheet(
          expand: false,
          minChildSize: .2,
          maxChildSize: .9,
          initialChildSize: .9,
          shouldCloseOnMinExtent: true,
          builder: (BuildContext context, ScrollController scrollController) {
            return BlocProvider.value(
              value: consultationCubit,
              child: GestureDetector(
                onTap: () => KeyboardUtil.hideKeyboard(context),
                child: FormAddDrug(
                  drug: drug,
                ),
              ),
            );
          },
        );
      },
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: true,
    ).then((value) {
      if (value is DrugModal) {
        int i = drugModal.indexWhere((element) => element.code == value.code);
        if (i == -1) {
          drugModal.add(value);
        } else {
          drugModal[i] = value;
        }
      } else if (value == "delete") {
        drugModal.removeWhere((element) => element.code == drug?.code);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: BlocConsumer<ConsultationCubit, ConsultationState>(
        listener: (context, state) {
          if (state is CreatePrescriptionState) {
            if (state.blocState == BlocState.Successed) {
              Navigator.pop(context);
            }
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state.blocState == BlocState.Pending &&
                state is CreatePrescriptionState,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                extendBody: true,
                backgroundColor: white,
                appBar: AppBar(
                  title: Text(
                    translate(context, 'prescription'),
                  ),
                ),
                body: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 3,
                        vertical: dimensHeight() * 2),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translate(context, "prescription_code")}: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          Expanded(
                            child: Text(
                              prescriptionResponse.id ??
                                  translate(context, 'undifine'),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translate(context, "Ngày tạo")}: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          Expanded(
                            child: Text(
                              prescriptionResponse.createdAt ??
                                  translate(context, 'undefine'),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: dimensHeight() * 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translate(context, "patient")}: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                          Expanded(
                            child: Text(
                              prescriptionResponse.patientName ?? "",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translate(context, "address")}: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                          Expanded(
                            child: Text(
                              prescriptionResponse.patientAddress ??
                                  translate(context, 'undefine'),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translate(context, "gender")}: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          Expanded(
                            child: Text(
                              prescriptionResponse.gender ??
                                  translate(context, 'orther'),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: dimensHeight() * 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translate(context, "doctor")}: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          Expanded(
                            child: Text(
                              prescriptionResponse.doctorName ??
                                  translate(context, 'undefine'),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: dimensHeight() * 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translate(context, "diagnosis")}: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: dimensHeight()),
                            child: TextFieldWidget(
                              validate: (value) => value == null ||
                                      value.isEmpty ||
                                      _controllerDiagnose.text == ""
                                  ? translate(context, "invalid")
                                  : null,
                              controller: _controllerDiagnose,
                              hint: translate(context, 'diagnosis'),
                              textInputType: TextInputType.multiline,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLine: 5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: dimensHeight() * 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translate(context, "notice")}: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: dimensHeight()),
                            child: TextFieldWidget(
                              validate: (value) => null,
                              controller: _controllerNotice,
                              hint: translate(context, 'notice'),
                              textInputType: TextInputType.multiline,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLine: 5,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: black26,
                        height: dimensHeight() * 5,
                      ),
                      ...drugModal.map((e) {
                        if (drugModal.length == 1) {
                          return InkWell(
                            onTap: () => modelBottomSheet(drug: e),
                            child: DrugCardNone(
                                widget: ContentDrug(
                              index: 1,
                              drugModal: e,
                            )),
                          );
                        } else {
                          int index = drugModal.indexWhere(
                                  (element) => element.code == e.code) +
                              1;
                          if (drugModal.first == e) {
                            return InkWell(
                              onTap: () => modelBottomSheet(drug: e),
                              child: DrugCardTop(
                                  widget: ContentDrug(
                                index: index,
                                drugModal: e,
                              )),
                            );
                          } else if (drugModal.last == e) {
                            return DrugCardBottom(
                                widget: ContentDrug(
                              index: index,
                              drugModal: e,
                            ));
                          }
                          return DrugCardMid(
                              widget: ContentDrug(
                            index: index,
                            drugModal: e,
                          ));
                        }
                      }),
                      SizedBox(
                        height: dimensHeight() * 3,
                      ),
                      InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        onTap: () {
                          modelBottomSheet();
                        },
                        child: DrugCardNone(
                          widget: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensHeight() * 3),
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: dimensHeight() * 3),
                        child: ElevatedButtonWidget(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<ConsultationCubit>()
                                  .createPrescription(
                                      prescriptionResponse:
                                          prescriptionResponse.copyWith(
                                              drugs: drugModal,
                                              diagnosis:
                                                  _controllerDiagnose.text,
                                              notice: _controllerNotice.text),
                                      consultationId: widget.consultationId!);
                            }
                          },
                          text: translate(context, 'create'),
                        ),
                      )
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}

class FormAddDrug extends StatefulWidget {
  const FormAddDrug({super.key, this.drug});
  final DrugModal? drug;

  @override
  State<FormAddDrug> createState() => _FormAddDrugState();
}

class _FormAddDrugState extends State<FormAddDrug> {
  final PagingController<int, DrugResponse> _pagingController =
      PagingController(firstPageKey: -2, invisibleItemsThreshold: 5);
  final TextEditingController _controllerDrugName = TextEditingController();
  final TextEditingController _controllerNote = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  static const _pageSize = 20;
  DrugModal drugModal = DrugModal();

  @override
  void initState() {
    if (!mounted) return;
    drugModal = widget.drug ?? DrugModal();
    if (widget.drug != null) {
      _controllerDrugName.text = drugModal.name ?? "";
      _controllerNote.text = drugModal.note ?? "";
      _controllerQuantity.text = "${drugModal.quantity ?? 0}";
    }
    _pagingController.addPageRequestListener((pageKey) {
      context.read<ConsultationCubit>().searchDrug(
            key: _controllerDrugName.text.trim(),
            pageKey: pageKey + 1,
            callback: (drugs) => updateDate(drugs: drugs, pageKey: pageKey),
          );
    });
    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              translate(context, 'cant_load_data'),
            ),
            action: SnackBarAction(
              label: translate(context, 'retry'),
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
    super.initState();
  }

  void updateDate({required List<DrugResponse> drugs, required int pageKey}) {
    final isLastPage = drugs.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(drugs);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(drugs, nextPageKey);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConsultationCubit, ConsultationState>(
      listener: (context, state) {
        EasyLoading.dismiss();
      },
      child: GestureDetector(
        onTap: () => KeyboardUtil.hideKeyboard(context),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: transparent,
          extendBody: true,
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3, vertical: dimensHeight()),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  dimensWidth() * 4,
                ),
                topRight: Radius.circular(dimensWidth() * 4),
              ),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: false,
                padding: EdgeInsets.symmetric(vertical: dimensHeight() * 3),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                    child: TextFieldWidget(
                      validate: (value) => null,
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (context) => Container(
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(
                                        dimensWidth() * 2),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: dimensWidth() * 3,
                                      vertical: dimensHeight() * 10),
                                  padding: EdgeInsets.symmetric(
                                    vertical: dimensHeight() * 2,
                                  ),
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverAppBar(
                                        pinned: true,
                                        floating: true,
                                        automaticallyImplyLeading: false,
                                        backgroundColor: white,
                                        elevation: 0,
                                        scrolledUnderElevation: 0,
                                        title: TextFieldWidget(
                                          fillColor: white,
                                          validate: (value) => null,
                                          hint: translate(context, 'drug_name'),
                                          controller: _controllerDrugName,
                                          onChanged: (value) => Future.delayed(
                                              const Duration(seconds: 2), () {
                                            if (value ==
                                                _controllerDrugName.text
                                                    .trim()) {
                                              _pagingController.refresh();
                                            }
                                          }),
                                        ),
                                      ),
                                      // SliverToBoxAdapter(
                                      //   child:
                                      // ),
                                      PagedSliverList<int, DrugResponse>(
                                        // prototypeItem: buildShimmer(),
                                        pagingController: _pagingController,
                                        builderDelegate:
                                            PagedChildBuilderDelegate<
                                                    DrugResponse>(
                                                itemBuilder:
                                                    (context, item, index) {
                                          List<String> hoatChat =
                                              item.hoatChat?.split(";") ?? [];
                                          List<String>? nongDo =
                                              item.nongDo?.split(";") ?? [];

                                          String x = "";
                                          for (int i = 0;
                                              i < hoatChat.length;
                                              i++) {
                                            if (i < nongDo.length) {
                                              x +=
                                                  ("${hoatChat[i].trim()}-${nongDo[i].trim()};");
                                            }
                                          }

                                          return ListTile(
                                            onTap: () {
                                              _controllerDrugName.text =
                                                  item.tenThuoc.toString();
                                              drugModal = drugModal.copyWith(
                                                  code: item.id,
                                                  name: item.tenThuoc,
                                                  type: item.baoChe);
                                              Navigator.pop(context);
                                            },
                                            title: Text(
                                              item.tenThuoc ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                            subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(x),
                                                  Text(item.baoChe ?? ""),
                                                  Text(item.dongGoi ?? ""),
                                                ]),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ));
                      },
                      readOnly: true,
                      hint: translate(context, 'drug_name'),
                      label: translate(context, 'drug_name'),
                      controller: _controllerDrugName,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                    child: TextFieldWidget(
                        textInputType: TextInputType.number,
                        validate: (value) {
                          int? x = int.tryParse(value.toString());
                          if (x == null || x <= 0) {
                            return translate(context, 'invalid');
                          }
                          return null;
                        },
                        hint: translate(context, 'quantity'),
                        label: translate(context, 'quantity'),
                        controller: _controllerQuantity,
                        autovalidateMode: AutovalidateMode.onUserInteraction),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                    child: TextFieldWidget(
                        validate: (value) => null,
                        hint: translate(context, 'notice'),
                        label: translate(context, 'notice'),
                        controller: _controllerNote,
                        textInputType: TextInputType.multiline,
                        maxLine: 3,
                        autovalidateMode: AutovalidateMode.onUserInteraction),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                      child: ElevatedButtonWidget(
                        text: translate(
                            context, widget.drug != null ? 'update' : 'add'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            drugModal = drugModal.copyWith(
                                note: _controllerNote.text,
                                quantity:
                                    int.tryParse(_controllerQuantity.text) ??
                                        1);
                            Navigator.pop(context, drugModal);
                          }
                        },
                      )),
                  if (widget.drug != null)
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                        child: ElevatedButtonWidget(
                          color: Colors.redAccent,
                          text: translate(context, 'delete'),
                          onPressed: () {
                            Navigator.pop(context, "delete");
                          },
                        )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
