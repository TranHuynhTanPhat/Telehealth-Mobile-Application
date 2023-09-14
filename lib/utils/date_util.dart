// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

const DATE_FORMAT = "EEEE, dd MMMM yyyy";
const DATE_FORMAT_MONGODB = "yyyy-MM-ddTHH:mm:ss.mmm";
const MONTH_YEAR_FORMAT = "MMMM yyyy";
const EEE_FORMAT ="EEE";
const DAY_FORMAT ="d";
const MONTH_FORMAT = "MMMM";

String formatFullDate(BuildContext context,DateTime date) {
  var formatter = DateFormat(DATE_FORMAT, Localizations.localeOf(context).toString());
  return formatter.format(date);
}

String formatDateToMonthYear(BuildContext context, DateTime date) {
  return DateFormat(MONTH_YEAR_FORMAT , Localizations.localeOf(context).toString()).format(date);
}

String formatToDate(BuildContext context,DateTime date){
  return DateFormat(EEE_FORMAT, Localizations.localeOf(context).toString()).format(date);
}

String formatDay(BuildContext context,DateTime date){
  return DateFormat(DAY_FORMAT, Localizations.localeOf(context).toString()).format(date);
}

String formatMonth(BuildContext context,DateTime date){
  return DateFormat(MONTH_FORMAT, Localizations.localeOf(context).toString()).format(date);
}

String dateToJsonFormatMongoDB(DateTime? date) {
  if (date == null) {
    return "";
  }
  var duration = date.timeZoneOffset;
  if (duration.isNegative) {
    return ("${DateFormat(DATE_FORMAT_MONGODB).format(date)}-${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
  } else {
    return ("${DateFormat(DATE_FORMAT_MONGODB).format(date)}+${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
  }
}

DateTime? convertStringToDateTime(String? dateString) {
  if (dateString == null) {
    return null;
  }
  DateTime dateTime = DateTime.parse(dateString);
  return dateTime;
}
