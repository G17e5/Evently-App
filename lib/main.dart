import 'package:event_app/config/theme/theme_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(){
  runApp(EventApp());
}
class EventApp extends StatelessWidget {
  const EventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393,841),
      minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child) =>MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute :RouteManager.mainLayout ,
          onGenerateRoute :RouteManager.router ,
          theme:ThemeManager.light ,
          darkTheme:ThemeManager.light ,
          themeMode:ThemeMode.light ,
          locale: Locale("en"),
        ),
    );
  }
}

