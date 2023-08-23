// import 'package:intl/intl.dart';

// const DATE_FORMAT = "dd/MM/yyyy";
// const DATE_FORMAT_MONGODB = "yyyy-MM-ddTHH:mm:ss.mmm";

// String formatDateBirthday(DateTime birthday) {
//   var formatter = DateFormat(DATE_FORMAT);
//   return formatter.format(birthday);
// }

// String dateToJsonFormatMongoDB(DateTime? date) {
//   if (date == null) {
//     return "";
//   }
//   var duration = date.timeZoneOffset;
//   if (duration.isNegative) {
//     return ("${DateFormat(DATE_FORMAT_MONGODB).format(date)}-${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
//   } else {
//     return ("${DateFormat(DATE_FORMAT_MONGODB).format(date)}+${duration.inHours.toString().padLeft(2, '0')}${(duration.inMinutes - (duration.inHours * 60)).toString().padLeft(2, '0')}");
//   }
// }

// DateTime? convertStringToDateTime(String? dateString) {
//   if (dateString == null) {
//     return null;
//   }
//   DateTime dateTime = DateTime.parse(dateString);
//   return dateTime;
// }
