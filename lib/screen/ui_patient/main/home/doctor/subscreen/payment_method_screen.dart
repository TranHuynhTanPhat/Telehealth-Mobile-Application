import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/translate.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentMethod _payment = PaymentMethod.None;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Navigator.pushNamed(context, invoiceName);
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
            // ListTile(
            // leading: Image.asset(DImages.mono, width: dimensWidth()*5, height: dimensHeight()*5,),
            // title: Text(translate(context, 'momo_e_wallet'),),
            //   trailing: Rad,
            // ),
            ListTile(
              title: Text(
                translate(context, 'momo_e_wallet'),
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
                _payment = PaymentMethod.Momo;
              }),
              dense: true,
              visualDensity: const VisualDensity(vertical: 0),
              contentPadding: EdgeInsets.symmetric(
                horizontal: dimensWidth(),
                vertical: dimensHeight(),
              ),
              leading: Image.asset(
                DImages.mono,
                width: dimensWidth() * 4,
                height: dimensHeight() * 4,
              ),
              trailing: Radio<PaymentMethod>(
                value: PaymentMethod.Momo,
                groupValue: _payment,
                onChanged: (PaymentMethod? value) {
                  setState(() {
                    _payment = value ?? PaymentMethod.None;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
