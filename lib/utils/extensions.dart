import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mg_dashboard/ui/widgets/customText.dart';
import 'package:mg_dashboard/utils/dateTimeUtils.dart';

extension Customextensions on dynamic {
  double toDouble() {
    return (this != null && this!.isNotEmpty) ? double.parse(toString()) : 0;
  }
}

extension ResponsiveContext on BuildContext {
  showSnackBar(String message) {
    var snackBar = SnackBar(content: CustomText(message));
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  bool isMobile({bool isDevice = false}) => isDevice ? false : getWidth() < 650;

  bool isTablet() => getWidth() < 1100 && getWidth() >= 650;

  bool isWeb({bool isKWeb = false}) {
    bool web = (kIsWeb);
    return isKWeb ? web : getWidth() >= 1100;
  }

  double getWidth() {
    return MediaQuery.of(this).size.width;
  }

  double getHeight() {
    return MediaQuery.of(this).size.height;
  }
}

extension StringExtensions on String? {
  // String capitalize() {
  //   if (this.isEmpty) return this;
  //   return this[0].toUpperCase() + this.substring(1);
  // }

  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  bool isNullOrZero() {
    RegExp regex = RegExp(r'^0+$');

    return this == null || this!.isEmpty || regex.hasMatch(this!);
  }

  String toDateOnly() {
    if (!isNullOrEmpty()) {
      DateTime dateAndTime = DateTime.parse(this!);
      final DateFormat format;
      format = DateFormat(defaultDateViewFormat);

      final date = format.format(dateAndTime);
      return date;
    } else {
      return "";
    }
  }

  String replaceLeadingZero() {
    if (!isNullOrEmpty()) {
      return this!.replaceAll(RegExp(r'^0+(?=.)'), '');
    } else {
      return "";
    }
  }

  String toServerDateOnly() {
    DateTime dateAndTime;
    try {
      dateAndTime = DateTime.parse(this!);
    } catch (_) {
      final inputFormat = DateFormat('dd-MM-yyyy');

      dateAndTime = inputFormat.parse(this!);
    }
    final DateFormat format;
    format = DateFormat(defaultDateFormat);
    final date = format.format(dateAndTime);
    return date;
  }

  String toTimeWithAmPm() {
    if (isNullOrEmpty() || this == "00:00:00") {
      return "";
    } else {
      if (this!.contains("AM") || this!.contains("PM")) {
        return this!;
      } else {
        DateTime dateAndTime = DateTime.parse("1990-01-01 ${this!}");
        final format = DateFormat('hh:mm a');
        final date = format.format(dateAndTime);
        return date;
      }
    }
  }

  String toDateTimeWithAmPm() {
    if (isNullOrEmpty() || this == "00:00:00") {
      return "";
    } else {
      DateTime dateAndTime = DateTime.parse(this!);
      final format = DateFormat('dd-MM-yyyy hh:mm a');
      final date = format.format(dateAndTime);
      return date;
    }
  }

  String toTime24h() {
    DateTime dateAndTime = DateFormat("$defaultDateFormat hh:mm a")
        .parse("01-01-1990 ${this!}"); //eg="01-01-1990 02:04 PM"
    final format = DateFormat('HH:mm');
    final date = format.format(dateAndTime);
    return date;
  }

  String setIfNullEmpty() {
    return this == null ? "" : this!;
  }
}

extension IntExtensions on int? {
  bool isNullOrZero() {
    return this == null || this == 0;
  }

  bool isGreaterThanZero() {
    return this != null && this! > 0;
  }

  String setIfNullEmpty() {
    return this == null ? "" : toString();
  }

  int getDaysInMonth(int year, int month) {
    List<int> daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (month == 2 && (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))) {
      return 29; // February in a leap year
    }
    return daysInMonth[month - 1];
  }

  String toYearAndMonth() {
    int years = 0;
    int months = 0;
    int days = 0;
    if (!isNullOrZero()) {
      // Start from a base date
      DateTime startDate =
          DateTime(1, 1, 1); // Starting from year 1, month 1, day 1

      // Days to be added
      int daysToAdd = this!;

      // Calculate the end date
      DateTime endDate = startDate.add(Duration(days: daysToAdd));

      // Calculate years, months, and days
      years = endDate.year - startDate.year;
      months = endDate.month - startDate.month;
      days = endDate.day - startDate.day;

      if (days < 0) {
        // If days are negative, subtract one month and calculate days again
        months -= 1;
        // Handle month roll-back
        if (months < 0) {
          years -= 1;
          months += 12; // Roll back to December of the previous year
        }
        DateTime daysInPrevMonth =
            startDate.add(Duration(days: daysToAdd - days));
        days = daysInPrevMonth.day;
      }

      // Correct for the case where endDate.day is less than startDate.day
      if (endDate.day < startDate.day) {
        var tempDate = DateTime(
            endDate.year, endDate.month, 0); // Last day of the previous month
        days += tempDate.day;
      }
    }

    print("Years: $years, Months: $months, Days: $days");
    return "$years Y $months M $days D ";
  }
}

extension DoubleExtensions on double? {
  bool isNullOrZero() {
    return this == null || this == 0 || this == 0.0;
  }

  bool isGreaterThanZero() {
    return this != null && this! > 0;
  }
}
