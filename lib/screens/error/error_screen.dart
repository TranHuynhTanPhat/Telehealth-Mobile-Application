import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/cubits/cubit_error/error_cubit.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/res/images.dart';
import 'package:healthline/res/language/app_localizations.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});
  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  ErrorCubit errorCubit = ErrorCubit();
  @override
  void initState() {
    errorCubit.getURL();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ErrorCubit, ErrorState>(
      bloc: errorCubit,
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                state.runtimeType == ErrorLoaded
                    ? Lottie.network(
                        (state as ErrorLoaded).url,
                      )
                    : Image.asset(DImages.placeholder),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 5),
                  child: Text(
                    AppLocalizations.of(context).translate(""),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xffff9494))),
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
