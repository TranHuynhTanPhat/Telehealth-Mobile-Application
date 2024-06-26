import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/requests/consultation_request.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/translate.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen(
      {super.key,
      required this.callback,
      required this.nextPage,
      required this.previousPage,
      required this.profile,
      required this.request});
  final UserResponse profile;
  final ConsultationRequest request;
  final Function(PaymentMethod) callback;
  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentMethod _payment = PaymentMethod.None;

  @override
  void initState() {
    if (!mounted) return;
    super.initState();
  }

  Future<void> showAlert() async {
    await showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: Text(
                '${translate(context, 'alert_no_money')} ${convertToVND(widget.profile.accountBalance ?? 0)}'),
            actions: <Widget>[
              TextButton(
                child:  Text(translate(context, 'recharge_now')),
                onPressed: () {
                  Navigator.pushNamed(context, payName)
                      .then((value) => Navigator.pop(context));
                  // Navigator.pop(context);
                },
              ),
              TextButton(
                child:  Text(translate(context, 'cancel')),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          )),
    ).then((value) {
      if (value == false) {
        Navigator.pop(context);
      } else {
        context.read<PatientProfileCubit>().fetchProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => widget.previousPage(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        extendBody: true,
        bottomNavigationBar: _payment != PaymentMethod.None &&
                (widget.profile.accountBalance ?? 0) >
                    (widget.request.price ?? 0)
            ? Container(
                padding: EdgeInsets.fromLTRB(dimensWidth() * 10, 0,
                    dimensWidth() * 10, dimensHeight() * 3),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white.withOpacity(0.0), white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: ElevatedButtonWidget(
                    text: translate(context, 'payment'),
                    onPressed: () {
                      widget.callback(_payment);
                      widget.nextPage();

                      // Navigator.pushNamed(context, formConsultationName)
                      //     .then((value) {
                      //   if (value == true) {
                      //     Navigator.pop(context, true);
                      //   }
                      // });
                    }),
              )
            : null,
        appBar: AppBar(
          title: Text(
            translate(context, 'payment'),
          ),
        ),
        body: AbsorbPointer(
          // absorbing: state is FetchScheduleLoading && state.schedules.isEmpty,
          absorbing: false,
          child: ListView(
            padding: EdgeInsets.symmetric(
                vertical: dimensHeight() * 3, horizontal: dimensWidth() * 3),
            children: [
              ListTile(
                title: Text(
                  translate(context, 'healthline_wallet'),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: color1F1F1F),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    dimensWidth(),
                  ),
                ),
                onTap: () async {
                  setState(() {
                    _payment = PaymentMethod.Healthline;
                  });
                  if (widget.request.price! > widget.profile.accountBalance!) {
                    await showAlert();
                  }
                },
                dense: true,
                visualDensity: const VisualDensity(vertical: 0),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: dimensWidth(),
                  vertical: dimensHeight(),
                ),
                leading: Image.asset(
                  DImages.icApp,
                  width: dimensWidth() * 4,
                  height: dimensHeight() * 4,
                ),
                trailing: Radio<PaymentMethod>(
                  value: PaymentMethod.Healthline,
                  groupValue: _payment,
                  onChanged: (PaymentMethod? value) async {
                    setState(() {
                      _payment = value ?? PaymentMethod.None;
                    });
                    if (widget.request.price! >
                        widget.profile.accountBalance!) {
                      await showAlert();
                    }
                  },
                ),
              ),
              // ListTile(
              //   title: Text(
              //     translate(context, 'momo_e_wallet'),
              //     style: Theme.of(context)
              //         .textTheme
              //         .titleMedium
              //         ?.copyWith(color: color1F1F1F),
              //   ),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(
              //       dimensWidth(),
              //     ),
              //   ),
              //   onTap: () => setState(() {
              //     _payment = PaymentMethod.Momo;
              //   }),
              //   dense: true,
              //   visualDensity: const VisualDensity(vertical: 0),
              //   contentPadding: EdgeInsets.symmetric(
              //     horizontal: dimensWidth(),
              //     vertical: dimensHeight(),
              //   ),
              //   leading: Image.asset(
              //     DImages.mono,
              //     width: dimensWidth() * 4,
              //     height: dimensHeight() * 4,
              //   ),
              //   trailing: Radio<PaymentMethod>(
              //     value: PaymentMethod.Momo,
              //     groupValue: _payment,
              //     onChanged: (PaymentMethod? value) {
              //       setState(() {
              //         _payment = value ?? PaymentMethod.None;
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
