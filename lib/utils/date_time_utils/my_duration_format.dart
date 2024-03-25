import 'package:intl/intl.dart';

String formatDuration(Duration duration, {int type = 0}) {
  String day = "", hour = "", minute = "", second = "";

  if (duration.inDays > 0) {
    day = (duration.inDays).toString().padLeft(2, '0');
  }

  if (duration.inHours > 0) {
    hour = (duration.inHours % 24).toString().padLeft(2, '0');
  }

  if (duration.inMinutes > 0) {
    minute = (duration.inMinutes % 60).toString().padLeft(2, '0');
  }

  if (duration.inSeconds > 0) {
    second = (duration.inSeconds % 60).toString().padLeft(2, '0');
  }

  if (type == 0) {
    String date = "";

    if (day.isNotEmpty) date = "$date${day}d";

    if (hour.isNotEmpty) date = "$date $hour:";

    if (minute.isNotEmpty) date = "$date$minute:";

    if (second.isNotEmpty) date = "$date$second";

    return date;
  }

  if (type == 1) {
    String date = "";

    if (hour.isNotEmpty) date = "$date${hour}h";

    if (minute.isNotEmpty) date = "$date${minute}m";

    return date;
  }

  if (type == 2) {
    String date = "";

    if (hour.isNotEmpty) date = "$date${hour}h";

    if (minute.isNotEmpty) date = "$date${minute}m";

    if (second.isNotEmpty) date = "$date${second}s";

    return date;
  }

  return "";
}

// https://stackoverflow.com/questions/70594474/get-the-dates-of-given-week-number-in-flutter
DateTime getDatesFromWeekNumber(DateTime date) {
  int weekNumber = getWeekNumber(date);

  // first day of the year
  final DateTime firstDayOfYear = DateTime.utc(date.year, 1, 1);

  // first day of the year weekday (Monday, Tuesday, etc...)
  final int firstDayOfWeek = firstDayOfYear.weekday;

  // Calculate the number of days to the first day of the week (an offset)
  final int daysToFirstWeek = (8 - firstDayOfWeek) % 7;

  // Get the date of the first day of the week
  final DateTime firstDayOfGivenWeek =
      firstDayOfYear.add(Duration(days: daysToFirstWeek + (weekNumber - 1) * 7));

  // Get the last date of the week
  // final DateTime lastDayOfGivenWeek = firstDayOfGivenWeek.add(const Duration(days: 6));

  // Return a WeekDates object containing the first and last days of the week
  return firstDayOfGivenWeek;
}

// https://stackoverflow.com/questions/49393231/how-to-get-day-of-year-week-of-year-from-a-datetime-dart-object
int getWeekNumber(DateTime date) {
  int dayOfYear = int.parse(DateFormat("D").format(date));
  int woy = ((dayOfYear - date.weekday + 10) / 7).floor();

  if (woy < 1) {
    woy = numOfWeeks(date.year - 1);
  } else if (woy > numOfWeeks(date.year)) {
    woy = 1;
  }

  // If is Sunday add a week
  // So the week start at Sunday
  if (date.weekday == 7) {
    woy++;
  }

  return woy;
}

int numOfWeeks(int year) {
  DateTime dec28 = DateTime(year, 12, 28);
  int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
  return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
}
