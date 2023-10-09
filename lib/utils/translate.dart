import 'package:flutter/widgets.dart';
import 'package:healthline/res/language/app_localizations.dart';

String translate(BuildContext context, String? value){
return AppLocalizations.of(context).translate(value.toString());
}