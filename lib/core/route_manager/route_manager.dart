import 'package:event_app/feature/auth/login/login.dart';
import 'package:event_app/feature/auth/register/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class RouteManager{
  static const String register = "/register";
  static const String login = "/login";



  static Route? router(RouteSettings setting)
  {
    switch(setting.name)
        {
      case register:{
        return CupertinoPageRoute(builder: (context)=> Register());
      }
      case login:{
        return CupertinoPageRoute(builder: (context)=> Login());
      }
    }
  }


}