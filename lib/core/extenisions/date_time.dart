import 'package:intl/intl.dart';

extension DateTimeEx on DateTime {
  String get toFormattedTime {
    return DateFormat('h:mm a').format(this);
  }
}
