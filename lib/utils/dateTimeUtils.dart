import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:mg_dashboard/utils/extensions.dart';

String defaultDateFormat = "yyyy-MM-dd";
String defaultDateViewFormat = "dd-MM-yyyy";
String getAmPmTimeFromTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

  final format = DateFormat('hh:mm a');
  final amPm = format.format(dateTime);

  return amPm;
}

int calenderTypeDay = 1;
int calenderTypeWeek = 2;
int calenderTypeMonth = 3;
int calenderTypeYear = 4;
int calenderTypeCustom = 5;

class DateTimeUtils {
  static String getDateFromDays(int totalDays) {
    String date = DateTime.now()
        .subtract(Duration(days: totalDays))
        .toString()
        .split(" ")[0];

    return date;
  }

  static int getDays(String date) {
    DateTime startDate = DateFormat(defaultDateViewFormat).parse(date);
    DateTime endDate = DateTime.now();
    int days = endDate.difference(startDate).inDays;
    return days;
  }

  static int yearsMonthsToDays(String yr, String mon, String day) {
    int years = int.tryParse(yr) ?? 0;
    int months = int.tryParse(mon) ?? 0;
    int days = int.tryParse(day) ?? 0;

    // Define the number of days in a non-leap year and a leap year
    final daysInYear = 365;
    // final daysInLeapYear = 366;

    // // Define the number of days in each month
    final daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    // Calculate the number of days in the years
    int totalDays = years * daysInYear;

    // If there are any months, add the days for those months
    if (months > 0) {
      // Check if the current year is a leap year
      bool isLeapYear = DateTime.now().year % 4 == 0 &&
          (DateTime.now().year % 100 != 0 || DateTime.now().year % 400 == 0);

      // Calculate the days in the partial year
      for (int i = 0; i < months; i++) {
        totalDays += daysInMonth[i];
        if (isLeapYear && i == 1) {
          totalDays++; // Add an extra day for February in a leap year
        }
      }
    }

    // Add the days to the total
    totalDays += days;
    final dateTime = DateTime.now()
        .difference(DateTime(DateTime.now().year - years,
            DateTime.now().month - months, DateTime.now().day - days))
        .inDays;
    print("aaa" + dateTime.toString() + "_" + totalDays.toString());
    // print(dateTime.year.toString()+"-"+dateTime.month.toString()+"-"+dateTime.day.toString()+"----");
    return dateTime;
  }

  static (int year, int month, int day) getYearAndMonthFromDays(int totaldays) {
    DateTime startDate = DateTime.now().subtract(Duration(days: totaldays));
    DateTime endDate = DateTime.now();
    if (startDate.isAfter(endDate)) {
      final temp = startDate;
      startDate = endDate;
      endDate = temp;
    }

    int years = endDate.year - startDate.year;
    int months = endDate.month - startDate.month;
    int days = endDate.day - startDate.day;

    if (days < 0) {
      months--;
      days += DateTime(startDate.year, startDate.month + 1, 0).day;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    print(years.toString() +
        "-" +
        months.toString() +
        "-" +
        days.toString() +
        "----");

    return (years, months, days);
  }

  static (List<String>, List<DateTime>) getDatesBetweenTwoDates(
      DateTime startDate, DateTime endDate) {
    List<String> dates = [];
    List<DateTime> dateTime = [];
    for (var i = startDate;
        i.isBefore(endDate) || i.isAtSameMomentAs(endDate);
        i = i.add(Duration(days: 1))) {
      dates.add(i.toString().toServerDateOnly());
      dateTime.add(i);
    }
    return (dates, dateTime);
  }

  static String getDayFromDate(String date,
      {bool showFullDayName = false, bool showIsToday = true}) {
    String dayName = "";
    if (!date.isNullOrEmpty()) {
      if (showFullDayName) {
        dayName = (showIsToday &&
                date.toDateOnly() == DateTime.now().toString().toDateOnly())
            ? "Today"
            : DateFormat("EEEE").format(DateTime.parse(date));
      } else {
        dayName = (showIsToday &&
                date.toDateOnly() == DateTime.now().toString().toDateOnly())
            ? "Today"
            : DateFormat("E").format(DateTime.parse(date));
      }
    }

    return dayName;
  }

  static String getTimeWithAmPmFromDatetime(String? dateTime) {
    String time = "";
    if (!dateTime.isNullOrEmpty()) {
      time = DateFormat("hh:mm a").format(DateTime.parse(dateTime!));
    }

    return time;
  }

  static DateTime getFromDate(int? calenderType) {
    // calenderType 1 = day
    // calenderType 2 = week
    // calenderType 3 = month
    // calenderType 4 = year
    // calenderType 5 = custom

    DateTime lastDayOfMonth =
        new DateTime(DateTime.now().year, DateTime.now().month, 0);
    DateTime lastYear = new DateTime(DateTime.now().year, 1, 0);

    if (calenderType == 1) {
      DateTime today = new DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      return today;
    } else if (calenderType == 2) {
      DateTime weekDate = DateTime.now().subtract(Duration(days: 7));

      if (lastDayOfMonth.isBefore(weekDate)) {
        print('before' + weekDate.toString());

        return weekDate;
      } else {
        print('after' + weekDate.toString());
        return lastDayOfMonth.add(Duration(days: 1));
      }
    } else if (calenderType == 3) {
      int totalDays = DateTimeRange(
              start: DateTime(DateTime.now().year, DateTime.now().month, 1),
              end: DateTime(DateTime.now().year, DateTime.now().month + 1))
          .duration
          .inDays;

      DateTime monthDate = DateTime.now().subtract(Duration(days: totalDays));

      if (lastDayOfMonth.isBefore(monthDate)) {
        print('before' + monthDate.toString());

        return monthDate;
      } else {
        print('after' + monthDate.toString());
        return lastDayOfMonth.add(Duration(days: 1));
      }
    } else if (calenderType == 4) {
      int totalDays = DateTimeRange(
              start: DateTime(DateTime.now().year, 1, 1),
              end: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day))
          .duration
          .inDays;

      DateTime yearDate = DateTime.now().subtract(Duration(days: totalDays));

      if (lastYear.isBefore(yearDate)) {
        print('before' + yearDate.toString());

        return yearDate;
      } else {
        print('after' + yearDate.toString());
        return lastYear.add(Duration(days: 1));
      }
    } else {
      return DateTime.now();
    }
  }

