import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/translate.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key, required this.callback, required this.nextPage, required this.previousPage});
  final Function(PaymentMethod) callback;
  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentMethod _payment = PaymentMethod.None;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => widget.previousPage(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        extendBody: true,
        bottomNavigationBar: _payment != PaymentMethod.None
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
                onTap: () => setState(() {
                  _payment = PaymentMethod.Healthline;
                }),
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
                  onChanged: (PaymentMethod? value) {
                    setState(() {
                      _payment = value ?? PaymentMethod.None;
                    });
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
