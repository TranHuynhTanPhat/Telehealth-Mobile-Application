String convertIntToTime(int number) {
  int hour = number ~/ 2;

  if (number % 2 == 1) {
    return '$hour:30';
  } else {
    return '$hour:00';
  }
}
