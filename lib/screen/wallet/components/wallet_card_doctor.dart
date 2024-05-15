import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/translate.dart';

class WalletCardDoctor extends StatelessWidget {
  const WalletCardDoctor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        return SliverAppBar(
          expandedHeight: dimensHeight() * 35,
          collapsedHeight: dimensHeight() * 20,
          automaticallyImplyLeading: true,
          pinned: true,
          floating: false,
          actions: null,
          leading: null,
          flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            double top = constraints.biggest.height;
            return FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              background: Column(
                children: [
                  Expanded(
                    flex: 6,
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
                    flex: 2,
                    child: Container(
                      color: white,
                    ),
                  )
                ],
              ),
              centerTitle: true,
              title: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 3,
                        vertical: dimensHeight() * 3),
                    child: Text(
                      translate(context, 'budget'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
                    padding: EdgeInsets.symmetric(
                      horizontal: dimensWidth() * 2.5,
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
                              Padding(
                                padding: EdgeInsets.only(
                                  right: dimensWidth(),
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.wallet,
                                  color: color9D4B6C,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: top > 145,
                                      child: Text(
                                        translate(context, 'your_balance'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: black26,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      convertToVND(
                                          state.profile.accountBalance ?? 0),
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
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
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
