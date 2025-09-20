import 'package:event_app/models/category_model.dart';
import 'package:flutter/material.dart';

class EventModel {
  CategoryModel category;
  String title;
  String description;
  DateTime dateTime;

  TimeOfDay timeOfDay;

  EventModel({
    required this.dateTime,
    required this.category,
    required this.title,
    required this.description,
    required this.timeOfDay,
  });
}
