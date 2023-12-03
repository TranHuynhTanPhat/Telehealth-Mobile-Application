import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/translate.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      extendBody: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
            dimensWidth() * 10, 0, dimensWidth() * 10, dimensHeight() * 3),
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
              // Navigator.pushNamed(context, invoiceName);
            }),
      ),
      appBar: AppBar(
        title: Text(
          translate(context, 'invoice'),
        ),
      ),
      body: AbsorbPointer(
        // absorbing: state is FetchScheduleLoading && state.schedules.isEmpty,
        absorbing: false,
        child: ListView(
          padding: EdgeInsets.symmetric(
              vertical: dimensHeight(), horizontal: dimensWidth() * 3),
          children: [
            Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(dimensWidth() * 2),
                border: Border.all(width: 2, color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${translate(context, 'invoice_code')}: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Expanded(
                        child: Text(
                          "DJFKSDLJFK",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dimensHeight() * .5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${translate(context, 'created_at')}: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Expanded(
                        child: Text(
                          "24/11/2023",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${translate(context, 'doctor')}: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Expanded(
                        child: Text(
                          "Lê Đình Trường",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dimensHeight() * .5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${translate(context, 'day')}: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Expanded(
                        child: Text(
                          "12/01/2023",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dimensHeight() * .5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${translate(context, 'time')}: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Expanded(
                        child: Text(
                          "11:00 AM",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: dimensHeight() * .5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${translate(context, 'total')}: ',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Expanded(
                        child: Text(
                          "200.000",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