  static Future<DateTime?> selectDate(BuildContext context, DateTime _date,
      {String helpText = "Select date"}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime.now().add(Duration(days: 400)),
        helpText: helpText,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.lightBlue.shade900, // header background color
                  onPrimary: Colors.white, // header text color
                  onSurface: Colors.lightBlue.shade900, // body text color
                ),
              ),
              child: child!);
        });

    return picked;
  }
}

class TimeTextInputFormatter extends TextInputFormatter {
  RegExp _exp = RegExp(r'^[0-9:]+$');
  TimeTextInputFormatter() {
    _exp = RegExp(r'^[0-9:]+$');
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_exp.hasMatch(newValue.text)) {
      TextSelection newSelection = newValue.selection;

      String value = newValue.text;
      String newText;

      String leftChunk = '';
      String rightChunk = '';

      if (value.length >= 8) {
        if (value.substring(0, 7) == '00:00:0') {
          leftChunk = '00:00:';
          rightChunk = value.substring(leftChunk.length + 1, value.length);
        } else if (value.substring(0, 6) == '00:00:') {
          leftChunk = '00:0';
          rightChunk = value.substring(6, 7) + ":" + value.substring(7);
        } else if (value.substring(0, 4) == '00:0') {
          leftChunk = '00:';
          rightChunk = value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7);
        } else if (value.substring(0, 3) == '00:') {
          leftChunk = '0';
          rightChunk = value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7, 8) +
              value.substring(8);
        } else {
          leftChunk = '';
          rightChunk = value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7);
        }
      } else if (value.length == 7) {
        if (value.substring(0, 7) == '00:00:0') {
          leftChunk = '';
          rightChunk = '';
        } else if (value.substring(0, 6) == '00:00:') {
          leftChunk = '00:00:0';
          rightChunk = value.substring(6, 7);
        } else if (value.substring(0, 1) == '0') {
          leftChunk = '00:';
          rightChunk = value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7);
        } else {
          leftChunk = '';
          rightChunk = value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7) +
              ":" +
              value.substring(7);
        }
      } else {
        leftChunk = '00:00:0';
        rightChunk = value;
      }

      if (oldValue.text.isNotEmpty && oldValue.text.substring(0, 1) != '0') {
        if (value.length > 7) {
          return oldValue;
        } else {
          leftChunk = '0';
          rightChunk = value.substring(0, 1) +
              ":" +
              value.substring(1, 2) +
              value.substring(3, 4) +
              ":" +
              value.substring(4, 5) +
              value.substring(6, 7);
        }
      }

      newText = leftChunk + rightChunk;

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(newText.length, newText.length),
        extentOffset: math.min(newText.length, newText.length),
      );

      return TextEditingValue(
        text: newText,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return oldValue;
  }

  static DateTime? getFromDate(int? calenderType) {
    // calenderType 1 = day
    // calenderType 2 = week
    // calenderType 3 = month
    // calenderType 4 = year

    DateTime lastDayOfMonth =
        new DateTime(DateTime.now().year, DateTime.now().month, 0);
    DateTime lastYear = new DateTime(DateTime.now().year, 1, 0);

    if (calenderType == 1) {
      DateTime today = new DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      return today;
    } else if (calenderType == 2) {
      DateTime weekDate = DateTime.now().subtract(Duration(days: 7));

      if (lastDayOfMonth.isBefore(weekDate)) {
        print('before' + weekDate.toString());

        return weekDate;
      } else {
        print('after' + weekDate.toString());
        return lastDayOfMonth.add(Duration(days: 1));
      }
    } else if (calenderType == 3) {
      int totalDays = DateTimeRange(
              start: DateTime(DateTime.now().year, DateTime.now().month, 1),
              end: DateTime(DateTime.now().year, DateTime.now().month + 1))
          .duration
          .inDays;

      DateTime monthDate = DateTime.now().subtract(Duration(days: totalDays));

      if (lastDayOfMonth.isBefore(monthDate)) {
        print('before' + monthDate.toString());

        return monthDate;
      } else {
        print('after' + monthDate.toString());
        return lastDayOfMonth.add(Duration(days: 1));
      }
    } else if (calenderType == 4) {
      int totalDays = DateTimeRange(
              start: DateTime(DateTime.now().year, 1, 1),
              end: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day))
          .duration
          .inDays;

      DateTime yearDate = DateTime.now().subtract(Duration(days: totalDays));

      if (lastYear.isBefore(yearDate)) {
        print('before' + yearDate.toString());

        return yearDate;
      } else {
        print('after' + yearDate.toString());
        return lastYear.add(Duration(days: 1));
      }
    }
    return null;
  }
}
