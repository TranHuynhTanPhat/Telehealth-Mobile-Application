import 'dart:developer';

import 'package:flutter/foundation.dart';

void logPrint(Object? object) async {
  int defaultPrintLength = 1020;
  if (object == null || object.toString().length <= defaultPrintLength) {
    log("===================================================================================================");

    print(object);

    log("===================================================================================================");
  } else {
    log("===================================================================================================");
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(object.toString())
        .forEach((match) => print(match.group(0)));
    log("===================================================================================================");
  }
}
