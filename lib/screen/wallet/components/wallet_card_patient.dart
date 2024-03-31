import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/translate.dart';

class WalletCardPatient extends StatelessWidget {
  const WalletCardPatient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientProfileCubit, PatientProfileState>(
      builder: (context, state) {
        return SliverAppBar(
          expandedHeight: dimensHeight() * 12,
          collapsedHeight: dimensHeight() * 10,
          automaticallyImplyLeading: false,
          pinned: true,
          floating: false,
          flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double top = constraints.biggest.height;
            return FlexibleSpaceBar(
              background: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primary, color9D4B6C],
                          stops: [0, 1],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: white,
                    ),
                  )
                ],
              ),
              centerTitle: true,
              title: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: dimensWidth() * 2,
                    vertical: dimensHeight() * 0.5),
                padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth(),
                  vertical: dimensHeight(),
                ),
                width: double.infinity,
                height: dimensHeight() * 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(dimensWidth() * 2),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 15,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: top < 135,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: dimensWidth(),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.wallet,
                                color: color9D4B6C,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translate(context, 'your_balance'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: black26,
                                      ),
                                ),
                                Text(
                                  convertToVND(state.profile.accountBalance ?? 0),
                                  softWrap: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                          color: color1F1F1F,
                                          overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(thickness: 2,),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: top < 135,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: dimensWidth(),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.award,
                                color: color9D4B6C,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translate(context, 'reward_points'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: black26,
                                      ),
                                ),
                                // Text(
                                //   "${state.profile.point ?? 0}",
                                //   softWrap: true,
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .labelSmall
                                //       ?.copyWith(
                                //           color: color1F1F1F,
                                //           overflow: TextOverflow.ellipsis),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
