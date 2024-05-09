import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/storage/models/consultation_notification_model.dart';
import 'package:healthline/data/storage/provider/consultation_notification_provider.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool showTrash = false;
  late List<ConsultationNotificationModel> consultationNotis;

  Future<List<ConsultationNotificationModel>> fetchNotis() async {
    consultationNotis = await ConsultationNotificationProvider().selectAll();

    consultationNotis = consultationNotis.where((element) {
      DateTime? expectedTime = convertStringToDateTime(element.time);
      if (!element.checked) {
        showTrash = false;
      }
      if (expectedTime != null) {
        if (expectedTime.subtract(const Duration(minutes: 15)).isBefore(
              DateTime.now(),
            )) {
          return true;
        }
      }
      return true;
    }).toList();
    return consultationNotis;
  }

  Future<bool> deleteAll() async {
    for (ConsultationNotificationModel noti in consultationNotis) {
      await ConsultationNotificationProvider().deleteById(noti.id);
    }
    return true;
  }

  Future<bool> checkAll() async {
    for (ConsultationNotificationModel noti in consultationNotis) {
      await ConsultationNotificationProvider()
          .update(noti.copyWith(checked: true));
    }
    showTrash = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: EdgeInsets.only(left: dimensWidth()),
          child: Text(
            translate(context, 'notification'),
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        actions: [
          InkWell(
            highlightColor: transparent,
            splashColor: transparent,
            onTap: () async {
              if (showTrash) {
                // await deleteAll();
              } else {
                await checkAll();
              }
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.only(right: dimensWidth() * 2),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(dimensWidth()),
                child: FaIcon(
                  showTrash
                      ? FontAwesomeIcons.solidTrashCan
                      : FontAwesomeIcons.check,
                  size: dimensIcon() * .8,
                  color: showTrash ? black26 : color1F1F1F,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(
              vertical: dimensHeight() * 3, horizontal: dimensWidth() * 3),
          children: [
            BlocBuilder<ApplicationUpdateCubit, ApplicationUpdateState>(
              builder: (context, state) {
                if (state is UpdateAvailable) {
                  return ListTile(
                    tileColor: Colors.green.withOpacity(.1),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: .5, color: black26),
                      borderRadius: BorderRadius.circular(
                        dimensWidth(),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, updateName);
                    },
                    dense: true,
                    visualDensity: const VisualDensity(vertical: 0),
                    title: Text(
                      translate(context, 'new_update'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    leading: FaIcon(
                      FontAwesomeIcons.circleArrowDown,
                      size: dimensIcon() * .7,
                      color: Colors.green,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            FutureBuilder(
                future: fetchNotis(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    if (consultationNotis.isNotEmpty) {
                      return Column(
                        children: consultationNotis.map((e) {
                          DateTime? expectedTime =
                              convertStringToDateTime(e.time);
                          return Column(
                            children: [
                              ListTile(
                                tileColor:
                                    e.checked ? white : primary.withOpacity(.1),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(dimensWidth())),
                                onTap: () {
                                  // Navigator.pushNamed(context, updateName);
                                  if (!e.checked) {
                                    setState(() {
                                      ConsultationNotificationProvider()
                                          .update(e.copyWith(checked: true));
                                    });
                                  }
                                },
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: dimensWidth(),
                                    vertical: dimensHeight() / 2),
                                dense: true,
                                visualDensity: const VisualDensity(vertical: 0),
                                title: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        translate(context,
                                            'you_have_an_upcoming_appointment'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    if (expectedTime != null)
                                      Text(
                                        expectedTime.isAfter(DateTime.now())
                                            ? timeComing(
                                                context,
                                                expectedTime,
                                                DateTime.now(),
                                              )
                                            : daysBetween(
                                                context,
                                                expectedTime,
                                                DateTime.now(),
                                              ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: black26),
                                      ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${e.doctorName ?? '\n'}${e.symptom ?? '\n'}${e.medicalHistory ?? ''}"),
                                  ],
                                ),
                                leading: FaIcon(
                                  FontAwesomeIcons.solidBell,
                                  size: dimensIcon() * .7,
                                  color: Colors.orangeAccent,
                                ),
                                trailing: InkWell(
                                  highlightColor: transparent,
                                  splashColor: transparent,
                                  onTap: () async {
                                    await ConsultationNotificationProvider()
                                        .deleteById(e.id);
                                    setState(() {});
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.solidTrashCan,
                                    color: black26,
                                    size: dimensIcon() * .5,
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: secondary.withOpacity(.1),
                              )
                            ],
                          );
                        }).toList(),
                      );
                    }
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: dimensHeight() * 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                translate(context, 'empty'),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                        color: color1F1F1F.withOpacity(.05),
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        FaIcon(
                          FontAwesomeIcons.boxOpen,
                          color: color1F1F1F.withOpacity(.05),
                          size: dimensWidth() * 30,
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
