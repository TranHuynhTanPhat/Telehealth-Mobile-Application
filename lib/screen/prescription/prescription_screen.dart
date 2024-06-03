import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_prescription/prescription_cubit.dart';
import 'package:healthline/data/api/models/responses/prescription_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/prescription/components/export.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key, required this.consultationId});
  final String? consultationId;

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  @override
  void initState() {
    if (!mounted) return;
    if (widget.consultationId != null) {
      context
          .read<PrescriptionCubit>()
          .fetchPrescription(consultationId: widget.consultationId!);
    } else {
      return;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: white,
        appBar: AppBar(
          title: Text(
            translate(context, 'prescription'),
          ),
        ),
        body: BlocBuilder<PrescriptionCubit, PrescriptionState>(
          builder: (context, state) {
            if (state is FetchPrescriptionState) {
              if (state.blocState == BlocState.Failed) {
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.pop(context, addPrescriptionName);
                });
                return const SizedBox();
              } else if (state.blocState == BlocState.Successed) {
                if (state.data == null) {
                  Navigator.pop(context, addPrescriptionName);
                  return Container();
                } else {
                  return ListView(
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
                              state.data?.id ?? translate(context, 'undifine'),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translate(context, "created_at")}: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          Expanded(
                            child: Text(
                              formatDayMonthYear(
                                  context,
                                  convertStringToDateTime(
                                          state.data?.createdAt) ??
                                      DateTime.now()),
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
                              state.data?.patientName ?? "",
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
                              state.data?.patientAddress ??
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
                              state.data?.gender ??
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
                              state.data?.doctorName ??
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
                            "${translate(context, "diagnosis")}: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          Expanded(
                            child: Text(
                              state.data?.diagnosis ?? "",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: black26,
                        height: dimensHeight() * 5,
                      ),

                      ...state.data!.drugs!.map(
                        (e) {
                          if (state.data!.drugs?.length == 1) {
                            return InkWell(
                              onTap: () async {
                                if (e.code != null) {
                                  await showDetailDrug(context, drug: e);
                                }
                              },
                              child: DrugCardNone(
                                  widget: ContentDrug(
                                index: 1,
                                drugModal: e,
                              )),
                            );
                          }
                          int index = state.data!.drugs!.indexWhere(
                                  (element) => element.code == e.code) +
                              1;
                          if (state.data?.drugs?.first == e) {
                            return InkWell(
                              onTap: () async {
                                if (e.code != null) {
                                  await showDetailDrug(context, drug: e);
                                }
                              },
                              child: DrugCardTop(
                                  widget: ContentDrug(
                                index: index,
                                drugModal: e,
                              )),
                            );
                          } else if (state.data?.drugs?.last == e) {
                            return InkWell(
                              onTap: () async {
                                if (e.code != null) {
                                  await showDetailDrug(context, drug: e);
                                }
                              },
                              child: DrugCardBottom(
                                  widget: ContentDrug(
                                index: index,
                                drugModal: e,
                              )),
                            );
                          }
                          return InkWell(
                            onTap: () async {
                              if (e.code != null) {
                                await showDetailDrug(context, drug: e);
                              }
                            },
                            child: DrugCardMid(
                                widget: ContentDrug(
                              index: index,
                              drugModal: e,
                            )),
                          );
                        },
                      ),
                      // DrugCardTop(),
                      // DrugCardMid(),
                      // DrugCardBottom(),
                      SizedBox(
                        height: dimensHeight() * 3,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translate(context, "notice")}: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          Expanded(
                            child: Text(
                              state.data?.notice ?? translate(context, 'empty'),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }
              } else if (state.blocState == BlocState.Pending) {
                return Column(
                  children: [
                    buildShimmer(),
                  ],
                );
              }
            }
            return const SizedBox.shrink();
          },
        ));
  }

  Future<dynamic> showDetailDrug(BuildContext context,
      {required DrugModal drug}) async {
    context.read<PrescriptionCubit>().getInfoDrug(id: drug.code!);
    final prescriptionCubit = context.read<PrescriptionCubit>();
    return await showDialog(
      barrierColor: black26,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: transparent,
        elevation: 0,
        iconPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: FaIcon(
              FontAwesomeIcons.circleXmark,
              color: white,
              size: dimensIcon(),
            ),
          )
        ],
        content: SingleChildScrollView(
          child: BlocProvider.value(
            value: prescriptionCubit,
            child: Container(
              color: transparent,
              width: MediaQuery.of(context).size.width - dimensWidth() * 5,
              child: ListBody(
                children: [
                  DrugCardTop(
                    widget: ContentDrug(
                      drugModal: drug,
                      index: null,
                    ),
                  ),
                  DrugCardBottom(
                    widget: BlocBuilder<PrescriptionCubit, PrescriptionState>(
                      bloc: prescriptionCubit,
                      builder: (context, state) {
                        if (state is GetInfoDrugState) {
                          if (state.blocState == BlocState.Successed &&
                              state.data != null) {
                            List<String> hoatChat =
                                state.data!.hoatChat?.split(";") ?? [];
                            List<String>? nongDo =
                                state.data!.nongDo?.split(";") ?? [];

                            String x = "";
                            for (int i = 0; i < hoatChat.length; i++) {
                              if (i < nongDo.length) {
                                x +=
                                    ("${hoatChat[i].trim()}-${nongDo[i].trim()};");
                              }
                            }

                            return ListBody(
                              children: [
                                Row(
                                  children: [
                                    Text("${translate(context, "drug_name")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.tenThuoc ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Số quyết định")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.soQuyetDinh ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Ngày phê duyệt")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.pheDuyet ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Hoạt chât - nồng độ")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(x,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("${translate(context, "Tá dược")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.taDuoc ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Dạng bào chế")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.baoChe ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("${translate(context, "Đóng gói")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.dongGoi ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Tiêu chuẩn")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.tieuChuan ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("${translate(context, "Tuổi thọ")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.tuoiTho ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Công ty sản xuất")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.congTySx ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Quốc gia sản xuất")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.nuocSx ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Nhóm thuốc")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.nhomThuoc ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Địa chỉ đăng ký:")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.diaChiDk ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Địa chỉ sản xuất")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.diaChiSx ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        }
                        return Center(
                          child: Text(
                            translate(context, "detail"),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: white),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).then((value) => prescriptionCubit.fetchPrescription(
        consultationId: widget.consultationId!));
  }
}

Widget buildShimmer() => ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: dimensWidth() * 3,
        vertical: dimensHeight() * 2,
      ),
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensHeight() * 2,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: dimensHeight() * 2, right: dimensWidth() * 20),
          child: ShimmerWidget.rectangular(
            height: dimensHeight() * 2,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensHeight() * 2,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: dimensHeight(), right: dimensWidth() * 30),
          child: ShimmerWidget.rectangular(
            height: dimensHeight() * 2,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: dimensHeight() * 2, right: dimensWidth() * 30),
          child: ShimmerWidget.rectangular(
            height: dimensHeight() * 2,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensHeight() * 2,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensHeight() * 2,
          ),
        ),
        Divider(
          thickness: 2,
          color: black26,
          height: dimensHeight() * 5,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: dimensHeight()),
          child: ShimmerWidget.rectangular(
            height: dimensHeight() * 14,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: dimensHeight(), right: dimensWidth() * 30),
          child: ShimmerWidget.rectangular(
            height: dimensHeight() * 2,
          ),
        ),
      ],
    );


// Container(
//       margin: EdgeInsets.fromLTRB(
//           dimensWidth() * 3, dimensHeight() * 2, dimensWidth() * 3, 0),
//       padding: EdgeInsets.all(dimensWidth() * 2),
//       decoration: BoxDecoration(
//         color: white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(.1),
//             spreadRadius: dimensWidth() * .4,
//             blurRadius: dimensWidth() * .4,
//           ),
//         ],
//         borderRadius: BorderRadius.circular(dimensWidth() * 3),
//         border: Border.all(color: colorA8B1CE.withOpacity(.2), width: 2),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               ShimmerWidget.circular(
//                 width: dimensWidth() * 7,
//                 height: dimensWidth() * 7,
//               ),
//               SizedBox(
//                 width: dimensWidth() * 2.5,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ShimmerWidget.rectangular(height: dimensHeight() * 2.5),
//                     SizedBox(
//                       height: dimensHeight(),
//                     ),
//                     ShimmerWidget.rectangular(height: dimensHeight() * 1.5),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: dimensHeight(),
//           ),
//           ShimmerWidget.rectangular(height: dimensHeight() * 10)
//         ],
//       ),
//     );
