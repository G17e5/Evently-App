import 'package:event_app/models/category_model.dart';
import 'package:flutter/material.dart';

class EventModel {
  String userId;

  String eventId;
  CategoryModel category;
  String title;
  String description;
  DateTime dateTime;
  double lat = 0.0;
  double long = 0.0;

  EventModel({
    required this.userId,
    required this.eventId,
    required this.dateTime,
    required this.category,
    required this.title,
    required this.description,
    required this.lat,
    required this.long
  });

  EventModel.fromJson(Map<String, dynamic> json, BuildContext context) :
        this(
          eventId: json["eventId"],
          userId: json["userId"],
          category: CategoryModel.getCategories(context).firstWhere((
              category) => category.id == json["categoryId"]),
          title: json["title"],
          description: json["description"],
          dateTime: json["dateTime"].toDate(),
        lat: json['lat'] ?? 0.0,
        long: json['long'] ?? 0.0
      );


  Map<String, dynamic> toJson() =>
      {
        "eventId": eventId,
        "userId": userId,
        "categoryId": category.id,
        "title": title,
        "description": description,
        "dateTime": dateTime,
        "lat": lat,
        "long":long
      };
}
