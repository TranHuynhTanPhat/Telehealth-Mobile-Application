import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/translate.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
          Container(
            padding: EdgeInsets.only(right: dimensWidth() * 2),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(dimensWidth()),
              child: FaIcon(
                FontAwesomeIcons.check,
                size: dimensIcon() * .8,
                color: color1F1F1F,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: BlocBuilder<ApplicationUpdateCubit, ApplicationUpdateState>(
          builder: (context, state) {
            if (state is UpdateAvailable) {
              return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(
                    vertical: dimensHeight() * 3,
                    horizontal: dimensWidth() * 3),
                children: [
                  ListTile(
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
                  )
                ],
              );
            } else {
              return Center(
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
                    // SizedBox(
                    //   height: dimensHeight() * 3,
                    // ),
                    FaIcon(
                      FontAwesomeIcons.boxOpen,
                      color: color1F1F1F.withOpacity(.05),
                      size: dimensWidth() * 30,
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
