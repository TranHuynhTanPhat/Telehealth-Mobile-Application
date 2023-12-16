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
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
              vertical: dimensHeight() * 4, horizontal: dimensWidth() * 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dimensWidth() * 3),
            gradient: const LinearGradient(
              colors: [primary, color9D4B6C],
              stops: [0, 1],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FaIcon(
                    FontAwesomeIcons.hospital,
                    size: dimensIcon() * .5,
                    color: white,
                  ),
                  SizedBox(
                    width: dimensWidth() * .5,
                  ),
                  Text(
                    translate(context, 'Healthline'),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: white, fontWeight: FontWeight.w400, height: 0),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: dimensHeight() , bottom: dimensHeight() * 5),
                child: Text(
                  state.profile.fullName ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: white, fontWeight: FontWeight.w900),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FaIcon(
                    FontAwesomeIcons.wallet,
                    size: dimensIcon() * 1,
                    color: white,
                  ),
                  Text(
                    convertToVND(state.profile.accountBalance ?? 0),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: white, fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
