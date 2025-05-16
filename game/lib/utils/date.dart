import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../.gen/i18n/strings.g.dart';

// ignore: non_constant_identifier_names
String CFDateFormatter(String dateFormatPattern, DateTime date) {
  return DateFormat(
    dateFormatPattern,
    LocaleSettings.currentLocale.languageCode,
  ).format(date);
}

// ignore: non_constant_identifier_names
String CFApiDateFormatter(DateTime date) {
  return DateFormat('yyyy-MM-ddTHH:mm:ss').format(date);
}

extension DurationExtension on Duration {
  int get inMonths => inDays ~/ 30;
}

extension DateTimeExtension on DateTime {
  TimeOfDay timeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }

  DateTime today() {
    return DateTime(year, month, day);
  }

  DateTime subtractMonths(int count) {
    return DateTimeCalculator.subtractMonths(this, count);
  }

  DateTime addMonths(int count) {
    return DateTimeCalculator.addMonths(this, count);
  }

  TimeOfDay getTimeOfDayOnly() {
    return TimeOfDay(hour: hour, minute: minute);
  }

  bool isSameDay(DateTime? other) {
    if (other == null) {
      return false;
    }
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  bool isBetween(DateTime start, DateTime end) {
    return DateTimeCalculator.isBetween(this, start, end);
  }

  int getDaysInMonth() {
    return DateTimeCalculator.getDaysCountInMonth(year, month);
  }

  int getWeekNumber() {
    return DateTimeCalculator.getWeekNumber(this);
  }

  DateTime roundToFirstDayOfYear() {
    return DateTimeCalculator.roundToFirstDayOfYear(this);
  }

  bool isFirstDayOfYear() {
    return month == 1 && day == 1;
  }

  DateTime roundToDayStart() {
    return DateTimeCalculator.roundToDayStart(this);
  }

  DateTime roundToDayEnd() {
    return DateTimeCalculator.roundToDayEnd(this);
  }

  DateTime roundToLastDayOfYear() {
    return DateTimeCalculator.roundToLastDayOfYear(this);
  }

  bool isLastDayOfYear() {
    return month == 12 && day == 31;
  }

  DateTime roundToFirstDayOfMonth() {
    return DateTimeCalculator.roundToFirstDayOfMonth(this);
  }

  bool isFirstDayOfMonth() {
    return day == 1;
  }

  DateTime roundToLastDayOfMonth() {
    return DateTimeCalculator.roundToLastDayOfMonth(this);
  }

  bool isLastDayOfMonth() {
    final daysInMonth = getDaysInMonth();
    return day == daysInMonth;
  }

  DateTime roundToFirstDayOfWeek() {
    return DateTimeCalculator.roundToFirstDayOfWeek(this);
  }

  bool isFirstDayOfWeek() {
    return weekday == DateTime.monday;
  }

  DateTime roundToLastDayOfWeek() {
    return DateTimeCalculator.roundToLastDayOfWeek(this);
  }

  bool isLastDayOfWeek() {
    return weekday == DateTime.sunday;
  }

  /// Возвращает первый день следующего месяца
  DateTime nextMonthDay(int monthCount) {
    DateTime date = roundToFirstDayOfMonth();

    for (int i = 0; i < monthCount; i++) {
      final daysInMonth = date.getDaysInMonth();
      date = date.add(Duration(days: daysInMonth));
    }
    return date;
  }
}

final class DateTimeCalculator {
  static DateTime subtractMonths(DateTime date, int count) {
    assert(count >= 0);

    count = count * -1;

    int newYear =
        date.year + count ~/ 12 + ((date.month + count % 12) > 12 ? 1 : 0);

    int newMonth = (date.month + count) % 12 == 0
        ? 12
        : (date.month + count) % 12;

    DateTime newData = DateTime(newYear, newMonth, date.day);

    return newData;
  }

  static DateTime addMonths(DateTime date, int count) {
    assert(count >= 0);

    int newYear =
        date.year + count ~/ 12 + ((date.month + count % 12) > 12 ? 1 : 0);

    int newMonth = (date.month + count) % 12 == 0
        ? 12
        : (date.month + count) % 12;

    DateTime newData = DateTime(newYear, newMonth, date.day);

    return newData;
  }

  static DateTime roundToDayStart(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime roundToDayEnd(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  static DateTime roundToFirstDayOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }

  static DateTime roundToLastDayOfYear(DateTime date) {
    return DateTime(date.year, 12, 31);
  }

  static DateTime roundToFirstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime roundToLastDayOfMonth(DateTime date) {
    final daysInMonth = getDaysCountInMonth(date.year, date.month);
    return DateTime(date.year, date.month, daysInMonth);
  }

  static DateTime roundToFirstDayOfWeek(DateTime date) {
    final dayOfWeek = date.weekday;
    final daysToSubtract = dayOfWeek - 1;
    return date.subtract(Duration(days: daysToSubtract));
  }

  static DateTime roundToLastDayOfWeek(DateTime date) {
    final dayOfWeek = date.weekday;
    final daysToAdd = 7 - dayOfWeek;
    return date.add(Duration(days: daysToAdd));
  }

  static int getDaysCountInMonth(int year, int month) {
    List<int> daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if (month == 2 && isLeapYear(year)) {
      return 29;
    }

    return daysInMonth[month - 1];
  }

  static int getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);

    final firstSundayOfYear = firstDayOfYear.roundToLastDayOfWeek();
    final lastWeekDay = date.roundToLastDayOfWeek();

    final diff = lastWeekDay.difference(firstSundayOfYear).inDays;

    return (diff ~/ 7) + 1;
  }

  static bool isLeapYear(int year) {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  static bool isBetween(DateTime date, DateTime start, DateTime end) {
    return date.isAfter(start) && date.isBefore(end);
  }
}

extension TimeOfDateExtension on TimeOfDay {
  bool isBetween(TimeOfDay being, TimeOfDay end) {
    final thisMinutes = hour * 60 + minute;
    final startMinutes = being.hour * 60 + being.minute;
    final endMinutes = end.hour * 60 + end.minute;

    return thisMinutes >= startMinutes && thisMinutes < endMinutes;
  }

  TimeOfDay difference(TimeOfDay other) {
    final thisMinutes = hour * 60 + minute;
    final otherMinutes = other.hour * 60 + other.minute;

    final diff = thisMinutes - otherMinutes;

    final hours = diff ~/ 60;
    final minutes = diff % 60;

    return TimeOfDay(hour: hours, minute: minutes);
  }

  int get inMinutes {
    return hour * 60 + minute;
  }

  String formatTime() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
