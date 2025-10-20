import 'package:event_app/feature/auth/login/login.dart';
import 'package:event_app/feature/auth/register/register.dart';
import 'package:event_app/feature/create_event/create_event.dart';
import 'package:event_app/feature/evently_details/eventDetails.dart';
import 'package:event_app/feature/main_layout/main_layout.dart';
import 'package:event_app/models/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class RouteManager {
  static const String register = "/register";
  static const String login = "/login";
  static const String mainLayout = "/mainLayout";
  static const String createEvent = "/createEvent";
  static const String eventDetails = "/eventDetails";

  static Route? router(RouteSettings setting) {
    switch (setting.name) {
      case register:
        {
          return CupertinoPageRoute(builder: (context) => Register());
        }
      case login:
        {
          return CupertinoPageRoute(builder: (context) => Login());
        }
      case mainLayout:
        {
          return CupertinoPageRoute(builder: (context) => MainLayout());
        }
      case createEvent:
        {
          return CupertinoPageRoute(builder: (context) => CreateEvent());
        }
      case eventDetails:
        {
          return CupertinoPageRoute(builder: (context) {
            final event = setting.arguments as EventModel;
            return  EventDetails(event: event);

          });
        }
    }
  }
}
