import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class EventDetailsProvider extends ChangeNotifier {
  String formatEventDate(DateTime date) {
    DateFormat formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }

  String formatEventTime(DateTime time) {
    DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(time);  }
}
