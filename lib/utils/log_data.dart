import 'dart:developer';

void logPrint(Object? object) async {
  int defaultPrintLength = 1020;
  if (object == null || object.toString().length <= defaultPrintLength) {
    log("===================================================================================================");

    log(object.toString());
  } else {
    log("===================================================================================================");
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(object.toString())
        .forEach((match) => log(match.group(0).toString()));
  }
}
