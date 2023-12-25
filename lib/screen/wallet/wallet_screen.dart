import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/wallet/components/exports.dart';
import 'package:healthline/utils/translate.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // late TextEditingController _controller;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    // _controller = TextEditingController();
    if (AppController.instance.authState == AuthState.PatientAuthorized) {
      context.read<PatientProfileCubit>().fetProfile();
    }
    if (AppController.instance.authState == AuthState.DoctorAuthorized) {
      context.read<DoctorProfileCubit>().fetchProfile();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translate(context, 'wallet'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: dimensHeight() * 2, horizontal: dimensWidth() * 3),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (AppController().authState == AuthState.DoctorAuthorized)
                const WalletCardDoctor(),
              if (AppController().authState == AuthState.PatientAuthorized)
                const WalletCardPatient(),
              // Padding(
              //   padding: EdgeInsets.only(
              //       top: dimensHeight() * 4, bottom: dimensHeight() * 1.5),
              //   child: Text(
              //     translate(context, 'recharge_withdraw'),
              //     style: Theme.of(context).textTheme.titleLarge,
              //   ),
              // ),
              
              // InkWell(
              //   splashColor: transparent,
              //   highlightColor: transparent,
              //   onTap: () {
              //     showModalBottomSheet(
              //         context: context,
              //         isScrollControlled: true,
              //         useSafeArea: true,
              //         builder: (BuildContext contextBottomSheet) {
              //           return Container(
              //             height: dimensHeight() * 60,
              //             padding: EdgeInsets.only(
              //                 top: dimensHeight() * 3,
              //                 bottom: MediaQuery.of(context).viewInsets.bottom +
              //                     dimensHeight() * 3),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.end,
              //               children: [
              //                 TabBar(
              //                   isScrollable: false,
              //                   splashBorderRadius:
              //                       BorderRadius.circular(dimensWidth() * 3),
              //                   splashFactory: InkRipple.splashFactory,
              //                   indicatorPadding:
              //                       EdgeInsets.only(bottom: dimensWidth() * .5),
              //                   indicatorColor: primary,
              //                   labelStyle:
              //                       Theme.of(context).textTheme.titleSmall,
              //                   labelColor: primary,
              //                   unselectedLabelColor: black26,
              //                   controller: tabController,
              //                   tabs: [
              //                     Tab(
              //                       text: translate(context, 'recharge'),
              //                     ),
              //                     Tab(
              //                       text: translate(context, 'withdraw'),
              //                     ),
              //                   ],
              //                 ),
              //                 Expanded(
              //                   child: TabBarView(
              //                     controller: tabController,
              //                     children: [
              //                       Container(
              //                         alignment: Alignment.center,
              //                         padding: EdgeInsets.symmetric(
              //                             vertical: dimensHeight() * 3,
              //                             horizontal: dimensWidth() * 3),
              //                         child: Form(
              //                           child: Column(
              //                             children: [
              //                               TextFieldWidget(
              //                                 validate: (value) {
              //                                   try {
              //                                     if (num.parse(value!) <
              //                                         10000) {
              //                                       return '${translate(context, 'amount_to_top_up')} ${translate(context, 'must_be_greater_than_or_equal_to')}10.000₫';
              //                                     } else {
              //                                       throw 'error';
              //                                     }
              //                                   } catch (error) {
              //                                     return null;
              //                                   }
              //                                 },
              //                                 controller: _controller,
              //                                 label: translate(
              //                                     context, 'amount_to_top_up'),
              //                                 hint: '0',
              //                                 suffix: Padding(
              //                                   padding: EdgeInsets.only(
              //                                       right: dimensWidth() * .5),
              //                                   child: Text(
              //                                     '₫',
              //                                     style: Theme.of(context)
              //                                         .textTheme
              //                                         .bodyLarge
              //                                         ?.copyWith(
              //                                             fontWeight:
              //                                                 FontWeight.bold),
              //                                   ),
              //                                 ),
              //                                 textInputType:
              //                                     TextInputType.number,
              //                                 autovalidateMode: AutovalidateMode
              //                                     .onUserInteraction,
              //                               ),
              //                               SizedBox(
              //                                 height: dimensHeight(),
              //                               ),
              //                               SizedBox(
              //                                 width: double.infinity,
              //                                 child: ElevatedButtonWidget(
              //                                     text: translate(
              //                                         context, 'recharge'),
              //                                     onPressed: () {}),
              //                               )
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                       Container(
              //                         alignment: Alignment.center,
              //                         padding: EdgeInsets.symmetric(
              //                             vertical: dimensHeight() * 3,
              //                             horizontal: dimensWidth() * 3),
              //                         child: Form(
              //                           child: Column(
              //                             children: [
              //                               TextFieldWidget(
              //                                 validate: (value) {
              //                                   try {
              //                                     if (num.parse(value!) <
              //                                         10000) {
              //                                       return '${translate(context, 'amount_to_withdraw')} ${translate(context, 'must_be_greater_than_or_equal_to')}10.000₫';
              //                                     } else {
              //                                       throw 'error';
              //                                     }
              //                                   } catch (error) {
              //                                     return null;
              //                                   }
              //                                 },
              //                                 controller: _controller,
              //                                 label: translate(
              //                                     context, 'amount_to_top_up'),
              //                                 hint: '0',
              //                                 suffix: Padding(
              //                                   padding: EdgeInsets.only(
              //                                       right: dimensWidth() * .5),
              //                                   child: Text(
              //                                     '₫',
              //                                     style: Theme.of(context)
              //                                         .textTheme
              //                                         .bodyLarge
              //                                         ?.copyWith(
              //                                             fontWeight:
              //                                                 FontWeight.bold),
              //                                   ),
              //                                 ),
              //                                 textInputType:
              //                                     TextInputType.number,
              //                                 autovalidateMode: AutovalidateMode
              //                                     .onUserInteraction,
              //                               ),
              //                               SizedBox(
              //                                 height: dimensHeight(),
              //                               ),
              //                               SizedBox(
              //                                 width: double.infinity,
              //                                 child: ElevatedButtonWidget(
              //                                     text: translate(
              //                                         context, 'withdraw'),
              //                                     onPressed: () {}),
              //                               )
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           );
              //         });
              //   },
              //   child: OptionCard(
              //     name: '${translate(context, 'wallet')} Momo',
              //     description:
              //         translate(context, 'recharge_via_momo_application'),
              //     icon: SizedBox(
              //       width: dimensIcon(),
              //       height: dimensIcon(),
              //       child: Image.asset(
              //         DImages.mono,
              //         fit: BoxFit.cover,
              //         scale: 1,
              //         width: dimensIcon(),
              //         height: dimensIcon(),
              //       ),
              //     ),
              //   ),
              // ),

              // Padding(
              //   padding: EdgeInsets.only(
              //       top: dimensHeight() * 4,),
              //   child: Text(
              //     translate(context, 'transaction_history'),
              //     style: Theme.of(context).textTheme.titleLarge,
              //   ),
              // ),
              // TabBar(
              //   controller: tabController,
              //   tabs: const [
              //     Tab(
              //       icon: Icon(Icons.cloud_outlined),
              //     ),
              //     Tab(
              //       icon: Icon(Icons.beach_access_sharp),
              //     ),
              //   ],
              // ),
              // Expanded(
              //   child: TabBarView(
              //     controller: tabController,
              //     children: const <Widget>[
              //       Center(
              //         child: Text("It's cloudy here"),
              //       ),
              //       Center(
              //         child: Text("It's rainy here"),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
