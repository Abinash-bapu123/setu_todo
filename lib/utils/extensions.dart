import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get monthName {
    return DateFormat.MMMM().format(this);
  }

  String get shortMonthName {
    return DateFormat.MMM().format(this);
  }

  String get dayOfWeek {
    return DateFormat.EEEE().format(this);
  }

  String get shortDayOfWeek {
    return DateFormat.E().format(this);
  }

  String get formattedDate {
    return DateFormat('dd-MM-yyyy').format(this);
  }
}
