String convertIntToTime(int number) {
  if (number < 0) {
    return "0:00";
  }
  int hour = number ~/ 2;

  if (number % 2 == 1) {
    return '$hour:30';
  } else {
    return '$hour:00';
  }
}
