// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

const DATE_FORMAT = "EEEE, dd MMMM yyyy";
const DAY_MONTH_YEAR = "dd/MM/yyyy";
const MONTH_YEAR_FORMAT = "MMMM yyyy";
const EEE_FORMAT = "EEE";
const DAY_FORMAT = "d";
const MONTH_FORMAT = "MMMM";
const yMMMMd_en = "MMMM d, y";
const yMMMMd_vn = "dd MMMM yyyy";

String formatFullDate(BuildContext context, DateTime date) {
  var formatter =
      DateFormat(DATE_FORMAT, Localizations.localeOf(context).toString());
  return formatter.format(date);
}

String formatDayMonthYear(BuildContext context, DateTime date) {
  var formatter =
      DateFormat(DAY_MONTH_YEAR, Localizations.localeOf(context).toString());
  return formatter.format(date);
}

String formatDateToMonthYear(BuildContext context, DateTime date) {
  return DateFormat(
          MONTH_YEAR_FORMAT, Localizations.localeOf(context).toString())
      .format(date);
}

String formatToDate(BuildContext context, DateTime date) {
  return DateFormat(EEE_FORMAT, Localizations.localeOf(context).toString())
      .format(date);
}

String formatDay(BuildContext context, DateTime date) {
  return DateFormat(DAY_FORMAT, Localizations.localeOf(context).toString())
      .format(date);
}

String formatMonth(BuildContext context, DateTime date) {
  return DateFormat(MONTH_FORMAT, Localizations.localeOf(context).toString())
      .format(date);
}

String formatyMMMMd(BuildContext context, DateTime date) {
  if (Localizations.localeOf(context) == const Locale('vi')) {
    return DateFormat(yMMMMd_vn, Localizations.localeOf(context).toString())
        .format(date);
  } else {
    return DateFormat(yMMMMd_en, Localizations.localeOf(context).toString())
        .format(date);
  }
}

DateTime? convertStringToDateTime(String? dateString) {
  if (dateString == null) {
    return null;
  }
  DateTime dateTime = DateTime.parse(dateString);
  return dateTime;
}

calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}